import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:ink_lab/ai/ai.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/core/palette_advisor.dart'
    show PaletteAdvisorRequest, PaletteSuggestion;
import 'package:ink_lab/data/ai_settings.dart';

import 'ai_test_support.dart';

Future<PaletteAdviceSuccess> adviseWith(
  List<Map<String, String>> palette, {
  MarkerColor? base,
}) async {
  final advisor = OpenRouterPaletteAdvisor(
    client: OpenRouterClient(
      client: MockClient((_) async => completionResponse(paletteJson(palette))),
    ),
    settings: () => AiSettings(enabled: true, textModel: 'model-a'),
    apiKey: () => 'sk-or-test-key-1234567890',
  );
  final result = await advisor.advise(
    PaletteAdvisorRequest(
      availableColors: collection,
      baseColor: base,
      paletteSize: 5,
      brand: MarkerBrand.ohuhuOahu,
    ),
  );
  return result as PaletteAdviceSuccess;
}

void main() {
  group('normalizePaletteRole', () {
    test('maps spellings onto the role set', () {
      expect(normalizePaletteRole('shadow'), 'Shadow');
      expect(normalizePaletteRole('  HIGHLIGHTS '), 'Highlight');
      expect(normalizePaletteRole('Mid-tone'), 'Midtone');
      expect(normalizePaletteRole('midtone'), 'Midtone');
      expect(normalizePaletteRole('Complementary'), 'Complement');
      expect(normalizePaletteRole('Accent colour'), 'Accent');
      expect(normalizePaletteRole('Base'), 'Base');
      expect(normalizePaletteRole('companion'), 'Companion');
      expect(normalizePaletteRole('Neutral'), 'Neutral');
    });

    test('unknown or empty roles are null', () {
      expect(normalizePaletteRole(''), isNull);
      expect(normalizePaletteRole('Background'), isNull);
      expect(normalizePaletteRole('Baseline'), isNull);
    });
  });

  group('splitRoleAndReason', () {
    test('uses the model role and strips the same prefix from the reason', () {
      final split = splitRoleAndReason('Highlight', 'Highlight: A darker tone');
      expect(split.role, 'Highlight');
      expect(split.reason, 'A darker tone');
    });

    test('the model role wins over a contradicting prefix', () {
      final split = splitRoleAndReason('Companion', 'Base: Matches the base');
      expect(split.role, 'Companion');
      expect(split.reason, 'Matches the base');
    });

    test('a missing role comes from a recognised prefix', () {
      final split = splitRoleAndReason('', 'Shadow: deep and rich');
      expect(split.role, 'Shadow');
      expect(split.reason, 'deep and rich');
    });

    test('colons that are not role prefixes are kept', () {
      final split = splitRoleAndReason('Accent', 'Tip: use sparingly');
      expect(split.role, 'Accent');
      expect(split.reason, 'Tip: use sparingly');
    });

    test('empty reasons become a placeholder', () {
      expect(splitRoleAndReason('Shadow', 'Shadow:').reason, 'AI suggestion');
    });
  });

  group('advisor rows', () {
    test('role and reason come from the same item', () async {
      final success = await adviseWith([
        {
          'code': 'R101',
          'role': 'Companion',
          'reason': "Base: Matches the base colour'",
        },
        {
          'code': 'G202',
          'role': 'highlight',
          'reason': 'Highlight: A darker, more saturated tone',
        },
        {'code': 'B303', 'role': 'Shadow', 'reason': 'Shadow: depth'},
      ]);

      final rows = {
        for (final s in success.suggestions)
          s.color.newCode: (s.role, s.reason),
      };
      expect(rows['R101'], ('Companion', 'Matches the base colour'));
      expect(rows['G202'], ('Highlight', 'A darker, more saturated tone'));
      expect(rows['B303'], ('Shadow', 'depth'));
    });

    test('keeps Base as a role the model gave', () async {
      final success = await adviseWith([
        {'code': 'R101', 'role': 'Base', 'reason': 'Base: anchors the scene'},
      ]);
      expect(success.suggestions.single.role, 'Base');
      expect(success.suggestions.single.reason, 'anchors the scene');
    });

    test(
      'an unknown role is null so the UI derives it from the reason',
      () async {
        final success = await adviseWith([
          {'code': 'R101', 'role': 'Background', 'reason': 'a darker shade'},
        ]);
        expect(success.suggestions.single.role, isNull);
        expect(success.suggestions.single.reason, 'a darker shade');
      },
    );

    test('a missing role is not invented', () async {
      final success = await adviseWith([
        {'code': 'R101', 'reason': 'a darker shade'},
      ]);
      expect(success.suggestions.single.role, isNull);
    });
  });

  group('duplicate role diversification', () {
    final base = marker('BASE', '3366cc');
    final colors = <String, MarkerColor>{
      'near': marker('NEAR', '3a6fd0'),
      'navy': marker('NAVY', '112244'),
      'light': marker('LITE', '99bbee'),
      'orange': marker('ORNG', 'ff8800'),
      'grey': marker('GREY', '888888'),
    };
    final byCode = {
      for (final c in colors.values) normalizeCodeForMatch(c.newCode): c,
    };

    AiPaletteItem item(String key, String role, [String reason = 'because']) =>
        AiPaletteItem(code: colors[key]!.newCode, role: role, reason: reason);

    List<PaletteSuggestion> validate(
      List<AiPaletteItem> items, {
      MarkerColor? baseColor,
    }) => validatePaletteItems(
      items,
      byCode,
      normalizeCodeForMatch(base.newCode),
      5,
      baseColor: baseColor,
    );

    test('five Midtones become distinct roles that fit each colour', () {
      final result = validate([
        item('near', 'Midtone', 'close hue'),
        item('navy', 'Midtone', 'deep'),
        item('light', 'midtone', 'airy'),
        item('orange', 'Mid-tone', 'pop'),
        item('grey', 'Midtone', 'calm'),
      ], baseColor: base);

      expect(result.map((s) => s.role).toList(), [
        'Midtone',
        'Shadow',
        'Highlight',
        'Accent',
        'Neutral',
      ]);
      // The model's reason text is kept.
      expect(result.map((s) => s.reason).toList(), [
        'close hue',
        'deep',
        'airy',
        'pop',
        'calm',
      ]);
      expect(result.map((s) => s.color.newCode).toList(), [
        'NEAR',
        'NAVY',
        'LITE',
        'ORNG',
        'GREY',
      ]);
    });

    test('Companion fits a close hue at similar lightness', () {
      final result = validate([
        item('navy', 'Shadow'),
        item('near', 'Shadow'),
      ], baseColor: base);
      expect(result.map((s) => s.role).toList(), ['Shadow', 'Companion']);
    });

    test('roles the model already made distinct are untouched', () {
      final input = [
        item('navy', 'Shadow'),
        item('light', 'Highlight'),
        item('orange', 'Accent'),
      ];
      final result = validate(input, baseColor: base);
      expect(result.map((s) => s.role).toList(), [
        'Shadow',
        'Highlight',
        'Accent',
      ]);
    });

    test('a role the model gave later is never taken by a duplicate', () {
      final result = validate([
        item('light', 'Midtone'),
        item('navy', 'Midtone'),
        item('grey', 'Shadow'),
      ], baseColor: base);
      // The navy duplicate wants Shadow, but grey already holds it.
      expect(result[1].role, isNot('Shadow'));
      expect(result[2].role, 'Shadow');
      expect(result.map((s) => s.role).toSet(), hasLength(3));
    });

    test('Base repeats and missing roles are left alone', () {
      final result = validate([
        item('navy', 'Base'),
        item('light', 'Base'),
        item('orange', ''),
        item('grey', ''),
      ], baseColor: base);
      expect(result.map((s) => s.role).toList(), ['Base', 'Base', null, null]);
    });

    test('keeps the duplicate when no unused role fits', () {
      // Two greys named Neutral: the second grey has no other fitting role
      // once Neutral and Shadow/Highlight are not applicable.
      final greys = {'a': marker('GA', '808080'), 'b': marker('GB', '828282')};
      final lookup = {
        for (final c in greys.values) normalizeCodeForMatch(c.newCode): c,
      };
      final result = validatePaletteItems(
        [
          AiPaletteItem(code: 'GA', role: 'Neutral', reason: 'r'),
          AiPaletteItem(code: 'GB', role: 'Neutral', reason: 'r'),
        ],
        lookup,
        null,
        5,
      );
      expect(result.map((s) => s.role).toList(), ['Neutral', 'Neutral']);
    });

    test('works without a base colour', () {
      final result = validate([
        item('near', 'Midtone'),
        item('navy', 'Midtone'),
        item('light', 'Midtone'),
      ]);
      expect(result.map((s) => s.role).toSet(), hasLength(3));
    });

    test('the OpenRouter advisor returns distinct roles end to end', () async {
      final advice = await adviseWith([
        {'code': 'R101', 'role': 'Midtone', 'reason': 'warm'},
        {'code': 'B315', 'role': 'Midtone', 'reason': 'deep'},
        {'code': 'G202', 'role': 'Midtone', 'reason': 'fresh'},
      ], base: collection[5]);
      final roles = advice.suggestions.map((s) => s.role).toList();
      expect(roles.toSet(), hasLength(roles.length));
      expect(advice.suggestions.map((s) => s.reason), [
        'warm',
        'deep',
        'fresh',
      ]);
    });
  });
}
