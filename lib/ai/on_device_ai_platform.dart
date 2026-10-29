import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Id reported as the "model" of an on-device result. The palette page tags
/// results from it as `AI · on-device`.
const String onDeviceModelId = 'on-device';

/// State of the operating system's on-device model (Gemini Nano through
/// Android AICore today; Apple Foundation Models later on iOS).
enum OnDeviceStatus {
  /// Not supported on this device, or the platform has no on-device model.
  unavailable,

  /// Supported, but the model has not been downloaded yet.
  downloadable,

  /// The model is being downloaded.
  downloading,

  /// Ready to answer prompts.
  available;

  /// Parses the wire value; anything unknown is [unavailable].
  static OnDeviceStatus parse(Object? raw) => switch (raw) {
    'downloadable' => OnDeviceStatus.downloadable,
    'downloading' => OnDeviceStatus.downloading,
    'available' => OnDeviceStatus.available,
    _ => OnDeviceStatus.unavailable,
  };

  /// Whether the provider should be offered in the UI at all.
  bool get supported => this != OnDeviceStatus.unavailable;
}

/// One step of the model download.
sealed class OnDeviceDownloadEvent {
  const OnDeviceDownloadEvent();
}

/// The download began; [totalBytes] is the size to fetch, or 0 when unknown.
final class OnDeviceDownloadStarted extends OnDeviceDownloadEvent {
  const OnDeviceDownloadStarted({this.totalBytes = 0});

  final int totalBytes;
}

/// Bytes downloaded so far; [totalBytes] is 0 when the platform gave no total.
final class OnDeviceDownloadProgress extends OnDeviceDownloadEvent {
  const OnDeviceDownloadProgress(this.bytes, {this.totalBytes = 0});

  final int bytes;
  final int totalBytes;
}

/// The model is ready.
final class OnDeviceDownloadCompleted extends OnDeviceDownloadEvent {
  const OnDeviceDownloadCompleted();
}

/// The download failed; [message] is a short, non-sensitive description.
final class OnDeviceDownloadFailed extends OnDeviceDownloadEvent {
  const OnDeviceDownloadFailed([this.message = '']);

  final String message;
}

/// Why a generation did not produce text.
enum OnDeviceGenerateFailure { unavailable, timeout, cancelled, failed }

/// Thrown by [OnDeviceAiPlatform.generate]; carries no prompt or output.
final class OnDeviceAiException implements Exception {
  const OnDeviceAiException(this.failure);

  final OnDeviceGenerateFailure failure;

  @override
  String toString() => 'OnDeviceAiException(${failure.name})';
}

/// The thin, replaceable bridge to the platform's on-device model.
abstract interface class OnDeviceAiPlatform {
  /// Current model state. Never throws: any error is [OnDeviceStatus.unavailable].
  Future<OnDeviceStatus> status();

  /// Starts the model download and streams its progress. The stream ends after
  /// [OnDeviceDownloadCompleted] or [OnDeviceDownloadFailed].
  Stream<OnDeviceDownloadEvent> download();

  /// Stops a running model download, if any. Never throws and does nothing
  /// (not even asking the model for its status) when no download is running.
  Future<void> cancelDownload();

  /// Generates text for [prompt]. Throws [OnDeviceAiException] on failure.
  Future<String> generate(
    String prompt, {
    Duration timeout = defaultOnDeviceTimeout,
  });
}

/// Generation timeout, matching the native side.
const Duration defaultOnDeviceTimeout = Duration(seconds: 30);

/// The platform for which no on-device model exists (iOS for now, web,
/// desktop): always unavailable, so the UI never offers the provider.
final class UnsupportedOnDeviceAi implements OnDeviceAiPlatform {
  const UnsupportedOnDeviceAi();

  @override
  Future<OnDeviceStatus> status() async => OnDeviceStatus.unavailable;

  @override
  Stream<OnDeviceDownloadEvent> download() => Stream.value(
    const OnDeviceDownloadFailed('On-device AI is not available.'),
  );

  @override
  Future<void> cancelDownload() async {}

  @override
  Future<String> generate(
    String prompt, {
    Duration timeout = defaultOnDeviceTimeout,
  }) => Future<String>.error(
    const OnDeviceAiException(OnDeviceGenerateFailure.unavailable),
  );
}

/// Android implementation over the `ink_lab/on_device_ai` channels, served by
/// `OnDeviceAiChannel.kt` (Gemini Nano through ML Kit GenAI).
final class MethodChannelOnDeviceAi implements OnDeviceAiPlatform {
  MethodChannelOnDeviceAi({
    MethodChannel? methods,
    EventChannel? events,
    this.backstopGrace = const Duration(seconds: 2),
  }) : _methods = methods ?? const MethodChannel(_methodChannelName),
       _events = events ?? const EventChannel(_eventChannelName);

  static const String _methodChannelName = 'ink_lab/on_device_ai';
  static const String _eventChannelName = 'ink_lab/on_device_ai/download';

  final MethodChannel _methods;
  final EventChannel _events;

  /// Extra time on top of the requested timeout before Dart gives up waiting
  /// for the native answer.
  final Duration backstopGrace;

  @override
  Future<OnDeviceStatus> status() async {
    try {
      final String? raw = await _methods.invokeMethod<String>('status');
      return OnDeviceStatus.parse(raw);
    } catch (_) {
      // MissingPluginException, PlatformException, anything: not usable.
      return OnDeviceStatus.unavailable;
    }
  }

  @override
  Stream<OnDeviceDownloadEvent> download() {
    final StreamController<OnDeviceDownloadEvent> controller =
        StreamController<OnDeviceDownloadEvent>();
    StreamSubscription<dynamic>? subscription;

    void finish() {
      unawaited(subscription?.cancel());
      if (!controller.isClosed) unawaited(controller.close());
    }

    void emit(OnDeviceDownloadEvent event) {
      if (controller.isClosed) return;
      controller.add(event);
      if (event is OnDeviceDownloadCompleted ||
          event is OnDeviceDownloadFailed) {
        finish();
      }
    }

    controller.onListen = () async {
      // Listen first so no early event is lost, then ask the platform to start.
      subscription = _events.receiveBroadcastStream().listen(
        (dynamic raw) {
          final OnDeviceDownloadEvent? event = _parseEvent(raw);
          if (event != null) emit(event);
        },
        onError: (Object _) => emit(const OnDeviceDownloadFailed()),
        onDone: finish,
      );
      try {
        await _methods.invokeMethod<String>('download');
      } catch (_) {
        emit(const OnDeviceDownloadFailed());
      }
    };
    controller.onCancel = () => subscription?.cancel();
    return controller.stream;
  }

  @override
  Future<void> cancelDownload() async {
    try {
      await _methods.invokeMethod<void>('cancelDownload');
    } catch (_) {
      // Best effort: nothing to stop, or no native side.
    }
  }

  @override
  Future<String> generate(
    String prompt, {
    Duration timeout = defaultOnDeviceTimeout,
  }) async {
    try {
      final String? text = await _methods
          .invokeMethod<String>('generate', prompt)
          // The native side times out at 30 s on its own; this is the backstop.
          .timeout(timeout + backstopGrace);
      if (text == null || text.trim().isEmpty) {
        throw const OnDeviceAiException(OnDeviceGenerateFailure.failed);
      }
      return text;
    } on TimeoutException {
      unawaited(_cancel());
      throw const OnDeviceAiException(OnDeviceGenerateFailure.timeout);
    } on OnDeviceAiException {
      rethrow;
    } on PlatformException catch (error) {
      throw OnDeviceAiException(switch (error.code) {
        'unavailable' => OnDeviceGenerateFailure.unavailable,
        'timeout' => OnDeviceGenerateFailure.timeout,
        'cancelled' => OnDeviceGenerateFailure.cancelled,
        _ => OnDeviceGenerateFailure.failed,
      });
    } catch (_) {
      throw const OnDeviceAiException(OnDeviceGenerateFailure.failed);
    }
  }

  Future<void> _cancel() async {
    try {
      await _methods.invokeMethod<void>('cancel');
    } catch (_) {
      // Best effort: the native timeout stops it anyway.
    }
  }
}

int _intOf(Object? raw) => raw is num ? raw.toInt() : 0;

OnDeviceDownloadEvent? _parseEvent(Object? raw) {
  if (raw is! Map) return null;
  return switch (raw['type']) {
    'started' => OnDeviceDownloadStarted(totalBytes: _intOf(raw['total'])),
    'progress' => OnDeviceDownloadProgress(
      _intOf(raw['bytes']),
      totalBytes: _intOf(raw['total']),
    ),
    'completed' => const OnDeviceDownloadCompleted(),
    'failed' => OnDeviceDownloadFailed(
      raw['message'] is String ? raw['message'] as String : '',
    ),
    _ => null,
  };
}

/// The platform implementation for the running OS: the Android channel on
/// Android, the "unavailable" stub everywhere else (iOS lands later).
OnDeviceAiPlatform defaultOnDeviceAiPlatform() {
  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
    return MethodChannelOnDeviceAi();
  }
  return const UnsupportedOnDeviceAi();
}
