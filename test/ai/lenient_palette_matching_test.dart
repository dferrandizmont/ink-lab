import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/ai/ai.dart';
import 'package:ink_lab/core/collection_selection.dart';
import 'package:ink_lab/core/marker_repository.dart' show parseColors;
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/core/palette_advisor.dart'
    as core
    show PaletteAdvisorRequest, PaletteSuggestion;
import 'package:ink_lab/core/palette_generator.dart';

import 'ai_test_support.dart';
import 'fake_on_device_platform.dart';

/// The real DecoTime catalogue (313 markers), all owned, like the phone test.
final List<MarkerColor> _deco = parseColors(
  File('assets/data/decotime_colors.json').readAsStringSync(),
  brand: MarkerBrand.decoTime,
);

final Set<String> _owned = {for (final c in _deco) 'decotime:${c.newCode}'};

MarkerColor _byCode(String code) => _deco.firstWhere((c) => c.newCode == code);

core.PaletteAdvisorRequest _decoRequest({int size = 5, String base = '01'}) =>
    core.PaletteAdvisorRequest(
      availableColors: _deco,
      baseColor: _byCode(base),
      paletteSize: size,
      mode: PaletteMode.recommended,
      brand: MarkerBrand.decoTime,
      ownedMarkerCodes: _owned,
    );

PlatformOnDevicePaletteAdvisor _onDevice(String output) =>
    PlatformOnDevicePaletteAdvisor(
      platform: FakeOnDevicePlatform(output: output),
    );

String _json(List<Map<String, Object?>> palette) =>
    jsonEncode({'palette': palette});

List<String> _codes(PaletteAdvice advice) => [
  for (final s in (advice as PaletteAdviceSuccess).suggestions) s.color.newCode,
];

void main() {
  group('normalizeCodeForMatch', () {
    test('DecoTime numeric codes compare after stripping leading zeros', () {
      expect(normalizeCodeForMatch('1'), normalizeCodeForMatch('01'));
      expect(normalizeCodeForMatch('001'), normalizeCodeForMatch('01'));
      expect(normalizeCodeForMatch(' 7 '), '07');
      expect(normalizeCodeForMatch('121'), '121');
      expect(normalizeCodeForMatch('0.5'), '0.5');
    });
  });

  group('lenient matching on a DecoTime collection (on-device model)', () {
    final request = _decoRequest();

    test('code without the leading zero maps to the padded code', () async {
      final advice = await _onDevice(
        _json([
          {'code': '2', 'role': 'Shadow'},
          {'code': '3', 'role': 'Highlight'},
          {'code': '10', 'role': 'Accent'},
        ]),
      ).advise(request);

      expect(_codes(advice), ['02', '03', '10']);
    });

    test('brand prefixes and loose wrapping are stripped', () async {
      final advice = await _onDevice(
        _json([
          {'code': 'decotime:02'},
          {'code': 'DecoTime 3'},
          {'code': 'Ohuhu-10'},
          {'code': 'DECOTIME_WG 9'},
        ]),
      ).advise(request);

      expect(_codes(advice), ['02', '03', '10', 'WG9']);
    });

    test('names instead of codes map to the colour with that name', () async {
      final advice = await _onDevice(
        _json([
          {'code': 'Old Red', 'role': 'Shadow'},
          {'name': 'rose pink', 'role': 'Highlight'},
          {'code': 'Warm Grey 9', 'role': 'Neutral'},
        ]),
      ).advise(request);

      // "Warm Grey 9" must be WG9, not marker 09 read out of the text.
      expect(_codes(advice), ['02', '08', 'WG9']);
    });

    test('name inside longer text and a bare string list also match', () async {
      final advice = await _onDevice(
        jsonEncode({
          'palette': ['02 - Old Red', 'Rose Pink (08)', 'the Carmine one'],
        }),
      ).advise(request);

      expect(_codes(advice), ['02', '08', '11']);
    });

    test(
      'Ohuhu-style codes that do not exist are dropped, not invented',
      () async {
        final advice = await _onDevice(
          _json([
            {'code': 'B315', 'role': 'Shadow'},
            {'code': 'R101', 'role': 'Accent'},
            {'code': '04', 'role': 'Highlight'},
            {'code': '05', 'role': 'Midtone'},
          ]),
        ).advise(request);

        final success = advice as PaletteAdviceSuccess;
        expect(_codes(success), ['04', '05']);
        expect(
          success.suggestions.every((s) => _deco.contains(s.color)),
          isTrue,
        );
      },
    );

    test('an unknown code with the exact hex maps to that colour', () async {
      final advice = await _onDevice(
        _json([
          {'code': 'X1', 'hex': '#952456'},
          {'code': 'zz', 'hex': 'EC5A88'},
        ]),
      ).advise(request);

      expect(_codes(advice), ['02', '03']);
    });

    test(
      'hex in the code field and a hex close to a marker map by distance',
      () async {
        // #ec5a88 is 03; #ed5b89 is a hair away from it.
        final advice = await _onDevice(
          _json([
            {'code': '#ED5B89'},
            {'code': '07#F286B6'},
            {'code': 'Hot Dream', 'hex': '#EE325F'},
          ]),
        ).advise(request);

        expect(_codes(advice), ['03', '07', '04']);
      },
    );

    test(
      'a hex farther than deltaE 10 from every marker is rejected',
      () async {
        // Pure green is far from every DecoTime marker of the red family; use a
        // tiny collection so the nearest one is clearly out of range.
        final reds = [_byCode('01'), _byCode('02'), _byCode('03')];
        final byCode = {
          for (final c in reds) normalizeCodeForMatch(c.newCode): c,
        };
        final far = validatePaletteItems(
          [AiPaletteItem(code: 'Q9', role: '', reason: 'r', hex: '#00FF00')],
          byCode,
          '01',
          5,
        );
        expect(far, isEmpty);
      },
    );

    test(
      'extra text around the JSON and an unknown name are tolerated',
      () async {
        final advice = await _onDevice(
          'Sure! Here is your palette:\n```json\n'
          '{"palette":[{"code":"2","role":"shadow"},'
          '{"code":"Totally Made Up Name","role":"accent"},'
          '{"code":"3","role":"Highlight","reason":"Soft light."}]}\n```\n'
          'Hope that helps!',
        ).advise(request);

        expect(_codes(advice), ['02', '03']);
      },
    );

    test('the base and duplicates written differently are dropped', () async {
      final advice = await _onDevice(
        _json([
          {'code': '1'},
          {'code': 'Wine Red'},
          {'code': '2'},
          {'code': '02'},
          {'code': 'decotime:2'},
        ]),
      ).advise(request);

      expect(_codes(advice), ['02']);
    });

    test('numeric JSON codes are accepted', () async {
      final advice = await _onDevice(
        jsonEncode({
          'palette': [
            {'code': 2},
            {'code': 3},
          ],
        }),
      ).advise(request);

      expect(_codes(advice), ['02', '03']);
    });
  });

  group('lenient matching on an Ohuhu collection (OpenRouter)', () {
    test('codes with brand prefix, case and spaces still match', () {
      final byCode = {
        for (final c in collection) normalizeCodeForMatch(c.newCode): c,
      };
      final result = validatePaletteItems(
        [
          AiPaletteItem(
            code: 'B315',
            role: '',
            reason: 'r',
            rawCode: 'ohuhu:b315',
          ),
          AiPaletteItem(code: 'R101', role: '', reason: 'r', rawCode: 'R 101'),
          AiPaletteItem(
            code: '',
            role: '',
            reason: 'r',
            rawCode: 'nope',
            name: 'NAME G202',
          ),
        ],
        byCode,
        null,
        5,
      );
      expect(result.map((s) => s.color.newCode), ['B315', 'R101', 'G202']);
    });
  });

  group('partial results', () {
    test(
      'base + one valid colour is kept, the rest is completed locally',
      () async {
        final request = _decoRequest();
        final advisor = FallbackPaletteAdvisor(
          primary: _onDevice(
            _json([
              {'code': '2', 'role': 'Shadow'},
              {'code': 'ZZ999', 'role': 'Accent'},
            ]),
          ),
          local: const PaletteGenerator(),
        );

        final advice = await advisor.advise(request);

        final success = advice as PaletteAdviceSuccess;
        expect(success.modelUsed, onDeviceModelId);
        expect(success.aiCount, 1);
        expect(success.isPartial, isTrue);
        expect(success.suggestions, hasLength(5));
        expect(success.suggestions.first.color.newCode, '02');
        expect(success.suggestions.first.role, 'Shadow');
        final ids = success.suggestions.map((s) => s.color.colorId).toList();
        expect(ids.toSet(), hasLength(5), reason: 'no repeated colours');
        expect(ids, isNot(contains(request.baseColor!.colorId)));
        for (final suggestion in success.suggestions) {
          expect(_deco, contains(suggestion.color));
        }
        expect(success.tips.join(), isNot(contains('local suggestions')));
      },
    );

    test('three valid of five are kept first and the tag says so', () async {
      final advisor = FallbackPaletteAdvisor(
        primary: _onDevice(
          _json([
            {'code': '2'},
            {'code': '3'},
            {'code': '4'},
          ]),
        ),
        local: const PaletteGenerator(),
      );

      final success =
          await advisor.advise(_decoRequest()) as PaletteAdviceSuccess;

      expect(success.suggestions.take(3).map((s) => s.color.newCode), [
        '02',
        '03',
        '04',
      ]);
      expect(success.suggestions, hasLength(5));
      expect(success.aiCount, 3);
    });

    test('only the base valid (no companion) falls back entirely', () async {
      final advisor = FallbackPaletteAdvisor(
        primary: _onDevice(
          _json([
            {'code': '1'},
            {'code': 'B315'},
            {'code': 'Nothing like a colour'},
          ]),
        ),
        local: const PaletteGenerator(),
      );

      final success =
          await advisor.advise(_decoRequest()) as PaletteAdviceSuccess;

      expect(success.usedFallback, isTrue);
      expect(success.modelUsed, isEmpty);
      expect(success.suggestions, hasLength(5));
      expect(
        success.tips.single,
        contains(PaletteFailureReason.noValidSuggestions.userMessage),
      );
    });

    test(
      'nothing valid with a base gives the typed failure from the advisor',
      () async {
        final advice = await _onDevice(
          _json([
            {'code': 'B315'},
            {'code': 'Not A Colour'},
          ]),
        ).advise(_decoRequest());

        expect(advice, isA<PaletteAdviceFailure>());
        expect(
          (advice as PaletteAdviceFailure).reason,
          PaletteFailureReason.noValidSuggestions,
        );
      },
    );

    test('a full answer is passed through untouched', () async {
      final advisor = FallbackPaletteAdvisor(
        primary: _onDevice(
          _json([
            {'code': '2'},
            {'code': '3'},
            {'code': '4'},
            {'code': '5'},
            {'code': '6'},
          ]),
        ),
        local: const PaletteGenerator(),
      );

      final success =
          await advisor.advise(_decoRequest()) as PaletteAdviceSuccess;

      expect(_codes(success), ['02', '03', '04', '05', '06']);
      expect(success.isPartial, isFalse);
    });
  });

  group('OpenRouter shares the same leniency and partial rule', () {
    test('a code written "1" is accepted on a DecoTime collection', () {
      final candidates = paletteCandidateColors(
        colors: _deco,
        brand: MarkerBrand.decoTime,
        ownedMarkerCodes: _owned,
      );
      final prepared = preparePaletteWire(_decoRequest(), candidates, 48);
      final parsed = parsePaletteContent(
        _json([
          {'code': '2'},
          {'code': 'Rose Red'},
        ]),
      );
      final result = validatePaletteItems(
        parsed.items,
        prepared.byCode,
        prepared.baseCode,
        5,
      );
      expect(result.map((s) => s.color.newCode), ['02', '03']);
    });

    test('hasEnoughPaletteSuggestions counts the base', () {
      final one = [core.PaletteSuggestion(color: _deco.first, reason: 'x')];
      expect(hasEnoughPaletteSuggestions(one), isTrue);
      expect(hasEnoughPaletteSuggestions(const []), isFalse);
    });
  });

  group('parser keeps what a lenient match can use', () {
    test('items identified only by name or hex survive parsing', () {
      final parsed = parsePaletteContent(
        '{"palette":[{"name":"Old Red"},{"hex":"#EC5A88"},'
        '{"color":"#F286B6"},{"role":"x"}]}',
      );
      expect(parsed.items, hasLength(3));
      expect(parsed.items[0].name, 'Old Red');
      expect(parsed.items[1].hex, '#EC5A88');
      expect(parsed.items[2].hex, '#F286B6');
    });
  });

  group('on-device prompt', () {
    late AiPaletteRequest wire;
    late PreparedPaletteRequest prepared;

    setUp(() {
      final candidates = paletteCandidateColors(
        colors: _deco,
        brand: MarkerBrand.decoTime,
        ownedMarkerCodes: _owned,
      );
      prepared = preparePaletteWire(
        _decoRequest(),
        candidates,
        onDeviceMaxCandidates,
        capper: capOnDeviceCandidates,
      );
      wire = prepared.wire;
    });

    test('lists at most 40 candidates as CODE | name | #hex', () {
      expect(wire.candidates.length, lessThanOrEqualTo(40));
      final prompt = buildOnDevicePrompt(wire);
      final lines = prompt.split('\n');
      final start = lines.indexWhere((l) => l.startsWith('COLORS'));
      final colourLines = lines
          .skip(start + 1)
          .takeWhile((l) => !l.startsWith('FORMAT'))
          .toList();
      expect(colourLines, hasLength(wire.candidates.length));
      for (final line in colourLines) {
        expect(line, matches(RegExp(r'^\S+ \| .+ \| #[0-9A-F]{6}$')));
      }
      expect(prompt, contains('BASE: 01 | Wine Red | #702C45'));
      expect(prompt, isNot(contains('01 | Wine Red | #702C45\n02')));
    });

    test('is explicit and short', () {
      final prompt = buildOnDevicePrompt(wire);
      expect(prompt, contains('Use ONLY codes from the COLORS list'));
      expect(prompt, contains('exactly as written'));
      expect(prompt, contains('strict JSON'));
      expect(prompt, contains('"code"'));
      expect(prompt, contains('"role"'));
      expect(prompt, contains('at most 12 words'));
      expect(prompt, contains('exactly 5 items'));
      // A small context window: well under ~1500 tokens (about 6000 chars).
      expect(prompt.length, lessThan(3500));
    });

    test('the one-shot example uses two real codes from the list', () {
      final prompt = buildOnDevicePrompt(wire);
      final example = prompt
          .split('\n')
          .firstWhere((l) => l.startsWith('EXAMPLE:'));
      final decoded = jsonDecode(
        example.substring('EXAMPLE:'.length).trim(),
      ) as Map<String, dynamic>;
      final items = (decoded['palette'] as List).cast<Map<String, dynamic>>();
      expect(items, hasLength(2));
      final listed = {for (final c in wire.candidates) c.newCode};
      for (final item in items) {
        expect(listed, contains(item['code']));
        expect(item.keys, containsAll(['code', 'role']));
      }
      expect(items[0]['code'], isNot(items[1]['code']));
    });

    test('candidates are not only neighbours of the base', () {
      final base = _byCode('01');
      final all = _deco.where((c) => c.newCode != '01').toList();
      final capped = capOnDeviceCandidates(all, base, 40);
      expect(capped, hasLength(40));
      expect({for (final c in capped) c.colorId}, hasLength(40));

      // The 15 nearest are in, and the rest cover several hue families.
      final hues = {for (final c in capped.skip(15)) (hexToHueBucket(c.hex))};
      expect(hues.length, greaterThanOrEqualTo(8));
      final lightness = [for (final c in capped.skip(15)) hexToValue(c.hex)];
      lightness.sort();
      expect(lightness.last - lightness.first, greaterThan(0.4));
    });

    test('a small collection is passed through whole', () {
      final small = _deco.take(10).toList();
      expect(capOnDeviceCandidates(small, small.first, 40), small);
    });

    test('the on-device advisor sends exactly this prompt', () async {
      final platform = FakeOnDevicePlatform(
        output: _json([
          {'code': '2'},
          {'code': '3'},
        ]),
      );
      await PlatformOnDevicePaletteAdvisor(platform: platform)
          .advise(_decoRequest());
      final prompt = platform.prompts.single;
      expect(prompt, startsWith('You pick marker colours'));
      expect(prompt, contains('COLORS (CODE | name | #hex):'));
      expect(prompt.contains('AVAILABLE_COLORS='), isFalse);
    });
  });

  group('DecoTime data', () {
    test(
      'no marker name contains another marker code followed by a period',
      () {
        final raw = jsonDecode(
          File('assets/data/decotime_colors.json').readAsStringSync(),
        ) as List;
        final codes = {for (final item in raw) (item as Map)['code'] as String};
        final merged = RegExp(
          r'\s(' +
              (codes.map(RegExp.escape).toList()
                    ..sort((a, b) => b.length.compareTo(a.length)))
                  .join('|') +
              r')\.\s',
        );
        for (final item in raw.cast<Map<String, dynamic>>()) {
          final name = item['name'] as String;
          expect(
            merged.hasMatch(name),
            isFalse,
            reason: 'merged name for ${item['code']}: $name',
          );
        }
      },
    );

    test('the Warm Grey / Cool Grey names are clean', () {
      expect(_byCode('WG9').newName, 'Warm Grey 9');
      expect(_byCode('WG0.5').newName, 'Warm Grey 0.5');
      expect(_byCode('CG2').newName, 'Cool Grey 2');
      expect(_byCode('CG3').newName, 'Cool Grey 3');
    });
  });
}

int hexToHueBucket(String hex) {
  final int value = int.parse(hex.replaceFirst('#', ''), radix: 16);
  final double r = ((value >> 16) & 255) / 255;
  final double g = ((value >> 8) & 255) / 255;
  final double b = (value & 255) / 255;
  final double max = [r, g, b].reduce((a, c) => a > c ? a : c);
  final double min = [r, g, b].reduce((a, c) => a < c ? a : c);
  if (max - min < 0.12) return -1;
  double h;
  if (max == r) {
    h = ((g - b) / (max - min)) % 6;
  } else if (max == g) {
    h = (b - r) / (max - min) + 2;
  } else {
    h = (r - g) / (max - min) + 4;
  }
  return ((h * 60) / 45).floor() % 8;
}

double hexToValue(String hex) {
  final int value = int.parse(hex.replaceFirst('#', ''), radix: 16);
  return [
        (value >> 16) & 255,
        (value >> 8) & 255,
        value & 255,
      ].reduce((a, c) => a > c ? a : c) /
      255;
}
