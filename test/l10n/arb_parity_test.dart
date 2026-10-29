import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

Map<String, dynamic> _arb(String locale) =>
    jsonDecode(File('lib/l10n/app_$locale.arb').readAsStringSync())
        as Map<String, dynamic>;

Set<String> _messageKeys(Map<String, dynamic> arb) => {
  for (final String key in arb.keys)
    if (!key.startsWith('@')) key,
};

/// Names used as `{name}` placeholders or ICU arguments in a message.
Set<String> _placeholders(String message) => {
  for (final RegExpMatch m in RegExp(r'\{(\w+)[,}]').allMatches(message))
    m.group(1)!,
};

void main() {
  final Map<String, dynamic> en = _arb('en');
  final Map<String, dynamic> es = _arb('es');

  test('English and Spanish define exactly the same messages', () {
    expect(_messageKeys(es), _messageKeys(en));
  });

  test('every message has non-empty text in both languages', () {
    for (final String key in _messageKeys(en)) {
      expect((en[key] as String).trim(), isNotEmpty, reason: 'en $key');
      expect((es[key] as String).trim(), isNotEmpty, reason: 'es $key');
    }
  });

  test('Spanish messages use the same placeholders as English', () {
    for (final String key in _messageKeys(en)) {
      expect(
        _placeholders(es[key] as String),
        _placeholders(en[key] as String),
        reason: key,
      );
    }
  });

  test('the Spanish text is really translated', () {
    // Brand names, units, codes and words that are the same in both
    // languages. Anything else equal to English is a missing translation.
    const Set<String> sameInBoth = <String>{
      'appTitle',
      'commonOk',
      'commonDeltaE',
      'collectionFamilyChip',
      'collectionSets',
      'commonRgb',
      'ideasMarkerSemantic',
      'ideasMinutes',
      'ideasRoleBase',
      'ideasTitle',
      'matchDeltaMethod',
      'matchOkButton',
      'packFullLabel',
      'packLabel48Pastel',
      'packLabelPastel',
      'paletteOkButton',
      'reasonVariation',
      'roleBase',
      'settingsAiProviderOpenRouter',
      'settingsLanguageEnglish',
      'settingsLanguageSpanish',
      'settingsPaletteDescription',
      'swatchesAlternativeSemantics',
      'swatchesDeltaEUnit',
      'swatchesHex',
      'swatchesLabelPack',
      'swatchesScopePack',
    };
    final Set<String> identical = <String>{
      for (final String key in _messageKeys(en))
        if (en[key] == es[key]) key,
    };
    expect(identical, sameInBoth);
  });
}
