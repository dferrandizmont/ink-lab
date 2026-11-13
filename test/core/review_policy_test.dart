import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/review_policy.dart';

final _today = DateTime(2026, 11, 13);

ReviewState _eligible({
  int age = 7,
  int opens = 5,
  int requests = 0,
  int? gap,
  String? version,
  int unavailable = 0,
}) => ReviewState(
  firstLaunch: DateTime(2026, 11, 13 - age),
  openDays: opens,
  requestCount: requests,
  lastRequestDay: gap == null ? null : DateTime(2026, 11, 13 - gap),
  lastRequestVersion: version,
  unavailableCount: unavailable,
);

bool _ask(
  ReviewState state, {
  bool own = true,
  bool firstRun = false,
  bool quiet = false,
  String version = '2.0.0',
  DateTime? today,
}) => ReviewPolicy.shouldAsk(
  state: state,
  today: today ?? _today,
  appVersion: version,
  hasOwnData: own,
  inFirstRun: firstRun,
  quiet: quiet,
);

void main() {
  group('review eligibility boundaries', () {
    test('needs a first launch and seven civil days', () {
      expect(_ask(ReviewState(openDays: 5)), isFalse);
      expect(_ask(_eligible(age: 6)), isFalse);
      expect(_ask(_eligible(age: 7)), isTrue);
      expect(_ask(_eligible(age: -1)), isFalse);
    });

    test('needs five open days', () {
      expect(_ask(_eligible(opens: 4)), isFalse);
      expect(_ask(_eligible(opens: 5)), isTrue);
    });

    test('needs ninety days between requests', () {
      expect(_ask(_eligible(requests: 1, gap: 89)), isFalse);
      expect(_ask(_eligible(requests: 1, gap: 90)), isTrue);
      expect(_ask(_eligible(requests: 1, gap: -1)), isFalse);
    });

    test('third request is the last', () {
      final state = _eligible(requests: 2, gap: 90);
      expect(_ask(state), isTrue);
      expect(
        _ask(
          state.withRequestOn(_today, '2.0.0'),
          today: DateTime(2027, 11, 13),
          version: '3.0.0',
        ),
        isFalse,
      );
    });

    test('same version refused, new version allowed after ninety days', () {
      final state = _eligible(requests: 1, gap: 90, version: '2.0.0');
      expect(_ask(state), isFalse);
      expect(_ask(state, version: '3.0.0'), isTrue);
      expect(_ask(_eligible(requests: 1, gap: 89, version: '1.0.0')), isFalse);
      expect(_ask(_eligible(version: '2.0.0')), isTrue);
    });

    test('three unavailable checks stop requests', () {
      expect(_ask(_eligible(unavailable: 2)), isTrue);
      expect(_ask(_eligible(unavailable: 3)), isFalse);
    });

    test('first run, quiet sessions and no own data suppress requests', () {
      expect(_ask(_eligible(), firstRun: true), isFalse);
      expect(_ask(_eligible(), quiet: true), isFalse);
      expect(_ask(_eligible(), own: false), isFalse);
    });

    test('DST change still spans seven civil days', () {
      expect(
        ReviewPolicy.shouldAsk(
          state: ReviewState(
            firstLaunch: DateTime(2026, 3, 23, 23),
            openDays: 5,
          ),
          today: DateTime(2026, 3, 30, 1),
          appVersion: '1',
          hasOwnData: true,
          inFirstRun: false,
          quiet: false,
        ),
        isTrue,
      );
    });
  });

  test('opens count once and never revisit days after a backwards clock', () {
    final first = ReviewState().withOpenOn(DateTime(2026, 3, 28, 23));
    expect(first.firstLaunch, DateTime.utc(2026, 3, 28));
    expect(first.openDays, 1);
    final same = first.withOpenOn(DateTime(2026, 3, 28, 23, 59));
    expect(same.openDays, 1);
    final next = same.withOpenOn(DateTime(2026, 3, 29, 1));
    expect(next.openDays, 2);
    final back = next.withOpenOn(DateTime(2026, 3, 27));
    expect(back.openDays, 2);
    expect(back.lastOpenDay, DateTime.utc(2026, 3, 29));
    expect(back.withOpenOn(DateTime(2026, 3, 28)).openDays, 2);
    expect(back.withOpenOn(DateTime(2026, 3, 29)).openDays, 2);
    expect(back.withOpenOn(DateTime(2026, 3, 30)).openDays, 3);
    expect(back.firstLaunch, first.firstLaunch);
  });

  test('request and unavailable updates preserve the other fields', () {
    final state = _eligible().withOpenOn(_today);
    final asked = state.withRequestOn(_today, '2.0.0');
    final unavailable = asked.withUnavailable();
    expect(unavailable.toJson(), {
      ...state.toJson(),
      'requestCount': 1,
      'lastRequestDay': '2026-11-13',
      'lastRequestVersion': '2.0.0',
      'unavailableCount': 1,
    });
  });

  test('JSON round trip uses civil dates', () {
    final state = _eligible(
      requests: 2,
      gap: 90,
      version: '1.0.0',
      unavailable: 1,
    ).withOpenOn(_today);
    final json = state.toJson();
    expect(json['firstLaunch'], '2026-11-06');
    expect(json['lastOpenDay'], '2026-11-13');
    expect(ReviewState.fromJson(jsonEncode(json)).toJson(), json);
    expect(ReviewState.fromJson(json).toJson(), json);
  });

  test('malformed JSON and fields never throw and mean nothing recorded', () {
    for (final raw in [
      null,
      '',
      '{',
      '[]',
      'null',
      '42',
      <String, Object?>{},
    ]) {
      expect(ReviewState.fromJson(raw).toJson(), ReviewState().toJson());
    }
    expect(
      ReviewState.fromJson({
        'firstLaunch': '2026-02-30',
        'lastOpenDay': '2026-3-01',
        'lastRequestDay': 3,
        'openDays': -2,
        'requestCount': 1.5,
        'unavailableCount': '3',
        'lastRequestVersion': false,
      }).toJson(),
      ReviewState().toJson(),
    );
    final partial = ReviewState.fromJson({
      'firstLaunch': '2026-11-01',
      'openDays': 5,
      'unavailableCount': -1,
    });
    expect(partial.firstLaunch, DateTime.utc(2026, 11, 1));
    expect(partial.openDays, 5);
    expect(partial.unavailableCount, 0);
  });
}
