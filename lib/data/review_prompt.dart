import 'package:in_app_review/in_app_review.dart';

import '../core/review_policy.dart';
import 'app_settings_repository.dart';

/// Ink Lab's App Store listing identifier.
const String inkLabAppStoreId = '6830184034';

/// The store's review UI, behind a seam so tests do not need a store.
abstract interface class StoreReviewer {
  /// Whether the store can show its review dialog on this device.
  Future<bool> isAvailable();

  /// Asks for the store dialog; the store decides whether it really appears.
  Future<void> requestReview();

  /// Opens the app's store listing for an explicit review action.
  Future<void> openStoreListing();
}

/// [StoreReviewer] backed by the platform's own review UI.
final class PlatformStoreReviewer implements StoreReviewer {
  const PlatformStoreReviewer();

  @override
  Future<bool> isAvailable() => InAppReview.instance.isAvailable();

  @override
  Future<void> requestReview() => InAppReview.instance.requestReview();

  @override
  Future<void> openStoreListing() =>
      InAppReview.instance.openStoreListing(appStoreId: inkLabAppStoreId);
}

/// Asks after successful work once the installation meets [ReviewPolicy].
///
/// `hasOwnData` counts saved palettes in any brand or artwork diary entries.
/// The collection is configured by every user during first-run setup, so it
/// says nothing about real use; a saved palette or diary entry is work the
/// person made. History stays local to this installation, outside backups.
class ReviewPrompt {
  ReviewPrompt({
    required this._settings,
    this._reviewer = const PlatformStoreReviewer(),
    required this._appVersion,
    DateTime Function()? clock,
    required this._hasOwnData,
  }) : _clock = clock ?? DateTime.now;

  final AppSettingsRepository _settings;
  final StoreReviewer _reviewer;
  final String _appVersion;
  final DateTime Function() _clock;
  final bool Function() _hasOwnData;
  bool _quiet = false;

  Future<void> _tail = Future<void>.value();
  Future<T> _serial<T>(Future<T> Function() job) {
    final result = _tail.then((_) => job());
    _tail = result.then<void>((_) {}, onError: (Object _) {});
    return result;
  }

  DateTime _today() {
    final local = _clock().toLocal();
    return DateTime(local.year, local.month, local.day);
  }

  bool _shouldAsk(ReviewState state, DateTime today) => ReviewPolicy.shouldAsk(
    state: state,
    today: today,
    appVersion: _appVersion,
    hasOwnData: _hasOwnData(),
    inFirstRun: !_settings.onboardingCompleted,
    quiet: _quiet,
  );

  /// Records an open day without delaying the UI or exposing storage errors.
  Future<void> recordOpen() async {
    try {
      await _serial(
        () => _settings.setReviewState(
          _settings.reviewState.withOpenOn(_today()),
        ),
      );
    } catch (_) {
      // Review tracking must never interrupt app use.
    }
  }

  /// A palette or a new diary entry was saved successfully.
  Future<void> onSuccess() async {
    try {
      final ask = await _serial(() async {
        final state = _settings.reviewState;
        if (!_shouldAsk(state, _today())) return false;
        bool available;
        try {
          available = await _reviewer.isAvailable();
        } catch (_) {
          available = false;
        }
        if (!available) {
          await _settings.setReviewState(state.withUnavailable());
          return false;
        }
        // Restore/import or first-run setup may have started during the check.
        final today = _today();
        if (!_shouldAsk(state, today)) return false;
        // Persist first: even a crash in the dialog cannot cause a second ask.
        await _settings.setReviewState(state.withRequestOn(today, _appVersion));
        return true;
      });
      // A restore or an import confirmed while the request was being written
      // still wins; the written request stays, which only asks less.
      if (ask && !_quiet) await _reviewer.requestReview();
    } catch (_) {
      // Store and storage failures must never break a successful save.
    }
  }

  /// Suppresses automatic requests for the rest of this session.
  void markQuiet() => _quiet = true;

  /// Opens the store for an explicit action, swallowing platform errors.
  Future<void> openStoreListing() async {
    try {
      await _reviewer.openStoreListing();
    } catch (_) {
      // The store may not be installed on this device.
    }
  }
}
