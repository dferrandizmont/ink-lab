import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:ink_lab/ui/widgets/ink_segmented.dart';
import 'package:ink_lab/ui/widgets/palette_strip.dart';

import '../../ai/ai_test_support.dart';
import 'palette_ai_test.dart' show pumpAi;
import 'palette_test_support.dart';
import '../../support/l10n.dart';

Finder get _baseInput =>
    find.byKey(const ValueKey<String>('palette-base-input'));
Finder get _options =>
    find.byKey(const ValueKey<String>('palette-base-options'));
Finder get _aiButton =>
    find.byKey(const ValueKey<String>('palette-suggest-ai'));

PaletteStrip _strip(WidgetTester tester) =>
    tester.widget<PaletteStrip>(find.byType(PaletteStrip).first);

/// Answers with the first candidate code found in the prompt.
http.Response _echoCandidate(http.Request request) {
  final body = jsonDecode(request.body) as Map<String, dynamic>;
  final messages = body['messages'] as List;
  final prompt = (messages.last as Map)['content'] as String;
  final code = prompt
      .split('AVAILABLE_COLORS=')
      .last
      .split(',')
      .first
      .split('#')
      .first;
  return completionResponse(
    paletteJson(<Map<String, String>>[
      <String, String>{'code': code, 'role': 'Shadow', 'reason': 'deep'},
    ]),
  );
}

void main() {
  group('the base is the first band of the strip', () {
    testWidgets('size counts the base: 5 colours is the base plus 4', (
      WidgetTester tester,
    ) async {
      await pumpPalette(tester);
      await enterBaseCode(tester, 'B08');

      final PaletteStrip strip = _strip(tester);
      expect(strip.labels!.first, 'B08');
      expect(strip.colors, hasLength(5));
      expect(strip.lockedIndices, contains(0));
      expect(find.text('Combinations (5)'), findsOneWidget);
      // The paint order lists the base first and uses the same colours.
      expect(
        find.byKey(const ValueKey<String>('palette-step-zone-1')),
        findsOneWidget,
      );
      expect(find.text(l10n.roleBase), findsWidgets);
    });

    for (final int size in <int>[3, 4]) {
      testWidgets('size $size gives $size colours including the base', (
        WidgetTester tester,
      ) async {
        await pumpPalette(tester);
        await enterBaseCode(tester, 'B08');
        await tester.tap(
          find.descendant(
            of: find.byType(InkSegmented<int>),
            matching: find.text('$size'),
          ),
        );
        await tester.pumpAndSettle();

        final PaletteStrip strip = _strip(tester);
        expect(strip.colors, hasLength(size));
        expect(strip.labels!.first, 'B08');
        expect(find.text('Combinations ($size)'), findsOneWidget);
      });
    }
  });

  group('base marker suggestions', () {
    Future<void> typeWithoutUnfocus(WidgetTester tester, String text) async {
      await tester.tap(_baseInput);
      await tester.enterText(_baseInput, text);
      await tester.pumpAndSettle();
    }

    testWidgets('close when a suggestion is picked', (
      WidgetTester tester,
    ) async {
      await pumpPalette(tester);
      await typeWithoutUnfocus(tester, 'B0');
      expect(_options, findsOneWidget);

      await tester.tap(
        find.descendant(of: _options, matching: find.byType(InkWell)).first,
      );
      await tester.pumpAndSettle();

      expect(_options, findsNothing);
      expect(tester.widget<TextField>(_baseInput).focusNode!.hasFocus, isFalse);
      expect(find.textContaining('Combinations ('), findsOneWidget);
    });

    testWidgets('close when the field loses focus', (
      WidgetTester tester,
    ) async {
      await pumpPalette(tester);
      await typeWithoutUnfocus(tester, 'B0');
      expect(_options, findsOneWidget);

      await tester.tapAt(const Offset(590, 2990));
      await tester.pumpAndSettle();

      expect(_options, findsNothing);
    });

    testWidgets('close when the page scrolls', (WidgetTester tester) async {
      await pumpPalette(tester);
      await enterBaseCode(tester, 'B08');
      await typeWithoutUnfocus(tester, 'B1');
      expect(_options, findsOneWidget);

      tester.view.physicalSize = const Size(600, 500);
      await tester.pumpAndSettle();
      await tester.drag(
        find.byType(ListView).first,
        const Offset(0, -150),
        warnIfMissed: false,
      );
      await tester.pumpAndSettle();

      expect(_options, findsNothing);
    });
  });

  group('Suggest with AI', () {
    testWidgets('shows a spinner while it works, then the AI model label', (
      WidgetTester tester,
    ) async {
      final Completer<void> pending = Completer<void>();
      await pumpAi(
        tester,
        enabled: true,
        withKey: true,
        client: MockClient((http.Request request) async {
          await pending.future;
          return _echoCandidate(request);
        }),
      );
      await enterBaseCode(tester, 'B08');

      await tester.tap(_aiButton);
      await tester.pump();

      final Finder spinner = find.descendant(
        of: _aiButton,
        matching: find.byType(CircularProgressIndicator),
      );
      expect(spinner, findsOneWidget);
      expect(find.text(l10n.paletteSuggestAiLoading), findsOneWidget);
      expect(
        tester
            .widget<OutlinedButton>(
              find.descendant(
                of: _aiButton,
                matching: find.byType(OutlinedButton),
              ),
            )
            .onPressed,
        isNull,
      );

      pending.complete();
      await tester.pumpAndSettle();

      expect(spinner, findsNothing);
      expect(
        find.text(l10n.aiResultLabel('model-a', aiCount: 1, total: 4)),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    });

    testWidgets('an error shows its typed message and keeps the local result', (
      WidgetTester tester,
    ) async {
      await pumpAi(
        tester,
        enabled: true,
        withKey: true,
        client: MockClient((_) async => errorResponse('no', 401)),
      );
      await enterBaseCode(tester, 'B08');
      final List<String> before = _strip(tester).labels!;

      await tester.tap(_aiButton);
      await tester.pumpAndSettle();

      expect(
        find.descendant(
          of: find.byKey(const ValueKey<String>('palette-ai-error')),
          matching: find.textContaining('The API key was rejected'),
        ),
        findsOneWidget,
      );
      expect(_strip(tester).labels, before);
      expect(
        find.byKey(const ValueKey<String>('palette-ai-badge')),
        findsNothing,
      );
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });
}
