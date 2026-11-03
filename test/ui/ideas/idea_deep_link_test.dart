import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app.dart';
import 'package:ink_lab/core/ideas_engine.dart';
import 'package:ink_lab/ui/pages/ideas/idea_deep_link.dart';
import 'package:ink_lab/ui/pages/ideas/ideas_page.dart';
import 'package:ink_lab/ui/pages/swatches/swatches_page.dart';

import '../../support/l10n.dart';
import 'ideas_test_support.dart';

Finder _key(String key) => find.byKey(ValueKey<String>(key));

void main() {
  tearDown(() => ideaDeepLink.value = null);

  group('the widget link', () {
    test('a known idea is accepted', () {
      final String id = IdeasEngine.presets.last.id;
      expect(ideaIdFromWidgetUri(Uri.parse('inklab://idea/$id')), id);
      expect(openIdeaFromWidgetUri(Uri.parse('inklab://idea/$id')), isTrue);
      expect(ideaDeepLink.value, id);
    });

    test('an unknown id, another scheme or no link is ignored', () {
      for (final Uri? uri in <Uri?>[
        Uri.parse('inklab://idea/no_such_idea'),
        Uri.parse('inklab://idea/'),
        Uri.parse('inklab://idea'),
        Uri.parse('inklab://other/${IdeasEngine.presets.first.id}'),
        Uri.parse('https://idea/${IdeasEngine.presets.first.id}'),
        Uri.parse('inklab://idea/a/b'),
        Uri(),
        null,
      ]) {
        expect(openIdeaFromWidgetUri(uri), isFalse, reason: '$uri');
      }
      expect(ideaDeepLink.value, isNull);
    });

    test('the launch link and the later taps both arrive', () async {
      final StreamController<Uri?> taps = StreamController<Uri?>();
      final String first = IdeasEngine.presets.first.id;
      final String second = IdeasEngine.presets[1].id;
      final StreamSubscription<Uri?>? sub = await listenToIdeaWidgetLinks(
        initial: () async => Uri.parse('inklab://idea/$first'),
        clicks: taps.stream,
      );
      expect(ideaDeepLink.value, first);
      ideaDeepLink.value = null;
      taps.add(Uri.parse('inklab://idea/$second'));
      await Future<void>.delayed(Duration.zero);
      expect(ideaDeepLink.value, second);
      ideaDeepLink.value = null;
      taps.add(Uri.parse('inklab://idea/unknown'));
      taps.addError(StateError('boom'));
      await Future<void>.delayed(Duration.zero);
      expect(ideaDeepLink.value, isNull);
      await sub?.cancel();
      await taps.close();
    });

    test('a failing plugin is swallowed', () async {
      final StreamSubscription<Uri?>? sub = await listenToIdeaWidgetLinks(
        initial: () async => throw StateError('no plugin'),
        clicks: Stream<Uri?>.error(StateError('no plugin')),
      );
      await Future<void>.delayed(Duration.zero);
      expect(ideaDeepLink.value, isNull);
      await sub?.cancel();
    });

    test('off Android, with nothing injected, it does not listen', () async {
      expect(await listenToIdeaWidgetLinks(), isNull);
    });
  });

  group('the Ideas page', () {
    testWidgets('opens the idea of a valid link and consumes it', (
      WidgetTester tester,
    ) async {
      await pumpIdeas(tester, size: const Size(360, 740));
      final IdeaPreset preset = IdeasEngine.presets[3];
      expect(_key('ideas-detail-${preset.id}'), findsNothing);

      openIdeaFromWidgetUri(Uri.parse('inklab://idea/${preset.id}'));
      await tester.pumpAndSettle();

      expect(_key('ideas-detail-${preset.id}'), findsOneWidget);
      expect(ideaDeepLink.value, isNull);
    });

    testWidgets('an unknown id opens nothing', (WidgetTester tester) async {
      await pumpIdeas(tester, size: const Size(360, 740));
      ideaDeepLink.value = 'no_such_idea';
      await tester.pumpAndSettle();

      expect(find.byType(BottomSheet), findsNothing);
      expect(ideaDeepLink.value, isNull);
    });

    testWidgets('a link waiting before the page opens is honoured', (
      WidgetTester tester,
    ) async {
      final IdeaPreset preset = IdeasEngine.presets[5];
      ideaDeepLink.value = preset.id;
      await pumpIdeas(tester, size: const Size(360, 740));
      await tester.pumpAndSettle();

      expect(_key('ideas-detail-${preset.id}'), findsOneWidget);
      expect(ideaDeepLink.value, isNull);
    });
  });

  group('the shell', () {
    testWidgets('switches to the Ideas tab when a link arrives', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);
      useEnglishDevice(tester);
      await tester.pumpWidget(const InkLabApp());
      await tester.pumpAndSettle();
      expect(find.byKey(SwatchesPage.pageKey), findsOneWidget);
      expect(find.byKey(IdeasPage.pageKey), findsNothing);

      openIdeaFromWidgetUri(
        Uri.parse('inklab://idea/${IdeasEngine.presets.first.id}'),
      );
      await tester.pumpAndSettle();

      expect(find.byKey(IdeasPage.pageKey), findsOneWidget);
    });

    testWidgets('a launch link starts the app on the Ideas tab', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);
      useEnglishDevice(tester);
      ideaDeepLink.value = IdeasEngine.presets.first.id;
      await tester.pumpWidget(const InkLabApp());
      await tester.pumpAndSettle();

      expect(find.byKey(IdeasPage.pageKey), findsOneWidget);
    });
  });
}
