import 'dart:async';

/// A stream that replays the current value to every new listener, then
/// forwards [updates].
///
/// Unlike an `async*` getter, the returned stream can be listened to any
/// number of times, one subscription after another or several at once. That
/// matters for widgets: a `StreamBuilder` that is unmounted and mounted again
/// (tab switch, lazy list) subscribes to the same stream object again, and a
/// single-subscription stream would throw "Stream has already been listened
/// to".
Stream<T> replayStream<T>(T Function() current, Stream<T> updates) {
  return Stream<T>.multi((MultiStreamController<T> controller) {
    controller.add(current());
    final StreamSubscription<T> subscription = updates.listen(
      // Not inside onListen any more, so the synchronous variant is allowed
      // and adds no extra scheduling hop.
      controller.addSync,
      onError: controller.addError,
      onDone: controller.close,
    );
    controller.onCancel = subscription.cancel;
  });
}
