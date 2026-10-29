import 'dart:async';

import 'package:flutter/foundation.dart';

import 'on_device_ai_platform.dart';

/// How long a download may stay silent before the UI explains the wait.
const Duration defaultNoProgressAfter = Duration(seconds: 60);

/// The one on-device model download of the app, kept outside any widget.
///
/// Android (AICore) may sit on a requested download for a long time, waiting
/// for Wi-Fi, charging and idle. The request must therefore survive the user
/// leaving the settings screen: this object lives with the [AiService], is the
/// only listener of the platform stream, and is never cancelled by a widget.
/// Controllers only observe it and re-attach when the screen is built again.
final class OnDeviceDownloadTracker extends ChangeNotifier {
  OnDeviceDownloadTracker(
    this._platform, {
    this.noProgressAfter = defaultNoProgressAfter,
  });

  final OnDeviceAiPlatform _platform;

  /// Silence after which [stalled] turns true.
  final Duration noProgressAfter;

  StreamSubscription<OnDeviceDownloadEvent>? _subscription;
  Completer<void>? _done;
  Timer? _timer;

  bool _active = false;
  bool _failed = false;
  bool _stalled = false;
  bool _gotProgress = false;
  int _bytes = 0;
  int _totalBytes = 0;

  /// Whether a download request is running.
  bool get active => _active;

  /// Whether the last download failed.
  bool get failed => _failed;

  /// Whether the download has been silent for [noProgressAfter].
  bool get stalled => _stalled;

  /// Whether the platform has reported any progress yet.
  bool get hasProgress => _gotProgress;

  /// Bytes downloaded so far.
  int get bytes => _bytes;

  /// Bytes to download in total, or 0 when the platform did not say.
  int get totalBytes => _totalBytes;

  /// Completes when the running download ends (immediately when none runs).
  Future<void> get done => _done?.future ?? Future<void>.value();

  /// Starts the download unless one is already running. Never throws.
  void start() {
    if (_active) return;
    _active = true;
    _failed = false;
    _stalled = false;
    _gotProgress = false;
    _bytes = 0;
    _totalBytes = 0;
    final Completer<void> done = Completer<void>();
    _done = done;
    _timer?.cancel();
    _timer = Timer(noProgressAfter, () {
      if (_active && !_gotProgress) {
        _stalled = true;
        notifyListeners();
      }
    });
    void finish() {
      if (!_active || !identical(_done, done)) return;
      _active = false;
      _timer?.cancel();
      _timer = null;
      _subscription = null;
      notifyListeners();
      if (!done.isCompleted) done.complete();
    }

    notifyListeners();
    try {
      _subscription = _platform.download().listen(
        (OnDeviceDownloadEvent event) {
          switch (event) {
            case OnDeviceDownloadStarted(:final totalBytes):
              if (totalBytes > 0) _totalBytes = totalBytes;
              notifyListeners();
            case OnDeviceDownloadProgress(:final bytes, :final totalBytes):
              _gotProgress = true;
              _stalled = false;
              _bytes = bytes;
              if (totalBytes > 0) _totalBytes = totalBytes;
              notifyListeners();
            case OnDeviceDownloadFailed():
              _failed = true;
            case OnDeviceDownloadCompleted():
              break;
          }
        },
        onError: (Object _) {
          _failed = true;
          finish();
        },
        onDone: finish,
        cancelOnError: true,
      );
    } catch (_) {
      _failed = true;
      finish();
    }
  }

  /// Stops the running download (for example when the AI is turned off): the
  /// subscription goes, the platform is told to stop and the state is cleared.
  /// Does nothing when no download runs.
  void cancel() {
    if (!_active) return;
    _active = false;
    _failed = false;
    _stalled = false;
    _timer?.cancel();
    _timer = null;
    final StreamSubscription<OnDeviceDownloadEvent>? subscription =
        _subscription;
    _subscription = null;
    unawaited(subscription?.cancel());
    unawaited(_platform.cancelDownload());
    final Completer<void>? done = _done;
    if (done != null && !done.isCompleted) done.complete();
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    unawaited(_subscription?.cancel());
    super.dispose();
  }
}
