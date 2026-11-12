import 'dart:io';
import 'dart:math' as math;

import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/blending_chain.dart';
import 'package:ink_lab/core/collection_selection.dart';
import 'package:ink_lab/core/color_utils.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/core/palette_advisor.dart';
import 'package:ink_lab/core/palette_generator.dart';

/// A marker whose OKLCh colour is exactly [l], [c], [h] (degrees).
MarkerColor _marker(String code, double l, double c, double h) {
  final double rad = h * math.pi / 180;
  final RgbColor rgb = oklabToRgb(
    OklabColor(l, c * math.cos(rad), c * math.sin(rad)),
  );
  return MarkerColor(
    newCode: code,
    newName: 'Name $code',
    oldCode: code,
    oldName: 'Name $code',
    hex: rgbToHex(rgb).toLowerCase(),
    sets: const <String>['classic_160'],
  );
}

double _lightness(MarkerColor c) => hexToOklab(c.hex).l;

double _chroma(MarkerColor c) {
  final OklabColor lab = hexToOklab(c.hex);
  return math.sqrt(lab.a * lab.a + lab.b * lab.b);
}

double _hue(MarkerColor c) {
  final OklabColor lab = hexToOklab(c.hex);
  return (math.atan2(lab.b, lab.a) * 180 / math.pi + 360) % 360;
}

List<String> _codes(BlendingChain chain) => <String>[
  for (final MarkerColor c in chain.colors) c.newCode,
];

/// A blue family from light to dark, one step of 0.09 apart.
List<MarkerColor> _blues() => <MarkerColor>[
  for (int i = 0; i < 8; i++) _marker('B$i', 0.92 - i * 0.09, 0.10, 250),
];

void main() {
  group('buildBlendingChains', () {
    test(
      'a chain goes light to dark, contains the base and has even steps',
      () {
        final List<MarkerColor> blues = _blues();
        final MarkerColor base = blues[3];
        final BlendingChainResult result = buildBlendingChains(
          base,
          blues,
          length: 4,
        );
        final BlendingChain chain = result.best!;
        expect(chain.colors, hasLength(4));
        expect(chain.colors.contains(base), isTrue);
        expect(chain.base.newCode, base.newCode);
        final List<double> lightness = chain.colors.map(_lightness).toList();
        for (int i = 0; i + 1 < lightness.length; i++) {
          expect(lightness[i], greaterThan(lightness[i + 1]));
        }
        for (final double step in chain.steps) {
          expect(
            step,
            inInclusiveRange(BlendingRules.minStep, BlendingRules.maxStep),
          );
        }
        // Evenness: the longest step is within a hair of the shortest.
        expect(
          chain.steps.reduce(math.max) - chain.steps.reduce(math.min),
          lessThan(0.03),
        );
        expect(result.isShort, isFalse);
        expect(result.gap, BlendingGap.none);
      },
    );

    test('puts the base in the middle when the family allows it', () {
      final List<MarkerColor> blues = _blues();
      final BlendingChain three = buildBlendingChains(
        blues[4],
        blues,
        length: 3,
      ).best!;
      expect(three.baseIndex, 1);
      final BlendingChain five = buildBlendingChains(
        blues[4],
        blues,
        length: 5,
      ).best!;
      expect(five.baseIndex, 2);
      // Four markers cannot centre the base: it sits one off the middle.
      final BlendingChain four = buildBlendingChains(
        blues[4],
        blues,
        length: 4,
      ).best!;
      expect(four.baseIndex, anyOf(1, 2));
    });

    test(
      'does not force a centred base: at the dark end it ends the chain',
      () {
        final List<MarkerColor> blues = _blues();
        final BlendingChainResult result = buildBlendingChains(
          blues.last,
          blues,
          length: 4,
        );
        final BlendingChain chain = result.best!;
        expect(chain.baseIsDarkest, isTrue);
        expect(chain.baseIsLightest, isFalse);
        expect(result.darkerAvailable, isFalse);
        expect(result.lighterAvailable, isTrue);
        expect(result.isShort, isFalse);
      },
    );

    test('prefers the evenest steps over the nearest markers', () {
      final MarkerColor base = _marker('base', 0.60, 0.10, 250);
      final List<MarkerColor> pool = <MarkerColor>[
        base,
        _marker('L1', 0.70, 0.10, 250), // 0.10 up
        _marker('L2', 0.73, 0.10, 250), // too close to L1 and L3
        _marker('L3', 0.79, 0.10, 250), // 0.09 above L1
        _marker('D1', 0.51, 0.10, 250), // 0.09 down
        _marker('D2', 0.43, 0.10, 250), // 0.08 further
        _marker('D3', 0.46, 0.10, 250), // 0.05 above D2: uneven
      ];
      final BlendingChain chain = buildBlendingChains(
        base,
        pool,
        length: 5,
      ).best!;
      expect(_codes(chain), <String>['L3', 'L1', 'base', 'D1', 'D2']);
    });

    test('leaves out markers whose step is too small or too big', () {
      final MarkerColor base = _marker('base', 0.60, 0.10, 250);
      final List<MarkerColor> pool = <MarkerColor>[
        base,
        _marker('tooNear', 0.62, 0.10, 250),
        _marker('tooFar', 0.95, 0.10, 250),
        _marker('darkOk', 0.50, 0.10, 250),
        _marker('lightOk', 0.70, 0.10, 250),
      ];
      final BlendingChain chain = buildBlendingChains(
        base,
        pool,
        length: 5,
      ).best!;
      expect(chain.colors.map((c) => c.newCode), isNot(contains('tooNear')));
      expect(chain.colors.map((c) => c.newCode), isNot(contains('tooFar')));
      expect(_codes(chain), <String>['lightOk', 'base', 'darkOk']);
    });

    test('keeps to the hue family of a vivid base', () {
      final MarkerColor base = _marker('base', 0.60, 0.15, 250);
      final List<MarkerColor> pool = <MarkerColor>[
        base,
        _marker('blueLight', 0.70, 0.15, 258),
        _marker('blueDark', 0.50, 0.15, 244),
        _marker('greenLight', 0.69, 0.15, 150),
        _marker('redDark', 0.51, 0.15, 25),
      ];
      final BlendingChain chain = buildBlendingChains(base, pool).best!;
      expect(_codes(chain), <String>['blueLight', 'base', 'blueDark']);
    });

    test('the hue window widens for pale, low-chroma markers', () {
      // 36 degrees either side: too far for a vivid base, fine for a pale one.
      final MarkerColor vividBase = _marker('base', 0.60, 0.15, 250);
      final MarkerColor paleBase = _marker('base', 0.60, 0.05, 250);
      List<MarkerColor> pool(double c, MarkerColor base) => <MarkerColor>[
        base,
        _marker('light', 0.70, c, 250 + 36),
        _marker('dark', 0.50, c, 250 - 36),
      ];
      expect(
        buildBlendingChains(vividBase, pool(0.15, vividBase)).best,
        isNull,
      );
      expect(
        buildBlendingChains(paleBase, pool(0.05, paleBase)).best,
        isNotNull,
      );
    });

    test('greys chain with greys, and a colour never takes a grey', () {
      final MarkerColor grey = _marker('grey', 0.60, 0.004, 0);
      final List<MarkerColor> pool = <MarkerColor>[
        grey,
        _marker('lightGrey', 0.70, 0.004, 20),
        _marker('darkGrey', 0.50, 0.01, 0),
        _marker('pinkTint', 0.69, 0.08, 20),
        _marker('brown', 0.49, 0.08, 40),
      ];
      final BlendingChain chain = buildBlendingChains(grey, pool).best!;
      expect(_codes(chain), <String>['lightGrey', 'grey', 'darkGrey']);

      // A coloured base does not borrow the greys of the same lightness.
      final MarkerColor tan = _marker('tan', 0.60, 0.08, 40);
      final BlendingChainResult result = buildBlendingChains(tan, pool);
      expect(result.best!.colors.map((c) => c.newCode), <String>[
        'pinkTint',
        'tan',
        'brown',
      ]);
    });

    test('says what is missing instead of forcing a bad chain', () {
      final MarkerColor base = _marker('base', 0.60, 0.10, 250);
      BlendingChainResult of(List<MarkerColor> others) =>
          buildBlendingChains(base, <MarkerColor>[base, ...others]);

      final BlendingChainResult alone = of(const <MarkerColor>[]);
      expect(alone.best, isNull);
      expect(alone.chains, isEmpty);
      expect(alone.gap, BlendingGap.both);

      // A lighter marker exists but nothing darker: a chain of two is no chain.
      final BlendingChainResult onlyLighter = of(<MarkerColor>[
        _marker('light', 0.70, 0.10, 250),
      ]);
      expect(onlyLighter.best, isNull);
      expect(onlyLighter.gap, BlendingGap.darker);
      expect(onlyLighter.lighterAvailable, isTrue);
      expect(onlyLighter.darkerAvailable, isFalse);

      final BlendingChainResult onlyDarker = of(<MarkerColor>[
        _marker('dark', 0.50, 0.10, 250),
      ]);
      expect(onlyDarker.gap, BlendingGap.lighter);

      // A marker a whole jump away does not count.
      final BlendingChainResult tooFar = of(<MarkerColor>[
        _marker('far', 0.90, 0.10, 250),
        _marker('farDark', 0.20, 0.10, 250),
      ]);
      expect(tooFar.best, isNull);
      expect(tooFar.gap, BlendingGap.both);
    });

    test('a shorter chain is reported as short, never padded', () {
      final List<MarkerColor> blues = _blues().take(4).toList();
      final BlendingChainResult result = buildBlendingChains(
        blues[1],
        blues,
        length: 5,
      );
      expect(result.requested, 5);
      expect(result.best!.colors, hasLength(4));
      expect(result.isShort, isTrue);

      final BlendingChainResult three = buildBlendingChains(
        blues[1],
        blues.take(3).toList(),
        length: 5,
      );
      expect(three.best!.colors, hasLength(3));
      expect(three.isShort, isTrue);
    });

    test('the length is clamped to three to five', () {
      final List<MarkerColor> blues = _blues();
      expect(buildBlendingChains(blues[3], blues, length: 1).requested, 3);
      expect(buildBlendingChains(blues[3], blues, length: 9).requested, 5);
      expect(
        buildBlendingChains(blues[3], blues, length: 9).best!.colors,
        hasLength(5),
      );
    });

    test('never uses the colourless blender', () {
      final List<MarkerColor> pool = <MarkerColor>[
        ..._blues(),
        MarkerColor(
          newCode: '0',
          newName: 'Colorless Blender',
          oldCode: '0',
          oldName: 'Colorless Blender',
          hex: 'ffffff',
          sets: const <String>['classic_160'],
        ),
      ];
      final MarkerColor grey = _marker('g', 0.60, 0.0, 0);
      pool.add(grey);
      final BlendingChainResult result = buildBlendingChains(grey, pool);
      expect(
        result.chains.expand((c) => c.colors).map((c) => c.newCode),
        isNot(contains('0')),
      );
      expect(isColourlessBlender(pool[8]), isTrue);
      expect(isColourlessBlender(pool.first), isFalse);
    });

    test('offers distinct alternatives, best first', () {
      final MarkerColor base = _marker('base', 0.60, 0.10, 250);
      final List<MarkerColor> pool = <MarkerColor>[
        base,
        for (final double l in <double>[0.69, 0.71, 0.78, 0.80])
          _marker('L${(l * 100).round()}', l, 0.10, 250),
        for (final double l in <double>[0.51, 0.49, 0.42, 0.40])
          _marker('D${(l * 100).round()}', l, 0.10, 250),
      ];
      final BlendingChainResult result = buildBlendingChains(
        base,
        pool,
        length: 4,
      );
      expect(result.chains.length, greaterThan(1));
      expect(
        result.chains.length,
        lessThanOrEqualTo(1 + BlendingRules.maxAlternatives),
      );
      final List<double> costs = result.chains.map((c) => c.cost).toList();
      expect([...costs]..sort(), costs);
      final Set<String> signatures = <String>{
        for (final BlendingChain c in result.chains) _codes(c).join(' '),
      };
      expect(signatures, hasLength(result.chains.length));
      // Alternatives differ in at least two markers from the best chain.
      for (final BlendingChain alt in result.chains.skip(1)) {
        final Set<String> best = _codes(result.best!).toSet();
        expect(
          _codes(alt).where((c) => !best.contains(c)).length,
          greaterThanOrEqualTo(2),
        );
      }
    });

    test('is deterministic', () {
      final List<MarkerColor> blues = _blues();
      final List<List<String>> a = buildBlendingChains(
        blues[2],
        blues,
      ).chains.map(_codes).toList();
      final List<List<String>> b = buildBlendingChains(
        blues[2],
        blues.reversed.toList(),
      ).chains.map(_codes).toList();
      expect(a, b);
    });

    test('a chain rebuilt from its colours keeps the base and the steps', () {
      final List<MarkerColor> blues = _blues();
      final BlendingChain chain = BlendingChain(
        colors: <MarkerColor>[blues[1], blues[2], blues[3]],
        base: blues[2],
      );
      expect(chain.baseIndex, 1);
      expect(chain.companions.map((c) => c.newCode), <String>['B1', 'B3']);
      expect(chain.steps, hasLength(2));
      expect(chain.steps.first, closeTo(0.09, 0.01));
      expect(blendingChainRoles(chain), <String>[
        BlendingRoles.lightest,
        BlendingRoles.base,
        BlendingRoles.darkest,
      ]);
    });

    test('roles name the steps from light to dark', () {
      final List<MarkerColor> blues = _blues();
      final BlendingChain chain = BlendingChain(
        colors: blues.take(5).toList(),
        base: blues[2],
      );
      expect(blendingChainRoles(chain), <String>[
        BlendingRoles.lightest,
        BlendingRoles.lighter,
        BlendingRoles.base,
        BlendingRoles.darker,
        BlendingRoles.darkest,
      ]);
    });
  });

  group('with the real catalogues', () {
    final List<MarkerColor> ohuhu = parseColors(
      File(MarkerBrand.ohuhuOahu.assetPath).readAsStringSync(),
      brand: MarkerBrand.ohuhuOahu,
    );
    final List<MarkerColor> deco = parseColors(
      File(MarkerBrand.decoTime.assetPath).readAsStringSync(),
      brand: MarkerBrand.decoTime,
    );
    List<MarkerColor> collection(String setId) => paletteCandidateColors(
      colors: ohuhu,
      brand: MarkerBrand.ohuhuOahu,
      activeSetIds: <String>{setId},
    );
    final List<MarkerColor> classic80 = collection('classic_80');
    final List<MarkerColor> classic160 = collection('classic_160');
    final List<MarkerColor> decoRange = brandRangeColors(
      colors: deco,
      brand: MarkerBrand.decoTime,
    );

    /// The rules every chain follows, whatever the data.
    void expectValid(
      BlendingChain chain,
      MarkerColor base,
      List<MarkerColor> pool,
    ) {
      final Set<String> ids = pool.map((c) => c.colorId).toSet();
      expect(chain.colors.length, inInclusiveRange(3, 5));
      expect(chain.colors.contains(base), isTrue, reason: base.newCode);
      expect(chain.colors.every((c) => ids.contains(c.colorId)), isTrue);
      expect(
        chain.colors.map((c) => c.colorId).toSet(),
        hasLength(chain.colors.length),
      );
      expect(chain.colors.any(isColourlessBlender), isFalse);
      for (final double step in chain.steps) {
        expect(
          step,
          inInclusiveRange(
            BlendingRules.minStep - 1e-9,
            BlendingRules.maxStep + 1e-9,
          ),
          reason: '${base.newCode} ${_codes(chain)}',
        );
      }
      expect(
        chain.steps.reduce(math.max),
        lessThanOrEqualTo(
          chain.steps.reduce(math.min) * BlendingRules.maxStepRatio,
        ),
        reason: '${base.newCode} ${_codes(chain)}',
      );
      // The family: coloured markers stay within the widest hue window of
      // two steps; neutrals only meet neutrals.
      for (final MarkerColor c in chain.colors) {
        if (_chroma(base) < BlendingRules.neutralChroma) {
          expect(_chroma(c), lessThan(BlendingRules.neutralChroma));
        } else if (_chroma(c) >= BlendingRules.hueNoiseChroma) {
          expect(
            hueDistance(_hue(base), _hue(c)),
            lessThanOrEqualTo(2 * BlendingRules.wideHue),
            reason: '${base.newCode} ${_codes(chain)}',
          );
        }
      }
    }

    for (final (String name, List<MarkerColor> pool)
        in <(String, List<MarkerColor>)>[
          ('Ohuhu classic 80', classic80),
          ('Ohuhu classic 160', classic160),
          ('DecoTime', decoRange),
          (
            'Copic',
            brandRangeColors(
              colors: parseColors(
                File(MarkerBrand.copic.assetPath).readAsStringSync(),
                brand: MarkerBrand.copic,
              ),
              brand: MarkerBrand.copic,
            ),
          ),
          (
            'Finecolour',
            brandRangeColors(
              colors: parseColors(
                File(MarkerBrand.finecolour.assetPath).readAsStringSync(),
                brand: MarkerBrand.finecolour,
              ),
              brand: MarkerBrand.finecolour,
            ),
          ),
        ]) {
      test('$name: every chain follows the rules, at every length', () {
        var withChain = 0;
        for (final MarkerColor base in pool) {
          if (isColourlessBlender(base)) continue;
          for (final int length in <int>[3, 4, 5]) {
            final BlendingChainResult result = buildBlendingChains(
              base,
              pool,
              length: length,
            );
            if (result.best == null) {
              expect(result.gap, isNot(BlendingGap.none), reason: base.newCode);
              continue;
            }
            if (length == 3) withChain++;
            for (final BlendingChain chain in result.chains) {
              expectValid(chain, base, pool);
              expect(chain.colors.length, lessThanOrEqualTo(length));
            }
            expect(
              result.chains.map((c) => c.colors.length).toSet(),
              hasLength(1),
              reason: 'one length per result',
            );
            expect(
              result.isShort,
              result.best!.colors.length < length,
              reason: base.newCode,
            );
          }
        }
        // Honesty goes both ways: most markers of a real range do chain.
        expect(withChain / pool.length, greaterThan(0.9), reason: name);
      });
    }

    test(
      'example: Ohuhu classic 160 chains read as a light-to-dark family',
      () {
        List<String> chainOf(String code, {int length = 4}) {
          final MarkerColor base = classic160.firstWhere(
            (c) => c.newCode == code,
          );
          return _codes(
            buildBlendingChains(base, classic160, length: length).best!,
          );
        }

        // Pink, tan and warm grey families: pale at one end, deep at the other.
        expect(chainOf('R38'), <String>['RV17', 'R38', 'RV111', 'R412']);
        expect(chainOf('Y611'), <String>['YR04', 'Y66', 'Y611', 'YR515']);
        expect(chainOf('WG27'), <String>['GG10', 'GG11', 'WG27', 'WG28']);
      },
    );

    test('example: DecoTime chains', () {
      List<String> chainOf(String code) {
        final MarkerColor base = decoRange.firstWhere((c) => c.newCode == code);
        return _codes(buildBlendingChains(base, decoRange).best!);
      }

      expect(chainOf('15'), <String>['208', '15', '244', '245']);
      expect(chainOf('50'), <String>['59', '60', '50', '52']);
    });

    test('a small collection reports short chains and what it lacks', () {
      final List<MarkerColor> classic40 = collection('classic_40');
      var short = 0, none = 0;
      for (final MarkerColor base in classic40) {
        if (isColourlessBlender(base)) continue;
        final BlendingChainResult result = buildBlendingChains(
          base,
          classic40,
          length: 5,
        );
        if (result.best == null) {
          none++;
          expect(result.gap, isNot(BlendingGap.none));
        } else if (result.isShort) {
          short++;
        }
      }
      // 40 markers cover a dozen families thinly: both honest answers occur.
      expect(short, greaterThan(0));
      expect(none, greaterThan(0));
    });

    test('Black has no chain: it needs a lighter marker', () {
      final MarkerColor black = classic160.firstWhere(
        (c) => c.newCode == '120',
      );
      final BlendingChainResult result = buildBlendingChains(black, classic160);
      expect(result.best, isNull);
      expect(result.gap, BlendingGap.lighter);
    });
  });

  group('the palette engine', () {
    final MarkerColor base = _marker('base', 0.60, 0.10, 250);
    final List<MarkerColor> pool = <MarkerColor>[
      base,
      _marker('L1', 0.69, 0.10, 250),
      _marker('L2', 0.78, 0.10, 250),
      _marker('D1', 0.51, 0.10, 250),
      _marker('D2', 0.42, 0.10, 250),
    ];

    test('buildPalette returns the companions in chain order, with roles', () {
      final List<PaletteSuggestion> result = buildPalette(
        base,
        pool,
        PaletteMode.blendingChain,
        size: 4,
      );
      expect(result.map((s) => s.color.newCode), <String>[
        'L2',
        'L1',
        'D1',
        'D2',
      ]);
      expect(result.map((s) => s.reason), <String>[
        BlendingRoles.lightest,
        BlendingRoles.lighter,
        BlendingRoles.darker,
        BlendingRoles.darkest,
      ]);
    });

    test('buildPalette is shorter, not padded, when the family is small', () {
      final List<PaletteSuggestion> result = buildPalette(
        base,
        pool.take(3).toList(),
        PaletteMode.blendingChain,
        size: 4,
      );
      expect(result, hasLength(2));
    });

    test('the advisor fails with noSuggestions when there is no chain', () {
      final PaletteAdvice advice = const PaletteGenerator().advise(
        PaletteAdvisorRequest(
          baseColor: base,
          availableColors: <MarkerColor>[base],
          mode: PaletteMode.blendingChain,
          activeSetIds: {'classic_160'},
        ),
      );
      expect(advice, isA<PaletteAdviceFailure>());
      expect(
        (advice as PaletteAdviceFailure).reason,
        PaletteFailureReason.noSuggestions,
      );
    });

    test('the new mode survives JSON, and old saved modes still decode', () {
      expect(PaletteMode.blendingChain.toJson(), 'BlendingChain');
      expect(PaletteMode.fromJson('BlendingChain'), PaletteMode.blendingChain);
      for (final String old in <String>[
        'Recommended',
        'Complementary',
        'Analogous',
        'SplitComplementary',
        'Triad',
        'Square',
        'Rectangle',
        'Monochrome',
        'CustomPalette',
        'Shadow',
      ]) {
        expect(PaletteMode.fromJson(old).toJson(), old);
      }
    });
  });
}
