import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:ink_lab/ai/ai.dart';
import 'package:ink_lab/data/data.dart';

import '../../ai/ai_test_support.dart';
import 'palette_test_support.dart';

const String _key = 'sk-or-v1-abcdef0123456789abcdef0123456789';

Finder _k(String key) => find.byKey(ValueKey<String>(key));

http.Client _echoClient() => MockClient((request) async {
  final body = jsonDecode(request.body) as Map<String, dynamic>;
  final prompt = ((body['messages'] as List).last as Map)['content'] as String;
  final codes = prompt
      .split('AVAILABLE_COLORS=')
      .last
      .split(',')
      .take(2)
      .map((entry) => entry.split('#').first);
  return completionResponse(
    paletteJson([
      for (final code in codes)
        {'code': code, 'role': 'Shadow', 'reason': 'deep tone'},
    ]),
  );
});

Future<void> _pump(
  WidgetTester tester, {
  Future<bool> Function(Uri uri)? launchEmail,
}) async {
  final secrets = InMemorySecretStore(<String, String>{
    openRouterApiKeyName: _key,
  });
  final repo = StoredAiSettingsRepository(InMemoryKeyValueStore());
  await repo.replace(
    AiSettings(
      enabled: true,
      provider: AiProvider.openRouter,
      textModel: 'model-a',
    ),
  );
  final service = AiService(
    aiSettings: repo,
    secrets: secrets,
    clientFactory: _echoClient,
  );
  await pumpPalette(
    tester,
    secrets: secrets,
    aiSettings: repo,
    aiService: service,
    launchEmail: launchEmail,
  );
}

Future<void> _suggest(WidgetTester tester) async {
  await enterBaseCode(tester, 'B08');
  await tester.ensureVisible(_k('palette-suggest-ai'));
  await tester.tap(_k('palette-suggest-ai'));
  await tester.pumpAndSettle();
}

Future<void> _openDialog(WidgetTester tester) async {
  await tester.ensureVisible(_k('palette-ai-report'));
  await tester.pumpAndSettle();
  await tester.tap(_k('palette-ai-report'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('hidden without an AI result, shown after one, gone on Clear', (
    WidgetTester tester,
  ) async {
    await _pump(tester);
    await enterBaseCode(tester, 'B08');
    expect(_k('palette-ai-report'), findsNothing);

    await _suggest(tester);
    expect(_k('palette-ai-badge'), findsOneWidget);
    expect(_k('palette-ai-report'), findsOneWidget);
    expect(find.text('Report this suggestion'), findsOneWidget);

    await tester.ensureVisible(_k('palette-clear'));
    await tester.tap(_k('palette-clear'));
    await tester.pumpAndSettle();
    expect(_k('palette-ai-report'), findsNothing);
  });

  testWidgets('hidden again after switching the palette type', (
    WidgetTester tester,
  ) async {
    await _pump(tester);
    await _suggest(tester);
    expect(_k('palette-ai-report'), findsOneWidget);

    await choosePaletteType(tester, 'palette-mode-complementary');
    expect(_k('palette-ai-report'), findsNothing);
  });

  testWidgets('Send stays disabled until a reason is chosen', (
    WidgetTester tester,
  ) async {
    await _pump(tester);
    await _suggest(tester);
    await _openDialog(tester);

    FilledButton send() =>
        tester.widget<FilledButton>(_k('palette-ai-report-send'));
    expect(send().onPressed, isNull);
    await tester.tap(_k('palette-ai-report-wrong'));
    await tester.pumpAndSettle();
    expect(send().onPressed, isNotNull);
  });

  testWidgets('Send opens a mailto to the developer, with no API key', (
    WidgetTester tester,
  ) async {
    final List<Uri> launched = <Uri>[];
    await _pump(
      tester,
      launchEmail: (Uri uri) async {
        launched.add(uri);
        return true;
      },
    );
    await _suggest(tester);
    await _openDialog(tester);
    await tester.tap(_k('palette-ai-report-offensive'));
    await tester.pumpAndSettle();
    await tester.tap(_k('palette-ai-report-send'));
    await tester.pumpAndSettle();

    expect(launched, hasLength(1));
    expect(launched.single.scheme, 'mailto');
    expect(launched.single.path, 'dev@mainshai.com');
    final String text = launched.single.toString();
    expect(text, contains('(offensive)'));
    expect(text, contains('model-a'));
    expect(text, isNot(contains(_key)));
    expect(
      find.text('Thanks, this helps us improve the suggestions'),
      findsOneWidget,
    );
  });

  testWidgets('no email app: the report is copied and the fallback is shown', (
    WidgetTester tester,
  ) async {
    String? copied;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (MethodCall call) async {
        if (call.method == 'Clipboard.setData') {
          copied = (call.arguments as Map)['text'] as String;
        }
        return null;
      },
    );
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      ),
    );
    await _pump(tester, launchEmail: (Uri uri) async => false);
    await _suggest(tester);
    await _openDialog(tester);
    await tester.tap(_k('palette-ai-report-other'));
    await tester.pumpAndSettle();
    await tester.tap(_k('palette-ai-report-send'));
    await tester.pumpAndSettle();

    expect(copied, isNotNull);
    expect(copied, contains('To: dev@mainshai.com'));
    expect(copied, contains('Subject: Ink Lab: AI suggestion report (other)'));
    expect(copied, isNot(contains(_key)));
    expect(
      find.textContaining('No email app found. The report was copied'),
      findsOneWidget,
    );
  });
}
