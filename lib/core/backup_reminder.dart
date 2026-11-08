/// What the backup card tells the user about their last backup.
enum BackupReminder {
  /// No hint: there is nothing to lose, or the backup is recent.
  none,

  /// There is data and no backup was ever made.
  never,

  /// There is data and the last backup is older than
  /// [BackupReminders.staleAfter].
  stale,
}

/// The rule behind the gentle hint of the backup card. It is only text in the
/// card: there are no notifications and no popups.
abstract final class BackupReminders {
  /// A backup older than this (more than 30 days) is stale.
  static const Duration staleAfter = Duration(days: 30);

  /// Which hint to show.
  ///
  /// [hasData] is true when the user has diary entries or saved palettes.
  /// A [lastBackup] in the future (the clock was moved back) counts as
  /// recent.
  static BackupReminder of({
    required DateTime? lastBackup,
    required DateTime now,
    required bool hasData,
  }) {
    if (!hasData) return BackupReminder.none;
    if (lastBackup == null) return BackupReminder.never;
    return now.difference(lastBackup) > staleAfter
        ? BackupReminder.stale
        : BackupReminder.none;
  }
}
