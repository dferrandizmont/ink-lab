import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/ai/palette_advisor.dart' as ai;
import 'package:ink_lab/core/collection_selection.dart';
import 'package:ink_lab/core/ideas_engine.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/core/scene_catalog.dart';
import 'package:ink_lab/core/palette_generator.dart';

import '../support/l10n.dart';

/// The English texts that [t]'s language spells the same (brand names, loanwords:
/// listed and vetted in arb_parity_test.dart).
Set<String> _sameAsEnglish(AppLocalizations t) {
  Map<String, dynamic> arb(String code) =>
      jsonDecode(File('lib/l10n/app_$code.arb').readAsStringSync())
          as Map<String, dynamic>;
  final Map<String, dynamic> en = arb('en');
  final Map<String, dynamic> own = arb(t.localeName);
  return <String>{
    for (final MapEntry<String, dynamic> e in en.entries)
      if (!e.key.startsWith('@') && own[e.key] == e.value) e.value as String,
  };
}

/// Scene names and roles that a language writes like English (loanwords).
const Map<String, Set<String>> _sameWord = <String, Set<String>>{
  'de': <String>{'Gold'},
  'fr': <String>{'Dragon'},
  'it': <String>{'Denim', 'Terracotta'},
};

/// Expects [actual] to differ from [english], unless the language really
/// writes that word the same.
void _expectTranslated(
  AppLocalizations t,
  String actual,
  String english, {
  required String reason,
}) {
  if (actual != english) return;
  if (_sameWord[t.localeName]?.contains(english) ?? false) return;
  expect(
    _sameAsEnglish(t),
    contains(english),
    reason: '${t.localeName} untranslated: $reason',
  );
}

void main() {
  final List<MarkerColor> ohuhu = parseColors(
    File(MarkerBrand.ohuhuOahu.assetPath).readAsStringSync(),
    brand: MarkerBrand.ohuhuOahu,
  );
  final List<MarkerColor> collection = paletteCandidateColors(
    colors: ohuhu,
    brand: MarkerBrand.ohuhuOahu,
    activeSetIds: <String>{'classic_160'},
  );
  final MarkerColor base = collection.firstWhere((c) => c.newCode != '0');

  group('enum labels', () {
    test('English keeps the original labels', () {
      for (final PaletteMode m in PaletteMode.values) {
        expect(l10n.modeLabel(m), m.label);
      }
      for (final Scene s in SceneCatalog.current.scenes) {
        expect(l10n.scenarioLabel(s), s.label);
      }
      for (final OahuSet s in OahuSet.values) {
        expect(l10n.packSetLabel(s), s.label);
      }
      for (final IdeaCategory c in IdeaCategory.values) {
        expect(l10n.ideaCategoryLabel(c), c.label);
      }
      for (final QuickPaletteVariation v in QuickPaletteVariation.values) {
        expect(l10n.variationName(v), v.label);
      }
    });

    test('every other language translates every one', () {
      for (final AppLocalizations t in l10nTranslated) {
        for (final PaletteMode m in PaletteMode.values) {
          _expectTranslated(t, t.modeLabel(m), m.label, reason: m.name);
        }
        for (final Scene s in SceneCatalog.current.scenes) {
          // The scene names live in scenes.json, not in the ARBs.
          _expectTranslated(t, t.scenarioLabel(s), s.label, reason: s.id);
          expect(t.scenarioLabel(s), s.names[t.localeName], reason: s.id);
        }
        for (final IdeaCategory c in IdeaCategory.values) {
          _expectTranslated(t, t.ideaCategoryLabel(c), c.label, reason: c.name);
        }
        for (final QuickPaletteVariation v in QuickPaletteVariation.values) {
          _expectTranslated(t, t.variationName(v), v.label, reason: v.name);
        }
        for (final OahuSet s in OahuSet.values) {
          expect(
            t.packSetLabel(s),
            isNotEmpty,
            reason: '${t.localeName} ${s.name}',
          );
        }
      }
      expect(l10nEs.packSetLabel(OahuSet.new120), '120 Nuevo');
      expect(l10nEs.packSetLabel(OahuSet.classic160), '160');
    });
  });

  group('reasons and roles of the core engines', () {
    /// Every reason the engines can write for this collection.
    Set<String> allReasons() {
      final Set<String> reasons = <String>{};
      for (final PaletteMode mode in PaletteMode.values) {
        for (final s in buildPalette(base, collection, mode, size: 5)) {
          reasons.add(s.reason);
        }
      }
      for (final Scene scenario in SceneCatalog.current.scenes) {
        for (var token = 0; token < 3; token++) {
          for (final s in buildScenarioPalette(
            base,
            collection,
            scenario,
            size: 5,
            variationToken: token,
          )) {
            reasons.add(s.reason);
          }
        }
      }
      final List<PaletteSuggestion> current = buildPalette(
        base,
        collection,
        PaletteMode.recommended,
        size: 5,
      );
      for (final QuickPaletteVariation v in QuickPaletteVariation.values) {
        for (final s in remixPaletteWithVariation(
          current,
          collection,
          <String>{current.first.color.newCode},
          base.newCode,
          v,
          size: 5,
        )) {
          reasons.add(s.reason);
        }
      }
      return reasons;
    }

    test('are kept as-is in English and all translated in the others', () {
      final Set<String> reasons = allReasons();
      expect(reasons.length, greaterThan(40));
      for (final String reason in reasons) {
        expect(l10n.reasonLabel(reason), reason);
        for (final AppLocalizations t in l10nTranslated) {
          final String text = t.reasonLabel(reason);
          _expectTranslated(t, text, reason, reason: reason);
          expect(text, isNot(contains('deg)')), reason: reason);
        }
      }
    });

    test('the roles of every scene read in every language', () {
      final Set<String> roles = <String>{
        for (final Scene s in SceneCatalog.current.scenes)
          for (final ScenarioTarget target in s.targets) target.role,
      };
      expect(roles.length, greaterThan(200));
      for (final String role in roles) {
        expect(l10n.reasonLabel(role), role);
        for (final AppLocalizations t in l10nTranslated) {
          final String text = t.reasonLabel(role);
          expect(text.trim(), isNotEmpty, reason: '${t.localeName} $role');
          _expectTranslated(t, text, role, reason: role);
        }
      }
    });

    test('parametrised reasons keep their numbers', () {
      expect(
        l10nEs.reasonLabel('Nearby hue harmony (24deg)'),
        'Armonía de matiz cercano (24°)',
      );
      expect(
        l10nEs.reasonLabel('Shadow tone (18% darker)'),
        'Tono de sombra (18 % más oscuro)',
      );
      expect(
        l10nEs.reasonLabel('Vibrant: Balanced pairing'),
        'Vivo: Combinación equilibrada',
      );
    });

    test('free text from an AI model is left untouched', () {
      expect(
        l10nEs.reasonLabel('A lovely teal for the water'),
        'A lovely teal for the water',
      );
    });
  });

  group('ideas', () {
    test('every idea has its texts, steps and translation', () {
      for (final IdeaPreset preset in IdeasEngine.presets) {
        expect(l10n.ideaTitle(preset), preset.title);
        expect(l10n.ideaSummary(preset), preset.summary);
        for (final AppLocalizations t in <AppLocalizations>[
          l10n,
          ...l10nTranslated,
        ]) {
          expect(
            t.ideaStepsText(preset.id).length,
            preset.stepRoles.length,
            reason: '${t.localeName} ${preset.id}',
          );
          expect(t.ideaPracticeText(preset.id), isNotEmpty);
          expect(t.ideaSubjectText(preset.id), isNotEmpty);
          expect(t.ideaTipText(preset.id), isNotEmpty);
          expect(t.ideaMaterialsText(preset.materials), endsWith('.'));
        }
        for (final AppLocalizations t in l10nTranslated) {
          final String reason = '${t.localeName} ${preset.id}';
          _expectTranslated(
            t,
            t.ideaTitle(preset),
            preset.title,
            reason: reason,
          );
          expect(t.ideaSummary(preset), isNot(preset.summary), reason: reason);
          expect(
            t.ideaStepsText(preset.id),
            isNot(l10n.ideaStepsText(preset.id)),
            reason: reason,
          );
        }
      }
      // No two ideas share the same steps.
      final Set<String> steps = <String>{
        for (final IdeaPreset p in IdeasEngine.presets)
          l10n.ideaStepsText(p.id).join('|'),
      };
      expect(steps.length, IdeasEngine.presets.length);
    });

    test('roles and reasons of idea palettes are translated', () {
      for (final String role in IdeaRoles.all) {
        final String reason = IdeaRoles.reasonFor(role);
        expect(l10n.roleLabel(role), role);
        expect(l10n.reasonLabel(reason), reason);
        for (final AppLocalizations t in l10nTranslated) {
          _expectTranslated(t, t.roleLabel(role), role, reason: role);
          _expectTranslated(t, t.reasonLabel(reason), reason, reason: reason);
        }
      }
      expect(l10nEs.roleLabel(IdeaRoles.shadowGray), 'Gris de sombra');
    });
  });

  group('AI failures', () {
    test('every typed reason has English text equal to the AI layer', () {
      for (final ai.PaletteFailureReason r in ai.PaletteFailureReason.values) {
        expect(l10n.aiFailureText(r), r.userMessage, reason: r.name);
        for (final AppLocalizations t in l10nTranslated) {
          expect(t.aiFailureText(r), isNot(r.userMessage), reason: r.name);
        }
      }
    });

    test('the fallback notes of the AI layer are translated', () {
      expect(
        l10nEs.aiNote('AI unavailable. Showing local suggestions.'),
        'IA no disponible. Se muestran sugerencias locales.',
      );
      expect(
        l10nEs.aiNote(
          'AI unavailable (${ai.PaletteFailureReason.rateLimited.userMessage}) '
          'Showing local suggestions.',
        ),
        'IA no disponible (El proveedor está limitando las peticiones. '
        'Inténtalo de nuevo en un momento.) Se muestran sugerencias locales.',
      );
      expect(l10nEs.aiNote('Something else'), 'Something else');
    });
  });

  test('match quality and card locations follow the locale', () {
    expect(l10n.matchQualityLabel(0.5), 'Nearly exact');
    expect(l10nEs.matchQualityLabel(0.5), 'Casi exacto');
    expect(l10n.matchQualityLabel(4), 'Very close');
    expect(l10n.matchQualityLabel(9), 'Close');
    expect(l10nEs.matchQualityLabel(15), 'Aproximado');
    expect(l10n.matchQualityLabel(20), 'Rough');
    expect(l10n.matchQualityLabel(20.1), 'Far off');
    expect(l10nEs.matchQualityLabel(65), 'Lejano');
    expect(l10n.cardLocationLabel('Card 4'), 'Swatch card 4');
    expect(l10nEs.cardLocationLabel('Card 4'), 'Carta de colores 4');
    expect(l10nEs.cardLocationLabel('Anything'), 'Anything');
    expect(l10nEs.commonDeltaE(2.44), 'ΔE 2,4');
    expect(l10n.commonDeltaE(2.44), 'ΔE 2.4');
  });

  test('the supported locales are the six languages of the app', () {
    expect(AppLocalizations.supportedLocales.toSet(), <Locale>{
      Locale('en'),
      Locale('es'),
      Locale('de'),
      Locale('fr'),
      Locale('pt'),
      Locale('it'),
    });
  });
}
