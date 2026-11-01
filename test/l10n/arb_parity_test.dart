import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Every language of the app besides the English template.
const List<String> _others = <String>['es', 'de', 'fr', 'pt', 'it'];

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

/// Brand names, units, codes and words that are the same in every language.
const Set<String> _sameEverywhere = <String>{
  'appTitle',
  'collectionFamilyChip',
  'commonDeltaE',
  'commonOk',
  'commonRgb',
  'matchDeltaMethod',
  'matchOkButton',
  'packFullLabel',
  'paletteOkButton',
  'settingsAiProviderOpenRouter',
  'settingsLanguageEnglish',
  'settingsLanguageFrench',
  'settingsLanguageGerman',
  'settingsLanguageItalian',
  'settingsLanguagePortuguese',
  'settingsLanguageSpanish',
  'settingsPaletteDescription',
  'swatchesDeltaEUnit',
  'swatchesHex',
};

/// What else a language legitimately spells like English (loanwords, product
/// line names, templates made only of placeholders). Anything else equal to
/// English is a missing translation.
const Map<String, Set<String>> _sameInLanguage = <String, Set<String>>{
  'es': <String>{
    'collectionSets',
    'ideasMarkerSemantic',
    'ideasMinutes',
    'ideasRoleBase',
    'ideasTitle',
    'packLabel48Pastel',
    'packLabelPastel',
    'reasonVariation',
    'roleBase',
    'swatchesAlternativeSemantics',
    'swatchesLabelPack',
    'swatchesScopePack',
  },
  'de': <String>{
    'diaryPaletteTitle',
    'diaryStatusLabel',
    'categoryChallenges',
    'categorySignature',
    'ideasMarkerSemantic',
    'packLabelBasic',
    'packLabelBlossomPastels',
    'packLabelIllustration',
    'packLabelJapanVersion',
    'packLabelMidTones',
    'packLabelSweetPastels',
    'packLabelWhiteCase',
    'packLabelWhiteCaseVersion',
    'paletteChainOption',
    'paletteTitle',
    'reasonVariation',
    'roleNeutral',
    'sceneCategoryFantasy',
    'settingsAppearanceSystem',
    'settingsExportBackup',
    'settingsImportBackup',
    'settingsLanguageSystem',
    'settingsVersion',
    'swatchesClassicPack',
    'swatchesLabelPack',
    'swatchesScopePack',
    'variationPrefixWarm',
  },
  'fr': <String>{
    'diaryDateLabel',
    'diaryNotesLabel',
    'diaryPaletteTitle',
    'diaryPhotosTitle',
    'categorySignature',
    'ideasCategoryTechnique',
    'ideasMinutes',
    'ideasRoleAccent',
    'ideasRoleBase',
    'ideasRoleBlush',
    'matchAlternatesTitle',
    'modeMonochrome',
    'modeRectangle',
    'packLabel48Pastel',
    'packLabelIllustration',
    'packLabelPastel',
    'packLabelPastels',
    'paletteChainOption',
    'paletteTitle',
    'roleAccent',
    'roleBase',
    'sceneCategoryFantasy',
    'sceneCategoryNature',
    'settingsVersion',
    'swatchesAlternativeSemantics',
    'swatchesCatalogueLabel',
  },
  'pt': <String>{
    'ideasMarkerSemantic',
    'ideasMinutes',
    'ideasRoleBase',
    'ideasRoleBlush',
    'packLabel48Pastel',
    'packLabelPastel',
    'reasonVariation',
    'roleBase',
    'swatchesAlternativeSemantics',
  },
  'it': <String>{
    'diaryPaletteTitle',
    'ideasMarkerSemantic',
    'matchCameraButton',
    'ideasMinutes',
    'ideasRoleBase',
    'paletteTitle',
    'reasonVariation',
    'roleBase',
    'sceneCategoryFantasy',
    'settingsBackupTitle',
    'swatchesAlternativeSemantics',
    'swatchesClassicPack',
    'swatchesLabelPack',
  },
};

void main() {
  final Map<String, dynamic> en = _arb('en');
  final Map<String, Map<String, dynamic>> arbs = <String, Map<String, dynamic>>{
    for (final String locale in _others) locale: _arb(locale),
  };

  test('the template declares its own locale and the others theirs', () {
    expect(en['@@locale'], 'en');
    for (final String locale in _others) {
      expect(arbs[locale]!['@@locale'], locale, reason: locale);
    }
  });

  for (final String locale in _others) {
    group(locale, () {
      final Map<String, dynamic> arb = arbs[locale]!;

      test('defines exactly the same messages as English', () {
        expect(_messageKeys(arb), _messageKeys(en));
      });

      test('every message has non-empty text', () {
        for (final String key in _messageKeys(en)) {
          expect((en[key] as String).trim(), isNotEmpty, reason: 'en $key');
          expect((arb[key] as String).trim(), isNotEmpty, reason: key);
        }
      });

      test('uses the same placeholders as English', () {
        for (final String key in _messageKeys(en)) {
          expect(
            _placeholders(arb[key] as String),
            _placeholders(en[key] as String),
            reason: key,
          );
        }
      });

      test('is really translated', () {
        final Set<String> identical = <String>{
          for (final String key in _messageKeys(en))
            if (en[key] == arb[key]) key,
        };
        expect(identical, <String>{
          ..._sameEverywhere,
          ..._sameInLanguage[locale]!,
        });
      });

      test('names the six languages, each in itself', () {
        expect(arb['settingsLanguageSpanish'], 'Español');
        expect(arb['settingsLanguageEnglish'], 'English');
        expect(arb['settingsLanguageGerman'], 'Deutsch');
        expect(arb['settingsLanguageFrench'], 'Français');
        expect(arb['settingsLanguagePortuguese'], 'Português');
        expect(arb['settingsLanguageItalian'], 'Italiano');
      });
    });
  }

  test('no language has metadata keys the template does not declare', () {
    final Set<String> declared = <String>{
      for (final String key in en.keys)
        if (key.startsWith('@') && !key.startsWith('@@')) key,
    };
    for (final String locale in _others) {
      final Set<String> own = <String>{
        for (final String key in arbs[locale]!.keys)
          if (key.startsWith('@') && !key.startsWith('@@')) key,
      };
      expect(own.difference(declared), isEmpty, reason: locale);
    }
  });
}
