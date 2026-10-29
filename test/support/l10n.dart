import 'package:flutter/services.dart' show FontLoader, rootBundle;
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/l10n/l10n.dart';

export 'package:ink_lab/l10n/l10n.dart';

/// The English messages. Tests that match visible text use this with an
/// explicit `locale: const Locale('en')` so they never depend on the machine.
final AppLocalizations l10n = lookupAppLocalizations(const Locale('en'));

/// The Spanish messages, for the Spanish-locale tests.
final AppLocalizations l10nEs = lookupAppLocalizations(const Locale('es'));

/// Localization delegates for a bare `MaterialApp` in a test.
const Iterable<LocalizationsDelegate<dynamic>> testLocalizationsDelegates =
    AppLocalizations.localizationsDelegates;

/// Supported locales for a bare `MaterialApp` in a test.
const Iterable<Locale> testSupportedLocales = AppLocalizations.supportedLocales;

/// Makes the test device report English, so tests that pump the whole app
/// (which follows the device locale) match the English messages whatever the
/// machine running them is set to.
void useEnglishDevice(WidgetTester tester) {
  useDeviceLocales(tester, const <Locale>[Locale('en', 'US')]);
}

/// Makes the test device report [locales] (first one preferred).
void useDeviceLocales(WidgetTester tester, List<Locale> locales) {
  tester.platformDispatcher.localesTestValue = locales;
  tester.platformDispatcher.localeTestValue = locales.first;
  addTearDown(() {
    tester.platformDispatcher.clearLocalesTestValue();
    tester.platformDispatcher.clearLocaleTestValue();
  });
}

/// Loads the bundled app fonts, so text is measured with the real metrics
/// instead of the test font (which makes every glyph one em wide and hides
/// or invents overflows). Call it from `setUpAll`.
Future<void> loadAppFonts() async {
  Future<void> load(String family, String asset) async {
    final FontLoader loader = FontLoader(family)
      ..addFont(rootBundle.load(asset));
    await loader.load();
  }

  await load('Inter', 'assets/fonts/inter_variable.ttf');
  await load('Archivo', 'assets/fonts/archivo_variable.ttf');
  await load('JetBrainsMono', 'assets/fonts/jetbrains_mono_variable.ttf');
}
