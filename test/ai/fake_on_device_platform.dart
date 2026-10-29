import 'dart:async';

import 'package:ink_lab/ai/ai.dart';

/// A scriptable on-device model: no channel, no model, fully deterministic.
final class FakeOnDevicePlatform implements OnDeviceAiPlatform {
  FakeOnDevicePlatform({
    this.currentStatus = OnDeviceStatus.available,
    this.output = '',
    this.failure,
    this.hang = false,
    this.downloadEvents = const <OnDeviceDownloadEvent>[],
    this.statusAfterDownload = OnDeviceStatus.available,
    this.responder,
  });

  OnDeviceStatus currentStatus;
  String output;

  /// When set, [generate] throws this failure.
  OnDeviceGenerateFailure? failure;

  /// When true, [generate] never answers on its own.
  bool hang;

  /// Builds the answer from the prompt when set (overrides [output]).
  final String Function(String prompt)? responder;

  final List<OnDeviceDownloadEvent> downloadEvents;

  /// When set, [download] forwards this stream instead of `downloadEvents`,
  /// so a test decides when (and whether) progress arrives.
  StreamController<OnDeviceDownloadEvent>? downloadController;
  final OnDeviceStatus statusAfterDownload;

  final List<String> prompts = <String>[];
  int downloads = 0;
  int statusCalls = 0;
  int cancelDownloads = 0;

  @override
  Future<OnDeviceStatus> status() async {
    statusCalls++;
    return currentStatus;
  }

  @override
  Stream<OnDeviceDownloadEvent> download() async* {
    downloads++;
    final StreamController<OnDeviceDownloadEvent>? live = downloadController;
    if (live != null) {
      yield* live.stream;
      if (currentStatus == OnDeviceStatus.downloadable ||
          currentStatus == OnDeviceStatus.downloading) {
        currentStatus = statusAfterDownload;
      }
      return;
    }
    for (final OnDeviceDownloadEvent event in downloadEvents) {
      yield event;
    }
    if (downloadEvents.any(
      (OnDeviceDownloadEvent e) => e is OnDeviceDownloadCompleted,
    )) {
      currentStatus = statusAfterDownload;
    }
  }

  @override
  Future<void> cancelDownload() async {
    cancelDownloads++;
  }

  @override
  Future<String> generate(
    String prompt, {
    Duration timeout = defaultOnDeviceTimeout,
  }) {
    prompts.add(prompt);
    if (hang) {
      return Completer<String>().future.timeout(
        timeout,
        onTimeout: () =>
            throw const OnDeviceAiException(OnDeviceGenerateFailure.timeout),
      );
    }
    final OnDeviceGenerateFailure? error = failure;
    if (error != null) return Future<String>.error(OnDeviceAiException(error));
    return Future<String>.value(responder?.call(prompt) ?? output);
  }
}
