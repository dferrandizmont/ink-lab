import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/app_scope.dart';
import 'package:ink_lab/data/data.dart';
import 'package:ink_lab/data/review_prompt.dart';
import 'package:ink_lab/ui/pages/settings/settings_page.dart';
import 'package:ink_lab/ui/theme/app_theme.dart';

import '../../support/l10n.dart';
import 'settings_page_test.dart' show diskMarkers;

/// A store that only counts how often its listing is opened.
class _FakeStore implements StoreReviewer {
  int listings = 0;

  @override
  Future<bool> isAvailable() async => true;

  @override
  Future<void> requestReview() async {}

  @override
  Future<void> openStoreListing() async => listings++;
}

Finder _rate() => find.byKey(const ValueKey<String>('settings-rate'));

Future<void> _pump(WidgetTester tester, {StoreReviewer? store}) async {
  tester.view.physicalSize = const Size(390, 1800);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: testLocalizationsDelegates,
      supportedLocales: testSupportedLocales,
      theme: AppTheme.light(),
      home: Scaffold(
        body: AppScope.inMemory(
          markers: diskMarkers(),
          storeReviewer: store,
          child: const SettingsPage(),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(loadAppFonts);

  testWidgets('with a store the row is shown and opens the listing once', (
    WidgetTester tester,
  ) async {
    final _FakeStore store = _FakeStore();
    await _pump(tester, store: store);
    await tester.ensureVisible(_rate());
    await tester.pumpAndSettle();

    expect(_rate(), findsOneWidget);
    expect(find.text(l10n.settingsRateApp), findsOneWidget);
    expect(find.text(l10n.settingsRateAppSubtitle), findsOneWidget);

    await tester.tap(_rate());
    await tester.pumpAndSettle();
    expect(store.listings, 1);
  });

  testWidgets('without a store the row is absent', (WidgetTester tester) async {
    await _pump(tester);
    await tester.drag(
      find.byType(Scrollable).first,
      const Offset(0, -3000),
    );
    await tester.pumpAndSettle();

    // The About card is built (its neighbour is there), the row is not.
    expect(
      find.byKey(const ValueKey<String>('settings-feedback')),
      findsOneWidget,
    );
    expect(_rate(), findsNothing);
    expect(find.text(l10n.settingsRateApp), findsNothing);
  });
}
