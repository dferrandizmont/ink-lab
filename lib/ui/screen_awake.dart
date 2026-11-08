import 'package:wakelock_plus/wakelock_plus.dart';

/// Keeps the screen from switching off, behind a seam so tests can watch it.
///
/// [enable] and [disable] are idempotent. The page that enables it must
/// disable it again on dispose, pause and back.
abstract interface class ScreenAwake {
  /// Stops the screen from dimming and locking.
  Future<void> enable();

  /// Lets the screen dim and lock again.
  Future<void> disable();
}

/// [ScreenAwake] on top of `wakelock_plus` (a window flag on Android, the
/// idle timer on iOS). It uses no permission and sends nothing anywhere.
final class WakelockScreenAwake implements ScreenAwake {
  const WakelockScreenAwake();

  @override
  Future<void> enable() => WakelockPlus.enable();

  @override
  Future<void> disable() => WakelockPlus.disable();
}
