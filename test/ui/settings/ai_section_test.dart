import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:ink_lab/ai/ai.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/data/data.dart';
import 'package:ink_lab/ui/pages/settings/ai_section.dart';
import 'package:ink_lab/ui/theme/app_theme.dart';
import 'package:ink_lab/ui/theme/app_typography.dart';
import 'package:ink_lab/ui/widgets/ink_chip.dart';
import 'package:ink_lab/ui/widgets/section_card.dart';

import '../../ai/ai_test_support.dart';
import '../../ai/fake_on_device_platform.dart';
import '../../support/l10n.dart';

const String _key = 'sk-or-v1-abcdef0123456789abcdef0123456789';

MarkerRepository _diskMarkers() =>
    MarkerRepository(loadAsset: (String path) => File(path).readAsStringSync());

/// A store whose reads always fail as "unreadable".
final class _UnreadableSecretStore implements SecretStore {
  const _UnreadableSecretStore();

  @override
  Future<String?> read(String name) async => throw const SecretStoreException(
    'read',
    failure: SecretStoreFailure.unreadable,
  );

  @override
  Future<void> write(String name, String value) async {}

  @override
  Future<void> delete(String name) async {}
}

http.Client _emptyClient() =>
    MockClient((_) async => jsonResponse({'data': <Object>[]}));

/// Pumps just the AI section inside a fresh in-memory scope.
Future<AppScope> pumpSection(
  WidgetTester tester, {
  SecretStore? secrets,
  http.Client? client,
  AiProvider provider = AiProvider.local,
  bool enabled = false,
  OnDeviceAiPlatform? onDevice,
  Duration noProgressAfter = defaultNoProgressAfter,
  // False while a spinner animates for good (the model is downloading).
  bool settle = true,
}) async {
  tester.view.physicalSize = const Size(500, 3000);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  final repo = StoredAiSettingsRepository(InMemoryKeyValueStore());
  await repo.replace(AiSettings(enabled: enabled, provider: provider));
  final resolvedSecrets = secrets ?? InMemorySecretStore();
  final service = AiService(
    aiSettings: repo,
    secrets: resolvedSecrets,
    clientFactory: () => client ?? _emptyClient(),
    // Default: no on-device model, like iOS and unsupported phones.
    onDevice: onDevice ?? const UnsupportedOnDeviceAi(),
    onDeviceNoProgressAfter: noProgressAfter,
  );
  final scope = AppScope.inMemory(
    markers: _diskMarkers(),
    aiSettings: repo,
    secrets: resolvedSecrets,
    aiService: service,
    child: const SizedBox.shrink(),
  );
  await tester.pumpWidget(sectionApp(scope));
  if (settle) {
    await tester.pumpAndSettle();
  } else {
    await tester.pump();
    await tester.pump();
  }
  return scope;
}

void main() {
  group('copy follows the provider', () {
    testWidgets('colour theory is not presented as an AI', (
      WidgetTester tester,
    ) async {
      await pumpSection(
        tester,
        onDevice: FakeOnDevicePlatform(currentStatus: OnDeviceStatus.available),
      );

      expect(
        _text(tester, 'ai-provider-explanation'),
        l10n.settingsAiExplainColourTheory,
      );
      expect(
        find.text(l10n.settingsAiEnabledSubtitleColourTheory),
        findsOneWidget,
      );
      expect(find.textContaining('OpenRouter key'), findsNothing);
      expect(find.text('Local'), findsNothing);
      expect(find.text('Fall back to colour theory'), findsOneWidget);
      expect(
        find.text('If the AI fails, the built-in engine answers instead.'),
        findsOneWidget,
      );

      await tester.tap(find.text(l10n.settingsAiEnabled));
      await tester.pumpAndSettle();
      expect(find.text(l10n.settingsAiDisclosureColourTheory), findsOneWidget);
    });

    testWidgets('on-device says nothing leaves the phone', (
      WidgetTester tester,
    ) async {
      await pumpSection(
        tester,
        provider: AiProvider.onDevice,
        onDevice: FakeOnDevicePlatform(currentStatus: OnDeviceStatus.available),
      );

      expect(
        _text(tester, 'ai-provider-explanation'),
        'Gemini Nano runs on this phone. Nothing leaves your phone.',
      );
      expect(find.text(l10n.settingsAiEnabledSubtitleOnDevice), findsOneWidget);
      expect(find.textContaining('OpenRouter key'), findsNothing);
    });

    testWidgets('OpenRouter says where requests go and that photos stay', (
      WidgetTester tester,
    ) async {
      await pumpSection(tester, provider: AiProvider.openRouter);

      expect(
        _text(tester, 'ai-provider-explanation'),
        'Requests go to openrouter.ai with your own key. Photos are never '
        'sent.',
      );
      expect(
        find.text(l10n.settingsAiEnabledSubtitleOpenRouter),
        findsOneWidget,
      );
    });
  });

  group('on-device download', () {
    const ValueKey<String> downloadKey = ValueKey<String>(
      'ai-on-device-download',
    );
    const ValueKey<String> preparingKey = ValueKey<String>(
      'ai-on-device-preparing',
    );

    (FakeOnDevicePlatform, StreamController<OnDeviceDownloadEvent>) liveFake(
      OnDeviceStatus status,
    ) {
      final StreamController<OnDeviceDownloadEvent> live =
          StreamController<OnDeviceDownloadEvent>();
      addTearDown(() {
        if (!live.isClosed) unawaited(live.close());
      });
      return (
        FakeOnDevicePlatform(currentStatus: status)..downloadController = live,
        live,
      );
    }

    testWidgets('shows bytes, total and percentage from the plugin', (
      WidgetTester tester,
    ) async {
      final (platform, live) = liveFake(OnDeviceStatus.downloadable);
      await pumpSection(
        tester,
        provider: AiProvider.onDevice,
        onDevice: platform,
      );

      await tester.tap(find.byKey(downloadKey));
      await tester.pump();
      live.add(const OnDeviceDownloadStarted(totalBytes: 200 * 1024 * 1024));
      live.add(
        const OnDeviceDownloadProgress(
          50 * 1024 * 1024,
          totalBytes: 200 * 1024 * 1024,
        ),
      );
      await tester.pump();

      expect(
        _text(tester, 'ai-on-device-progress'),
        '50 of 200 MB downloaded (25%)',
      );
      expect(find.byKey(preparingKey), findsNothing);
      live.add(const OnDeviceDownloadCompleted());
      await live.close();
      await tester.pumpAndSettle();
    });

    testWidgets('explains the wait after 60 s without any progress', (
      WidgetTester tester,
    ) async {
      final (platform, live) = liveFake(OnDeviceStatus.downloadable);
      await pumpSection(
        tester,
        provider: AiProvider.onDevice,
        onDevice: platform,
      );

      await tester.tap(find.byKey(downloadKey));
      await tester.pump(const Duration(seconds: 59));
      expect(find.byKey(preparingKey), findsNothing);

      await tester.pump(const Duration(seconds: 2));
      expect(find.byKey(preparingKey), findsOneWidget);
      expect(
        _text(tester, 'ai-on-device-preparing'),
        'Android is preparing the model. This can take a while and may wait '
        'for Wi‑Fi and charging. You can leave this screen; the '
        'download continues in the background.',
      );
      expect(
        find.byKey(const ValueKey<String>('ai-on-device-check-again')),
        findsOneWidget,
      );

      // The first progress event replaces the explanation.
      live.add(const OnDeviceDownloadProgress(1024 * 1024));
      await tester.pump();
      expect(find.byKey(preparingKey), findsNothing);
      expect(
        find.byKey(const ValueKey<String>('ai-on-device-progress')),
        findsOneWidget,
      );
      live.add(const OnDeviceDownloadCompleted());
      await live.close();
      await tester.pumpAndSettle();
    });

    testWidgets('Check again re-reads the status', (WidgetTester tester) async {
      final FakeOnDevicePlatform platform = FakeOnDevicePlatform(
        currentStatus: OnDeviceStatus.downloading,
      );
      await pumpSection(
        tester,
        provider: AiProvider.onDevice,
        onDevice: platform,
        settle: false,
      );
      // A download the app did not start: the calm line shows at once.
      expect(find.byKey(preparingKey), findsOneWidget);
      final int before = platform.statusCalls;

      platform.currentStatus = OnDeviceStatus.available;
      await tester.tap(
        find.byKey(const ValueKey<String>('ai-on-device-check-again')),
      );
      await tester.pumpAndSettle();

      expect(platform.statusCalls, greaterThan(before));
      expect(find.text(l10n.settingsAiOnDeviceReady), findsOneWidget);
    });

    testWidgets('keeps going after the settings widget is disposed', (
      WidgetTester tester,
    ) async {
      final (platform, live) = liveFake(OnDeviceStatus.downloadable);
      final AppScope scope = await pumpSection(
        tester,
        provider: AiProvider.onDevice,
        onDevice: platform,
      );
      await tester.tap(find.byKey(downloadKey));
      await tester.pump();
      final OnDeviceDownloadTracker tracker = scope.aiService.onDeviceDownload;
      expect(tracker.active, isTrue);

      // Leave the settings: the section and its controller are disposed.
      await tester.pumpWidget(const SizedBox.shrink());
      expect(tracker.active, isTrue);
      expect(live.hasListener, isTrue);

      live.add(
        const OnDeviceDownloadProgress(
          10 * 1024 * 1024,
          totalBytes: 40 * 1024 * 1024,
        ),
      );
      await tester.pump();
      expect(tracker.bytes, 10 * 1024 * 1024);
      expect(platform.downloads, 1);

      // Coming back re-attaches to the running download, without a second one.
      await tester.pumpWidget(sectionApp(scope));
      await tester.pump();
      expect(
        _text(tester, 'ai-on-device-progress'),
        '10 of 40 MB downloaded (25%)',
      );
      expect(platform.downloads, 1);

      live.add(const OnDeviceDownloadCompleted());
      await live.close();
      await tester.pumpAndSettle();
      expect(tracker.active, isFalse);
      expect(find.text(l10n.settingsAiOnDeviceReady), findsOneWidget);
    });
  });

  group('on-device provider', () {
    testWidgets('is hidden entirely when the phone has no model', (
      WidgetTester tester,
    ) async {
      await pumpSection(tester);

      expect(find.text(l10n.settingsAiProviderOnDevice), findsNothing);
      expect(find.textContaining('Gemini Nano'), findsNothing);
      expect(find.textContaining('not available'), findsNothing);
      expect(find.text(l10n.settingsAiProviderColourTheory), findsOneWidget);
    });

    testWidgets(
      'a stored on-device choice stays selected while the model is unavailable',
      (WidgetTester tester) async {
        // Right after an app update the platform can briefly report no model.
        // The choice must not look reset to colour theory: it stays selected
        // and the section explains that colour theory answers meanwhile.
        final AppScope scope = await pumpSection(
          tester,
          provider: AiProvider.onDevice,
        );

        expect(find.text(l10n.settingsAiProviderOnDevice), findsOneWidget);
        expect(find.text(l10n.settingsAiProviderColourTheory), findsOneWidget);
        expect(
          tester
              .widget<Text>(
                find.byKey(const ValueKey<String>('ai-on-device-status')),
              )
              .data,
          l10n.settingsAiOnDeviceUnavailable,
        );
        expect(find.text(l10n.settingsAiExplainOnDevice), findsOneWidget);
        // Nothing was rewritten in the stored settings.
        expect(scope.aiSettings.value.provider, AiProvider.onDevice);
      },
    );

    testWidgets('a downloadable model offers the download and its progress', (
      WidgetTester tester,
    ) async {
      final FakeOnDevicePlatform platform = FakeOnDevicePlatform(
        currentStatus: OnDeviceStatus.downloadable,
        downloadEvents: const <OnDeviceDownloadEvent>[
          OnDeviceDownloadStarted(),
          OnDeviceDownloadProgress(3 * 1024 * 1024),
          OnDeviceDownloadCompleted(),
        ],
      );
      await pumpSection(
        tester,
        provider: AiProvider.onDevice,
        onDevice: platform,
      );

      expect(find.text(l10n.settingsAiProviderOnDevice), findsOneWidget);
      expect(find.text(l10n.settingsAiOnDeviceName), findsOneWidget);
      expect(find.text(l10n.settingsAiOnDevicePrivacy), findsOneWidget);
      final Finder download = find.byKey(
        const ValueKey<String>('ai-on-device-download'),
      );
      expect(download, findsOneWidget);

      await tester.tap(download);
      await tester.pumpAndSettle();

      expect(platform.downloads, 1);
      expect(
        tester
            .widget<Text>(
              find.byKey(const ValueKey<String>('ai-on-device-status')),
            )
            .data,
        l10n.settingsAiOnDeviceReady,
      );
      expect(download, findsNothing);
    });

    testWidgets('a ready model can be selected and shows the privacy line', (
      WidgetTester tester,
    ) async {
      await pumpSection(
        tester,
        onDevice: FakeOnDevicePlatform(currentStatus: OnDeviceStatus.available),
      );

      await tester.tap(find.text(l10n.settingsAiProviderOnDevice));
      await tester.pumpAndSettle();

      expect(find.text(l10n.settingsAiOnDeviceReady), findsOneWidget);
      expect(find.text(l10n.settingsAiOnDevicePrivacy), findsOneWidget);
      // No key, no connection test: this provider is not OpenRouter.
      expect(
        find.byKey(const ValueKey<String>('ai-api-key-field')),
        findsNothing,
      );
    });

    testWidgets(
      'the disclosure says on-device requests never leave the phone',
      (WidgetTester tester) async {
        await pumpSection(
          tester,
          provider: AiProvider.onDevice,
          onDevice: FakeOnDevicePlatform(
            currentStatus: OnDeviceStatus.available,
          ),
        );

        await tester.tap(find.text(l10n.settingsAiEnabled));
        await tester.pumpAndSettle();

        expect(find.text(l10n.settingsAiDisclosureOnDevice), findsOneWidget);
        expect(find.textContaining('openrouter.ai'), findsNothing);
      },
    );
  });

  testWidgets('the key field is masked and disables every aid', (
    WidgetTester tester,
  ) async {
    await pumpSection(tester, provider: AiProvider.openRouter);

    final TextField field = tester.widget<TextField>(
      find.byKey(const ValueKey<String>('ai-api-key-field')),
    );
    expect(field.obscureText, isTrue);
    expect(field.autocorrect, isFalse);
    expect(field.enableSuggestions, isFalse);
    expect(field.enableIMEPersonalizedLearning, isFalse);
    expect(field.autofillHints, isNull);
    expect(field.keyboardType, TextInputType.visiblePassword);
  });

  testWidgets('a saved key is replaced by its mask and never echoed', (
    WidgetTester tester,
  ) async {
    await pumpSection(tester, provider: AiProvider.openRouter);

    await tester.enterText(
      find.byKey(const ValueKey<String>('ai-api-key-field')),
      _key,
    );
    await tester.tap(find.byKey(const ValueKey<String>('ai-save-key')));
    await tester.pumpAndSettle();

    expect(
      find.byKey(const ValueKey<String>('ai-api-key-field')),
      findsNothing,
    );
    final Text masked = tester.widget<Text>(
      find.byKey(const ValueKey<String>('ai-masked-key')),
    );
    expect(masked.data, endsWith('6789'));
    expect(masked.data, isNot(contains('abcdef')));
    expect(find.text(_key), findsNothing);
    expect(find.text(l10n.settingsAiApiKeySaved), findsOneWidget);
  });

  testWidgets('an invalid key shows an error without the input', (
    WidgetTester tester,
  ) async {
    await pumpSection(tester, provider: AiProvider.openRouter);

    await tester.enterText(
      find.byKey(const ValueKey<String>('ai-api-key-field')),
      'oops-a-secret',
    );
    await tester.tap(find.byKey(const ValueKey<String>('ai-save-key')));
    await tester.pumpAndSettle();

    expect(find.text(l10n.settingsAiApiKeyInvalid), findsOneWidget);
    final Text error = tester.widget<Text>(
      find.byKey(const ValueKey<String>('ai-key-error')),
    );
    expect(error.data, isNot(contains('oops-a-secret')));
  });

  testWidgets('an unreadable stored key asks the user to enter it again', (
    WidgetTester tester,
  ) async {
    await pumpSection(
      tester,
      secrets: const _UnreadableSecretStore(),
      provider: AiProvider.openRouter,
    );

    expect(find.text(l10n.settingsAiApiKeyUnreadable), findsOneWidget);
  });

  testWidgets('the disclosure is shown before the AI is enabled', (
    WidgetTester tester,
  ) async {
    final AppScope scope = await pumpSection(
      tester,
      provider: AiProvider.openRouter,
    );
    expect(scope.aiSettings.value.enabled, isFalse);

    await tester.tap(find.text(l10n.settingsAiEnabled));
    await tester.pumpAndSettle();

    expect(find.text(l10n.settingsAiDisclosure), findsOneWidget);
    expect(scope.aiSettings.value.enabled, isFalse);

    await tester.tap(
      find.byKey(const ValueKey<String>('ai-disclosure-confirm')),
    );
    await tester.pumpAndSettle();

    expect(scope.aiSettings.value.enabled, isTrue);
  });

  /// A catalog with free, paid and router entries (variable pricing).
  http.Client catalogClient() => MockClient(
    (_) async => jsonResponse({
      'data': [
        {
          'id': 'a:free',
          'name': 'Free A',
          'pricing': {'prompt': '0', 'completion': '0'},
        },
        {
          'id': 'b',
          'name': 'Paid B',
          'pricing': {'prompt': '1', 'completion': '1'},
        },
        {
          'id': 'openrouter/auto',
          'name': 'Auto Router (Beta)',
          'pricing': {'prompt': '-1', 'completion': '-1'},
        },
        for (int i = 0; i < 300; i++)
          {
            'id': 'bulk/model-$i:free',
            'name': 'Bulk $i',
            'pricing': {'prompt': '0', 'completion': '0'},
          },
      ],
    }),
  );

  Future<AppScope> pumpWithCatalog(WidgetTester tester) async {
    final scope = await pumpSection(
      tester,
      provider: AiProvider.openRouter,
      secrets: InMemorySecretStore({openRouterApiKeyName: _key}),
      client: catalogClient(),
    );
    await tester.tap(find.byKey(const ValueKey<String>('ai-load-models')));
    await tester.pumpAndSettle();
    return scope;
  }

  testWidgets('a loaded catalog is a single row, not hundreds of chips', (
    WidgetTester tester,
  ) async {
    await pumpWithCatalog(tester);

    expect(find.byType(InkChip), findsNothing);
    expect(
      find.byKey(const ValueKey<String>('ai-text-model-row')),
      findsOneWidget,
    );
    expect(find.text('Bulk 10'), findsNothing);
  });

  testWidgets('the model row opens a searchable sheet and picks a model', (
    WidgetTester tester,
  ) async {
    final scope = await pumpWithCatalog(tester);

    await tester.tap(find.byKey(const ValueKey<String>('ai-text-model-row')));
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey<String>('ai-model-search')),
      findsOneWidget,
    );

    // Free filter by default: routers and paid models are not listed.
    await tester.enterText(
      find.descendant(
        of: find.byKey(const ValueKey<String>('ai-model-search')),
        matching: find.byType(TextField),
      ),
      'free a',
    );
    await tester.pumpAndSettle();
    expect(find.text('Auto Router (Beta)'), findsNothing);
    expect(find.text('Paid B'), findsNothing);

    await tester.tap(find.byKey(const ValueKey<String>('ai-model-a:free')));
    await tester.pumpAndSettle();

    expect(scope.aiSettings.value.textModel, 'a:free');
    // The sheet closed and the row shows the model name.
    expect(find.byKey(const ValueKey<String>('ai-model-search')), findsNothing);
    expect(find.text('Free A'), findsOneWidget);
  });

  testWidgets('the Free/Paid/Both control filters the sheet', (
    WidgetTester tester,
  ) async {
    await pumpWithCatalog(tester);
    await tester.tap(find.byKey(const ValueKey<String>('ai-text-model-row')));
    await tester.pumpAndSettle();
    final Finder search = find.descendant(
      of: find.byKey(const ValueKey<String>('ai-model-search')),
      matching: find.byType(TextField),
    );
    final Finder paidB = find.byKey(const ValueKey<String>('ai-model-b'));
    final Finder router = find.byKey(
      const ValueKey<String>('ai-model-openrouter/auto'),
    );

    // Free by default: neither the paid model nor the variable-price router.
    await tester.enterText(search, 'auto');
    await tester.pumpAndSettle();
    expect(router, findsNothing);
    await tester.enterText(search, 'paid');
    await tester.pumpAndSettle();
    expect(paidB, findsNothing);

    await tester.tap(find.text(l10n.settingsAiModelsFilterPaid));
    await tester.pumpAndSettle();
    expect(paidB, findsOneWidget);
    expect(
      find.text(AppTypography.caps(l10n.settingsAiModelPaid)),
      findsWidgets,
    );
    // Routers are never suitable for palettes, whatever the price filter.
    await tester.enterText(search, 'auto');
    await tester.pumpAndSettle();
    expect(router, findsNothing);

    await tester.tap(find.text(l10n.settingsAiModelsFilterBoth));
    await tester.pumpAndSettle();
    expect(router, findsNothing);
    await tester.enterText(search, 'free a');
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey<String>('ai-model-a:free')),
      findsOneWidget,
    );
  });

  testWidgets('fallbacks are chosen in the same sheet, up to five', (
    WidgetTester tester,
  ) async {
    final scope = await pumpWithCatalog(tester);
    await tester.tap(find.byKey(const ValueKey<String>('ai-fallbacks-row')));
    await tester.pumpAndSettle();

    // The recommended fallback is already selected, so four more fill it.
    final Finder search = find.descendant(
      of: find.byKey(const ValueKey<String>('ai-model-search')),
      matching: find.byType(TextField),
    );
    for (int i = 0; i < 4; i++) {
      // The list is sorted by name, so bring each model into view first.
      await tester.enterText(search, 'bulk/model-$i:');
      await tester.pumpAndSettle();
      await tester.tap(
        find.byKey(ValueKey<String>('ai-model-bulk/model-$i:free')),
      );
      await tester.pumpAndSettle();
    }
    expect(scope.aiSettings.value.textFallbacks, hasLength(5));

    // A sixth is refused.
    await tester.enterText(search, 'free a');
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey<String>('ai-model-a:free')));
    await tester.pumpAndSettle();
    expect(scope.aiSettings.value.textFallbacks, hasLength(5));
    expect(scope.aiSettings.value.textFallbacks, isNot(contains('a:free')));

    await tester.tap(find.byKey(const ValueKey<String>('ai-model-done')));
    await tester.pumpAndSettle();
    expect(find.text(l10n.settingsAiFallbacksCount(5, 5)), findsOneWidget);
  });

  testWidgets('a typed id can be used without loading the catalog', (
    WidgetTester tester,
  ) async {
    final scope = await pumpSection(tester, provider: AiProvider.openRouter);
    await tester.tap(find.byKey(const ValueKey<String>('ai-text-model-row')));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.descendant(
        of: find.byKey(const ValueKey<String>('ai-model-search')),
        matching: find.byType(TextField),
      ),
      'my/model',
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey<String>('ai-model-use-typed')));
    await tester.pumpAndSettle();

    expect(scope.aiSettings.value.textModel, 'my/model');
  });

  testWidgets('the free-models note keeps the card inner padding', (
    WidgetTester tester,
  ) async {
    await pumpSection(tester, provider: AiProvider.openRouter);

    final Finder note = find.byKey(
      const ValueKey<String>('ai-free-models-note'),
    );
    expect(note, findsOneWidget);
    final Finder card = find.ancestor(
      of: note,
      matching: find.byType(InkListCard),
    );
    final Rect noteRect = tester.getRect(note);
    final Rect cardRect = tester.getRect(card.first);
    expect(noteRect.left - cardRect.left, greaterThanOrEqualTo(16));
    expect(cardRect.right - noteRect.right, greaterThanOrEqualTo(16));
  });
}

Widget sectionApp(AppScope scope) => MaterialApp(
  locale: const Locale('en'),
  localizationsDelegates: testLocalizationsDelegates,
  supportedLocales: testSupportedLocales,
  theme: AppTheme.light(),
  home: Scaffold(
    body: SingleChildScrollView(
      child: AiSettingsSection(scope: scope, changes: scope.aiSettings.changes),
    ),
  ),
);

String _text(WidgetTester tester, String key) =>
    tester.widget<Text>(find.byKey(ValueKey<String>(key))).data!;
