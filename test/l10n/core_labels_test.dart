import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/ai/palette_advisor.dart' as ai;
import 'package:ink_lab/core/collection_selection.dart';
import 'package:ink_lab/core/ideas_engine.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/core/palette_generator.dart';

import '../support/l10n.dart';

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
      for (final DrawingScenario s in DrawingScenario.values) {
        expect(l10n.scenarioLabel(s), s.label);
      }
      for (final PackSelectionMode m in PackSelectionMode.values) {
        expect(l10n.packModeLabel(m), m.label);
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

    test('Spanish translates every one', () {
      for (final PaletteMode m in PaletteMode.values) {
        expect(l10nEs.modeLabel(m), isNot(m.label), reason: m.name);
      }
      for (final DrawingScenario s in DrawingScenario.values) {
        expect(l10nEs.scenarioLabel(s), isNot(s.label), reason: s.name);
      }
      for (final PackSelectionMode m in PackSelectionMode.values) {
        expect(l10nEs.packModeLabel(m), isNot(m.label), reason: m.name);
      }
      for (final IdeaCategory c in IdeaCategory.values) {
        expect(l10nEs.ideaCategoryLabel(c), isNot(c.label), reason: c.name);
      }
      for (final QuickPaletteVariation v in QuickPaletteVariation.values) {
        expect(l10nEs.variationName(v), isNot(v.label), reason: v.name);
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
      for (final DrawingScenario scenario in DrawingScenario.values) {
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

    test('are kept as-is in English and all translated in Spanish', () {
      final Set<String> reasons = allReasons();
      expect(reasons.length, greaterThan(40));
      for (final String reason in reasons) {
        expect(l10n.reasonLabel(reason), reason);
        final String es = l10nEs.reasonLabel(reason);
        expect(es, isNot(reason), reason: 'untranslated: $reason');
        expect(es, isNot(contains('deg)')), reason: reason);
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
    final List<MarkerColor> candidates = collection.take(120).toList();

    test('English texts match the engine, Spanish ones are translated', () {
      expect(IdeasEngine.presets.length, 30);
      for (final IdeaPreset preset in IdeasEngine.presets) {
        final IdeaPlan plan = IdeasEngine.generatePlan(preset, candidates, 5);
        expect(l10n.ideaTitle(preset), preset.title);
        expect(l10n.ideaSummary(preset), preset.summary);
        expect(l10n.ideaOverviewText(preset.id), plan.overview);
        expect(l10n.ideaStepsText(preset.id), plan.steps, reason: preset.id);
        expect(
          l10n.ideaEmbellishmentsText(preset.id),
          plan.embellishments,
          reason: preset.id,
        );
        for (final PaletteSuggestion s in plan.palette) {
          expect(l10n.reasonLabel(s.reason), s.reason);
          // "Base" is the same word in both languages.
          if (s.reason != 'Base') {
            expect(
              l10nEs.reasonLabel(s.reason),
              isNot(s.reason),
              reason: '${preset.id}: ${s.reason}',
            );
          }
        }
        if (preset.id != 'pastel') {
          expect(l10nEs.ideaTitle(preset), isNot(preset.title));
        }
        expect(l10nEs.ideaSummary(preset), isNot(preset.summary));
        expect(l10nEs.ideaOverviewText(preset.id), isNot(plan.overview));
        expect(l10nEs.ideaStepsText(preset.id), isNot(plan.steps));
      }
    });
  });

  group('AI failures', () {
    test('every typed reason has English text equal to the AI layer', () {
      for (final ai.PaletteFailureReason r in ai.PaletteFailureReason.values) {
        expect(l10n.aiFailureText(r), r.userMessage, reason: r.name);
        expect(l10nEs.aiFailureText(r), isNot(r.userMessage), reason: r.name);
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
    expect(l10n.matchQualityLabel(0.5), 'Excellent');
    expect(l10nEs.matchQualityLabel(0.5), 'Excelente');
    expect(l10nEs.matchQualityLabel(9), 'Aproximado');
    expect(l10n.cardLocationLabel('Card 4'), 'Swatch card 4');
    expect(l10nEs.cardLocationLabel('Card 4'), 'Carta de colores 4');
    expect(l10nEs.cardLocationLabel('Anything'), 'Anything');
    expect(l10nEs.commonDeltaE(2.44), 'ΔE 2,4');
    expect(l10n.commonDeltaE(2.44), 'ΔE 2.4');
  });

  test('the supported locales are English and Spanish', () {
    expect(AppLocalizations.supportedLocales, const <Locale>[
      Locale('en'),
      Locale('es'),
    ]);
  });
}
