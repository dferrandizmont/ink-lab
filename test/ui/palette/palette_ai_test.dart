import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:ink_lab/ai/ai.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/data/data.dart';

import '../../ai/ai_test_support.dart';
import '../../ai/fake_on_device_platform.dart';
import 'palette_test_support.dart';

const String _key = 'sk-or-v1-abcdef0123456789abcdef0123456789';

/// Pumps the palette page with an AI scope configured as requested.
Future<AppScope> pumpAi(
  WidgetTester tester, {
  required bool enabled,
  required bool withKey,
  http.Client? client,
  String textModel = 'model-a',
}) async {
  final secrets = InMemorySecretStore(
    withKey ? <String, String>{openRouterApiKeyName: _key} : null,
  );
  final repo = StoredAiSettingsRepository(InMemoryKeyValueStore());
  await repo.replace(
    AiSettings(
      enabled: enabled,
      provider: AiProvider.openRouter,
      textModel: textModel,
    ),
  );
  final service = AiService(
    aiSettings: repo,
    secrets: secrets,
    clientFactory: () =>
        client ?? MockClient((_) async => completionResponse('{}')),
  );
  return pumpPalette(
    tester,
    secrets: secrets,
    aiSettings: repo,
    aiService: service,
  );
}

Finder get _aiButton =>
    find.byKey(const ValueKey<String>('palette-suggest-ai'));

/// A transport that echoes back the first candidate code from the prompt.
MockClient _echoCandidateClient({
  String role = 'Shadow',
  String reason = 'deep',
  List<String>? models,
  int count = 1,
}) => MockClient((request) async {
  final body = jsonDecode(request.body) as Map<String, dynamic>;
  models?.add(body['model'] as String);
  final messages = body['messages'] as List;
  final prompt = (messages.last as Map)['content'] as String;
  final codes = prompt
      .split('AVAILABLE_COLORS=')
      .last
      .split(',')
      .take(count)
      .map((entry) => entry.split('#').first);
  return completionResponse(
    paletteJson([
      for (final code in codes) {'code': code, 'role': role, 'reason': reason},
    ]),
  );
});

/// Pumps the palette page with the on-device provider and no key at all.
Future<void> pumpOnDevice(
  WidgetTester tester, {
  required FakeOnDevicePlatform platform,
}) async {
  final secrets = InMemorySecretStore();
  final repo = StoredAiSettingsRepository(InMemoryKeyValueStore());
  await repo.replace(AiSettings(enabled: true, provider: AiProvider.onDevice));
  final service = AiService(
    aiSettings: repo,
    secrets: secrets,
    clientFactory: () => throw StateError('on-device must not use HTTP'),
    onDevice: platform,
  );
  await pumpPalette(
    tester,
    secrets: secrets,
    aiSettings: repo,
    aiService: service,
  );
}

void main() {
  testWidgets('on-device: the button needs a ready model, not a key', (
    WidgetTester tester,
  ) async {
    await pumpOnDevice(
      tester,
      platform: FakeOnDevicePlatform(
        currentStatus: OnDeviceStatus.downloadable,
      ),
    );

    expect(_aiButton, findsNothing);
  });

  testWidgets('on-device: suggesting tags the result AI · on-device', (
    WidgetTester tester,
  ) async {
    await pumpOnDevice(
      tester,
      platform: FakeOnDevicePlatform(
        responder: (prompt) {
          // The on-device prompt lists "CODE | name | #hex" lines and asks for
          // "exactly N items": answer with N of them, a full palette.
          final lines = prompt.split('\n');
          final size = int.parse(
            RegExp(r'exactly (\d+) items').firstMatch(prompt)!.group(1)!,
          );
          final codes = lines
              .skip(lines.indexWhere((l) => l.startsWith('COLORS')) + 1)
              .takeWhile((l) => !l.startsWith('FORMAT'))
              .take(size)
              .map((l) => l.split(' | ').first);
          return paletteJson([
            for (final code in codes)
              {'code': code, 'role': 'Shadow', 'reason': 'deep'},
          ]);
        },
      ),
    );

    await enterBaseCode(tester, 'B08');
    expect(_aiButton, findsOneWidget);
    await tester.tap(_aiButton);
    await tester.pumpAndSettle();

    final badge = tester.widget<Text>(
      find.byKey(const ValueKey<String>('palette-ai-badge')),
    );
    expect(badge.data, 'AI · on-device');
  });

  testWidgets('the AI button is hidden while the AI is disabled', (
    WidgetTester tester,
  ) async {
    await pumpAi(tester, enabled: false, withKey: true);

    expect(_aiButton, findsNothing);
  });

  testWidgets('the AI button is hidden without a key', (
    WidgetTester tester,
  ) async {
    await pumpAi(tester, enabled: true, withKey: false);

    expect(_aiButton, findsNothing);
  });

  testWidgets('the AI button is shown when enabled with a key', (
    WidgetTester tester,
  ) async {
    await pumpAi(tester, enabled: true, withKey: true);

    expect(_aiButton, findsOneWidget);
  });

  testWidgets('suggesting with AI marks the result as AI', (
    WidgetTester tester,
  ) async {
    await pumpAi(
      tester,
      enabled: true,
      withKey: true,
      client: _echoCandidateClient(),
    );

    await enterBaseCode(tester, 'B08');
    await tester.tap(_aiButton);
    await tester.pumpAndSettle();

    expect(
      find.byKey(const ValueKey<String>('palette-ai-badge')),
      findsOneWidget,
    );
    expect(find.textContaining('Combinations ('), findsOneWidget);
  });

  testWidgets('an AI failure falls back to the local result with its message', (
    WidgetTester tester,
  ) async {
    await pumpAi(
      tester,
      enabled: true,
      withKey: true,
      client: MockClient((_) async => errorResponse('no', 401)),
    );

    await enterBaseCode(tester, 'B08');
    await tester.tap(_aiButton);
    await tester.pumpAndSettle();

    expect(
      find.byKey(const ValueKey<String>('palette-ai-badge')),
      findsNothing,
    );
    expect(find.textContaining('AI unavailable'), findsOneWidget);
    expect(find.textContaining('Combinations ('), findsOneWidget);
  });

  testWidgets('each suggestion reads the current model, not the one at init', (
    WidgetTester tester,
  ) async {
    final models = <String>[];
    final scope = await pumpAi(
      tester,
      enabled: true,
      withKey: true,
      client: _echoCandidateClient(models: models),
    );

    await enterBaseCode(tester, 'B08');
    await tester.tap(_aiButton);
    await tester.pumpAndSettle();
    expect(models, ['model-a']);

    // The user changes the model in Settings while this page stays alive.
    await scope.aiSettings.setTextModel('model-b');
    await tester.tap(_aiButton);
    await tester.pumpAndSettle();

    expect(models, ['model-a', 'model-b']);
    expect(find.textContaining('model-b'), findsOneWidget);
  });

  testWidgets('the AI tag shows the short model name and goes on regenerate', (
    WidgetTester tester,
  ) async {
    await pumpAi(
      tester,
      enabled: true,
      withKey: true,
      textModel: 'google/gemini-2.5-flash-lite:free',
      client: _echoCandidateClient(count: 4),
    );

    await enterBaseCode(tester, 'B08');
    await tester.tap(_aiButton);
    await tester.pumpAndSettle();

    final badge = find.byKey(const ValueKey<String>('palette-ai-badge'));
    expect(badge, findsOneWidget);
    expect(tester.widget<Text>(badge).data, 'AI · gemini-2.5-flash-lite');

    await tester.tap(find.byKey(const ValueKey<String>('palette-generate')));
    await tester.pumpAndSettle();

    expect(badge, findsNothing);
  });

  testWidgets('a short AI answer is completed and the tag says so', (
    WidgetTester tester,
  ) async {
    await pumpAi(
      tester,
      enabled: true,
      withKey: true,
      client: _echoCandidateClient(),
    );

    await enterBaseCode(tester, 'B08');
    await tester.tap(_aiButton);
    await tester.pumpAndSettle();

    final badge = find.byKey(const ValueKey<String>('palette-ai-badge'));
    expect(
      tester.widget<Text>(badge).data,
      'AI + colour theory · model-a · 1/4',
    );
    expect(find.textContaining('AI unavailable'), findsNothing);
  });

  testWidgets('a row shows the model role and a reason without its prefix', (
    WidgetTester tester,
  ) async {
    await pumpAi(
      tester,
      enabled: true,
      withKey: true,
      client: _echoCandidateClient(
        role: 'highlight',
        reason: 'Highlight: A darker, more saturated tone',
      ),
    );

    await enterBaseCode(tester, 'B08');
    await tester.tap(_aiButton);
    await tester.pumpAndSettle();

    expect(find.text('HIGHLIGHT'), findsOneWidget);
    expect(find.text('A darker, more saturated tone'), findsOneWidget);
    expect(find.textContaining('Highlight:'), findsNothing);
    // The old role-from-reason guess ("darker" means shadow) is not used.
    expect(find.text('SHADOW'), findsNothing);
  });

  testWidgets('long reasons wrap to three lines and expand on tap', (
    WidgetTester tester,
  ) async {
    final reason = List.filled(40, 'soft').join(' ');
    await pumpAi(
      tester,
      enabled: true,
      withKey: true,
      client: _echoCandidateClient(reason: reason),
    );

    await enterBaseCode(tester, 'B08');
    await tester.tap(_aiButton);
    await tester.pumpAndSettle();

    final why = find.byWidgetPredicate(
      (w) =>
          w.key is ValueKey<String> &&
          (w.key! as ValueKey<String>).value.startsWith('palette-row-why-'),
    );
    // The model's own row comes first; colour theory completes the rest.
    expect(tester.widget<Text>(why.first).maxLines, 3);
    await tester.tap(why.first);
    await tester.pumpAndSettle();
    expect(tester.widget<Text>(why.first).maxLines, isNull);
    await tester.tap(why.first);
    await tester.pumpAndSettle();
    expect(tester.widget<Text>(why.first).maxLines, 3);
  });
}
