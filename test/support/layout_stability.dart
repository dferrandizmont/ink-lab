import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/ai/ai.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/data/data.dart';
import 'package:ink_lab/ui/theme/app_theme.dart';

import 'l10n.dart';

// Rule: switching a segment, a tab or a type in place must NEVER move anything
// above the content, in any language, on any phone width and text size. This
// helper records where the controls sit for each segment and asserts that they
// sit in the same place (same top, same height) for all of them.

/// One language x width x text scale combination.
class StabilityEnv {
  const StabilityEnv(this.locale, this.width, this.scale, [this.height = 800]);

  final Locale locale;
  final double width;
  final double scale;

  /// Height of the screen; phones are checked at 800.
  final double height;

  AppLocalizations get t => lookupAppLocalizations(locale);

  String get tag =>
      '${locale.languageCode} ${width.toInt()}'
      '${width < 600 ? '' : 'x${height.toInt()}'}dp x$scale';
}

/// The tablet screens the app is checked on, portrait and landscape: a 10"
/// Android tablet and a 13" iPad.
const List<Size> tabletSizes = <Size>[
  Size(800, 1280),
  Size(1280, 800),
  Size(1032, 1376),
  Size(1376, 1032),
];

/// Every combination the app is checked in: six languages, 360 and 412 dp,
/// text scale 1.0 and 1.3; and the [tabletSizes] at normal text.
Iterable<StabilityEnv> stabilityEnvs() sync* {
  for (final Locale locale in AppLocalizations.supportedLocales) {
    for (final double width in const <double>[360, 412]) {
      for (final double scale in const <double>[1.0, 1.3]) {
        yield StabilityEnv(locale, width, scale);
      }
    }
    for (final Size size in tabletSizes) {
      yield StabilityEnv(locale, size.width, 1.0, size.height);
    }
  }
}

/// Registers [body] once per [stabilityEnvs] combination, as `testWidgets`.
void stabilityTest(
  String description,
  Future<void> Function(WidgetTester tester, StabilityEnv env) body,
) {
  group(description, () {
    setUpAll(loadAppFonts);
    for (final StabilityEnv env in stabilityEnvs()) {
      testWidgets(env.tag, (WidgetTester tester) => body(tester, env));
    }
  });
}

/// Pumps [page] in a Material app at [env]'s size, language and text scale
/// and returns the scope.
Future<AppScope> pumpStability(
  WidgetTester tester,
  StabilityEnv env,
  Widget page, {
  AiSettingsRepository? aiSettings,
  SecretStore? secrets,
  AiService? aiService,
  double? height,
}) async {
  tester.view.physicalSize = Size(env.width, height ?? env.height);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  final AppScope scope = AppScope.inMemory(
    markers: MarkerRepository(
      loadAsset: (String path) => File(path).readAsStringSync(),
    ),
    aiSettings: aiSettings,
    secrets: secrets,
    aiService: aiService,
    child: MaterialApp(
      locale: env.locale,
      localizationsDelegates: testLocalizationsDelegates,
      supportedLocales: testSupportedLocales,
      theme: AppTheme.light(),
      builder: (BuildContext context, Widget? child) => MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: TextScaler.linear(env.scale)),
        child: child!,
      ),
      home: Scaffold(body: page),
    ),
  );
  await tester.pumpWidget(scope);
  await tester.pumpAndSettle();
  return scope;
}

/// One state of the screen to compare: [activate] switches to it (tap the
/// segment, pick the type...).
typedef StabilitySegment = ({String name, Future<void> Function() activate});

/// Where each anchor sat in each segment: `anchor -> segment -> (top, height)`.
typedef StabilityRecord = Map<String, Map<String, (double, double)>>;

/// Switches through [segments] (in order, so go back to the first one at the
/// end to catch a state that does not return) and asserts that every anchor
/// in [anchors] sits at the same top, with the same height, in all of them.
///
/// The anchors named in [topOnly] (first content elements, whose own height
/// legitimately depends on the segment) are compared by top only.
///
/// An anchor that is not on screen in a segment is skipped for that segment
/// (use it for the "first content element" that only some segments have); but
/// each anchor must be found in at least two segments, so a typo cannot make
/// the check vacuous. Returns what was recorded.
Future<StabilityRecord> expectStableAcrossSegments(
  WidgetTester tester, {
  required StabilityEnv env,
  required Map<String, Finder> anchors,
  required List<StabilitySegment> segments,
  Set<String> topOnly = const <String>{},
  String? where,
}) async {
  final StabilityRecord record = <String, Map<String, (double, double)>>{
    for (final String name in anchors.keys) name: <String, (double, double)>{},
  };
  for (final StabilitySegment segment in segments) {
    await segment.activate();
    await tester.pumpAndSettle();
    for (final MapEntry<String, Finder> anchor in anchors.entries) {
      final Finder found = anchor.value;
      if (found.evaluate().isEmpty) continue;
      final Rect rect = tester.getRect(found.first);
      record[anchor.key]![segment.name] = (rect.top, rect.height);
    }
  }
  final String prefix = '${env.tag}${where == null ? '' : ' [$where]'}';
  for (final MapEntry<String, Map<String, (double, double)>> entry
      in record.entries) {
    final Map<String, (double, double)> seen = entry.value;
    expect(
      seen.length,
      greaterThanOrEqualTo(2),
      reason: '$prefix anchor "${entry.key}" found in fewer than two segments',
    );
    final (double, double) first = seen.values.first;
    for (final MapEntry<String, (double, double)> at in seen.entries) {
      expect(
        at.value.$1,
        moreOrLessEquals(first.$1, epsilon: 0.01),
        reason:
            '$prefix "${entry.key}" top moved: $seen '
            '(segment "${at.key}")',
      );
      if (topOnly.contains(entry.key)) continue;
      expect(
        at.value.$2,
        moreOrLessEquals(first.$2, epsilon: 0.01),
        reason:
            '$prefix "${entry.key}" height changed: $seen '
            '(segment "${at.key}")',
      );
    }
  }
  return record;
}
