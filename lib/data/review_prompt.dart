import 'package:in_app_review/in_app_review.dart';

import 'app_settings_repository.dart';

/// The store's own review dialog, behind a seam so tests do not need a store.
abstract interface class StoreReviewer {
  /// Whether the store can show its review dialog on this device.
  Future<bool> isAvailable();

  /// Asks the store to show the review dialog. The store decides whether it
  /// really appears (both stores limit how often it can).
  Future<void> requestReview();
}

/// [StoreReviewer] on top of the `in_app_review` package (Play In-App Review
/// on Android, StoreKit on iOS). The app sends nothing: the store shows its
/// own dialog.
final class PlatformStoreReviewer implements StoreReviewer {
  const PlatformStoreReviewer();

  @override
  Future<bool> isAvailable() => InAppReview.instance.isAvailable();

  @override
  Future<void> requestReview() => InAppReview.instance.requestReview();
}

/// Asks for a store review once, at most, after a real milestone.
///
/// The milestones are the third saved palette and the first diary entry,
/// whichever comes first; the app calls [onPaletteSaved] and
/// [onDiaryEntrySaved] after those saves, so it is never asked on first
/// launch. Once it has been asked (the answer is kept in
/// [AppSettingsRepository.reviewPromptAsked], outside the backups) it is never
/// asked again, and an unavailable or failing store is simply skipped: no
/// error ever reaches the caller.
class ReviewPrompt {
  ReviewPrompt({
    required this._settings,
    this._reviewer = const PlatformStoreReviewer(),
  });

  /// Saved palettes (in all, over every brand) that make the milestone.
  static const int palettesMilestone = 3;

  /// After this many times the store has no review dialog (a side-loaded app,
  /// no Play), it is not asked again: every ask would be a pointless call into
  /// the store's service.
  static const int maxUnavailable = 3;

  final AppSettingsRepository _settings;
  final StoreReviewer _reviewer;

  bool _running = false;

  /// A palette was just saved; [totalSaved] is how many are saved now.
  Future<void> onPaletteSaved(int totalSaved) async {
    if (totalSaved < palettesMilestone) return;
    await _ask();
  }

  /// A new diary entry was just saved.
  Future<void> onDiaryEntrySaved() => _ask();

  Future<void> _ask() async {
    if (_running || _settings.reviewPromptAsked) return;
    _running = true;
    try {
      if (!await _isAvailable()) {
        await _giveUpAfterTooMany();
        return;
      }
      // Marked before asking: if the dialog fails half-way it still counts,
      // so a user is never asked twice.
      await _settings.setReviewPromptAsked(true);
      await _reviewer.requestReview();
    } catch (_) {
      // A review prompt must never break a save.
    } finally {
      _running = false;
    }
  }

  /// Whether the store can show its dialog; a store that fails to answer
  /// counts as one that cannot.
  Future<bool> _isAvailable() async {
    try {
      return await _reviewer.isAvailable();
    } catch (_) {
      return false;
    }
  }

  /// Counts one more time without a dialog; at [maxUnavailable] the prompt is
  /// marked as asked for good.
  Future<void> _giveUpAfterTooMany() async {
    final int count = _settings.reviewPromptUnavailable + 1;
    await _settings.setReviewPromptUnavailable(count);
    if (count >= maxUnavailable) await _settings.setReviewPromptAsked(true);
  }
}
