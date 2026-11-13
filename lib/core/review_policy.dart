import 'dart:convert';

/// Review history for this installation, using civil dates without times.
final class ReviewState {
  ReviewState({
    DateTime? firstLaunch,
    DateTime? lastOpenDay,
    this.openDays = 0,
    this.requestCount = 0,
    DateTime? lastRequestDay,
    this.lastRequestVersion,
    this.unavailableCount = 0,
  }) : firstLaunch = firstLaunch == null ? null : _civil(firstLaunch),
       lastOpenDay = lastOpenDay == null ? null : _civil(lastOpenDay),
       lastRequestDay = lastRequestDay == null ? null : _civil(lastRequestDay);

  /// The first recorded launch day.
  final DateTime? firstLaunch;

  /// The latest recorded open day; earlier clock readings cannot count again.
  final DateTime? lastOpenDay;

  /// Number of distinct, advancing open days.
  final int openDays;

  /// Number of review requests recorded before calling the store.
  final int requestCount;

  /// The most recent request day, when known.
  final DateTime? lastRequestDay;

  /// The app version of the most recent request, when known.
  final String? lastRequestVersion;

  /// How many availability checks found no store dialog.
  final int unavailableCount;

  /// Records at most one open per day, ignoring a clock that goes backwards.
  ReviewState withOpenOn(DateTime today) {
    final day = _civil(today);
    final advances = lastOpenDay == null || day.isAfter(lastOpenDay!);
    return ReviewState(
      firstLaunch: firstLaunch ?? day,
      lastOpenDay: advances ? day : lastOpenDay,
      openDays: openDays + (advances ? 1 : 0),
      requestCount: requestCount,
      lastRequestDay: lastRequestDay,
      lastRequestVersion: lastRequestVersion,
      unavailableCount: unavailableCount,
    );
  }

  /// Records a request before the store is called.
  ReviewState withRequestOn(DateTime today, String version) => ReviewState(
    firstLaunch: firstLaunch,
    lastOpenDay: lastOpenDay,
    openDays: openDays,
    requestCount: requestCount + 1,
    lastRequestDay: today,
    lastRequestVersion: version,
    unavailableCount: unavailableCount,
  );

  /// Records one availability check without a dialog.
  ReviewState withUnavailable() => ReviewState(
    firstLaunch: firstLaunch,
    lastOpenDay: lastOpenDay,
    openDays: openDays,
    requestCount: requestCount,
    lastRequestDay: lastRequestDay,
    lastRequestVersion: lastRequestVersion,
    unavailableCount: unavailableCount + 1,
  );

  /// Encodes civil dates as `yyyy-mm-dd` strings.
  Map<String, Object?> toJson() => {
    'firstLaunch': _encodeDay(firstLaunch),
    'lastOpenDay': _encodeDay(lastOpenDay),
    'openDays': openDays,
    'requestCount': requestCount,
    'lastRequestDay': _encodeDay(lastRequestDay),
    'lastRequestVersion': lastRequestVersion,
    'unavailableCount': unavailableCount,
  };

  /// Reads a JSON object or string; malformed fields mean nothing recorded.
  static ReviewState fromJson(Object? raw) {
    try {
      final Object? json = raw is String ? jsonDecode(raw) : raw;
      if (json is! Map<String, dynamic>) return ReviewState();
      int count(String key) {
        final value = json[key];
        return value is int && value >= 0 ? value : 0;
      }

      return ReviewState(
        firstLaunch: _decodeDay(json['firstLaunch']),
        lastOpenDay: _decodeDay(json['lastOpenDay']),
        openDays: count('openDays'),
        requestCount: count('requestCount'),
        lastRequestDay: _decodeDay(json['lastRequestDay']),
        lastRequestVersion: json['lastRequestVersion'] is String
            ? json['lastRequestVersion'] as String
            : null,
        unavailableCount: count('unavailableCount'),
      );
    } catch (_) {
      return ReviewState();
    }
  }
}

/// Pure eligibility rules for a review request after successful work.
abstract final class ReviewPolicy {
  /// Minimum civil days since the first recorded launch.
  static const int minDaysSinceFirstLaunch = 7;

  /// Minimum distinct days of app use.
  static const int minOpenDays = 5;

  /// Minimum civil days between requests, including across versions.
  static const int minDaysBetweenRequests = 90;

  /// Maximum requests for this installation.
  static const int maxRequests = 3;

  /// Stop checking after this many unavailable store dialogs.
  static const int maxUnavailable = 3;

  /// Whether the installation and the current session may ask for a review.
  static bool shouldAsk({
    required ReviewState state,
    required DateTime today,
    required String appVersion,
    required bool hasOwnData,
    required bool inFirstRun,
    required bool quiet,
  }) {
    final first = state.firstLaunch;
    final last = state.lastRequestDay;
    final day = _civil(today);
    return !inFirstRun &&
        !quiet &&
        hasOwnData &&
        first != null &&
        day.difference(first).inDays >= minDaysSinceFirstLaunch &&
        state.openDays >= minOpenDays &&
        state.requestCount < maxRequests &&
        !(state.requestCount > 0 && state.lastRequestVersion == appVersion) &&
        (last == null ||
            day.difference(last).inDays >= minDaysBetweenRequests) &&
        state.unavailableCount < maxUnavailable;
  }
}

DateTime _civil(DateTime day) => DateTime.utc(day.year, day.month, day.day);

String? _encodeDay(DateTime? day) => day == null
    ? null
    : '${day.year.toString().padLeft(4, '0')}-'
          '${day.month.toString().padLeft(2, '0')}-'
          '${day.day.toString().padLeft(2, '0')}';

DateTime? _decodeDay(Object? raw) {
  if (raw is! String || !RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(raw)) {
    return null;
  }
  final day = DateTime.tryParse('${raw}T00:00:00Z');
  return day != null && _encodeDay(day) == raw ? day : null;
}
