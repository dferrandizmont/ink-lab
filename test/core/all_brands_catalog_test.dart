import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/brand_equivalents.dart';
import 'package:ink_lab/core/collection_selection.dart';
import 'package:ink_lab/core/color_utils.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/core/palette_generator.dart';
import 'package:ink_lab/core/purchase_advisor.dart';
import 'package:ink_lab/core/scene_catalog.dart';
import 'package:ink_lab/data/brand_scoping.dart';
import 'package:ink_lab/ui/pages/collection/collection_summary.dart';
import 'package:ink_lab/ui/pages/swatches/brand_equivalents_index.dart';

import '../support/l10n.dart';

/// Exact size of every catalogue. A change here is a data change: update the
/// generator, `tool/data/README.md` and the READMEs together.
const Map<MarkerBrand, int> counts = <MarkerBrand, int>{
  MarkerBrand.ohuhuOahu: 503,
  MarkerBrand.decoTime: 313,
  MarkerBrand.copic: 358,
  MarkerBrand.finecolour: 480,
  MarkerBrand.touchTwin: 202,
  MarkerBrand.promarker: 148,
  MarkerBrand.promarkerBrush: 72,
  MarkerBrand.prismacolor: 200,
  MarkerBrand.spectrumNoir: 216,
  MarkerBrand.arrtx: 328,
  MarkerBrand.kurecolor: 136,
  MarkerBrand.graphit: 168,
  MarkerBrand.marvyLePlume: 144,
  MarkerBrand.blickBrush: 96,
  MarkerBrand.artistsLoft: 56,
};

/// The brands added after the original four.
final List<MarkerBrand> newBrands = MarkerBrand.values.skip(4).toList();

void main() {
  final MarkerRepository repo = MarkerRepository(
    loadAsset: (String path) => File(path).readAsStringSync(),
  );

  test('brand order, ids and labels are stable', () {
    expect(
      MarkerBrand.values.map((MarkerBrand b) => (b.id, b.label)),
      <(String, String)>[
        ('ohuhu_oahu', 'Ohuhu'),
        ('decotime', 'DecoTime'),
        ('copic', 'Copic'),
        ('finecolour', 'Finecolour'),
        ('touch_twin', 'Touch Twin'),
        ('promarker', 'Promarker'),
        ('promarker_brush', 'Promarker Brush'),
        ('prismacolor', 'Prismacolor Premier'),
        ('spectrum_noir', 'Spectrum Noir'),
        ('arrtx', 'Arrtx'),
        ('kurecolor', 'ZIG Kurecolor'),
        ('graphit', "Graph'it"),
        ('marvy_le_plume', 'Marvy Le Plume'),
        ('blick_brush', 'Blick Studio Brush'),
        ('artists_loft', "Artist's Loft"),
      ],
    );
    expect(counts.keys.toSet(), MarkerBrand.values.toSet());
    for (final MarkerBrand brand in MarkerBrand.values) {
      expect(MarkerBrand.fromId(brand.id), brand);
      expect(MarkerBrand.fromJson(brand.toJson()), brand);
      expect(brand.hasRetailSets, brand == MarkerBrand.ohuhuOahu);
    }
    expect(MarkerBrand.fromId('nonsense'), MarkerBrand.ohuhuOahu);
  });

  test('the catalogues hold 3,420 colours in total', () async {
    int total = 0;
    for (final MarkerBrand brand in MarkerBrand.values) {
      final List<MarkerColor> colors = await repo.loadColors(brand);
      expect(colors, hasLength(counts[brand]), reason: brand.label);
      total += colors.length;
    }
    expect(total, 3420);
  });

  for (final MarkerBrand brand in MarkerBrand.values) {
    test('${brand.label}: valid unique colours that survive scoping', () async {
      final List<MarkerColor> colors = await repo.loadColors(brand);
      expect(
        colors.map((MarkerColor c) => c.colorId).toSet(),
        hasLength(colors.length),
      );
      for (final MarkerColor color in colors) {
        expect(color.brandId, brand.id);
        expect(color.newName.trim(), isNotEmpty);
        expect(color.hex, matches(RegExp(r'^[0-9a-f]{6}$')));
        expect(MarkerColor.fromJson(color.toJson()), color);
        // A stored favourite or owned marker keeps its id through scoping.
        expect(scopedColorId(color.colorId), color.colorId);
        expect(color.newCode, color.newCode.trim().toUpperCase());
        expect(color.newCode, isNot(contains(':')));
        // Lines are only the ids the brand declares.
        final Set<String> declared = brand.productLines
            .map((BrandLine l) => l.id)
            .toSet();
        for (final String id in color.lines) {
          expect(declared, contains(id), reason: '${color.colorId} $id');
        }
      }
    });
  }

  for (final MarkerBrand brand in MarkerBrand.values.where(
    (MarkerBrand b) => !b.hasRetailSets,
  )) {
    test(
      '${brand.label}: owned markers, Match and the Palette base code',
      () async {
        final List<MarkerColor> colors = await repo.loadColors(brand);
        final MarkerColor chosen = colors.first;
        final List<MarkerColor> mine = ownedColors(
          colors: colors,
          brand: brand,
          ownedSetIds: <String>{'classic_160'},
          ownedMarkerCodes: <String>{
            chosen.colorId,
            'ohuhu_oahu:${chosen.newCode}',
          },
        );
        expect(mine, <MarkerColor>[chosen]);
        expect(
          ownedColors(
            colors: colors,
            brand: brand,
            ownedMarkerCodes: <String>{chosen.colorId},
            driedColorIds: <String>{chosen.colorId},
          ),
          isEmpty,
        );
        final match = findClosestMarkerMatches(
          hexToColorInt(chosen.hex),
          mine,
        ).single;
        expect(match.color, chosen);
        expect(match.deltaE, 0);
        expect(resolveBaseColor(chosen.newCode, colors), chosen);
        expect(resolveBaseColor(chosen.newCode.toLowerCase(), colors), chosen);
      },
    );
  }

  test(
    'the purchase advisor suggests only unowned markers of every brand',
    () async {
      final SceneCatalog scenes = SceneCatalog.parse(
        File(SceneCatalog.assetPath).readAsStringSync(),
      );
      for (final MarkerBrand brand in MarkerBrand.values) {
        final List<MarkerColor> range = await repo.loadColors(brand);
        final List<MarkerColor> owned = range.take(6).toList();
        final List<PurchaseSuggestion> suggestions = suggestPurchases(
          range: range,
          owned: owned,
          scenes: scenes.scenes,
          limit: 8,
        );
        expect(suggestions, hasLength(8), reason: brand.label);
        final Set<String> ownedIds = owned
            .map((MarkerColor c) => c.colorId)
            .toSet();
        for (final PurchaseSuggestion s in suggestions) {
          expect(s.color.brandId, brand.id);
          expect(ownedIds, isNot(contains(s.color.colorId)));
        }
      }
    },
  );

  test('every brand finds its equivalents in the 14 other brands', () async {
    final BrandEquivalentsIndex index = await BrandEquivalentsIndex.load(repo);
    final List<MarkerColor> firsts = <MarkerColor>[
      for (final MarkerBrand brand in MarkerBrand.values)
        (await repo.loadColors(brand)).first,
    ];
    final AppSettings settings = AppSettings(
      extraMarkerIds: <String>{for (final MarkerColor c in firsts) c.colorId},
    );
    for (final MarkerColor marker in firsts) {
      final groups = index.closestTo(
        marker,
        settings: settings,
        driedIds: <String>{},
      );
      expect(
        groups.map((g) => g.brand),
        MarkerBrand.values.where((MarkerBrand b) => b.id != marker.brandId),
      );
      for (final g in groups) {
        expect(
          g.matches,
          hasLength(3),
          reason: '${marker.colorId} -> ${g.brand.label}',
        );
        expect(g.closest!.deltaE.isFinite, isTrue);
      }
      final mine = index.closestTo(
        marker,
        settings: settings,
        driedIds: <String>{},
        onlyMine: true,
      );
      expect(mine, hasLength(14));
      expect(
        mine.every(
          (g) =>
              g.matches.length == 1 &&
              settings.extraMarkerIds.contains(g.closest!.color.colorId),
        ),
        isTrue,
      );
      expect(
        index.closestTo(
          marker,
          settings: settings,
          driedIds: settings.extraMarkerIds,
          onlyMine: true,
        ),
        isEmpty,
      );
    }
  });

  test('a dark marker finds a dark equivalent in every other brand', () async {
    final List<MarkerColor> everything = <MarkerColor>[
      for (final MarkerBrand brand in MarkerBrand.values)
        ...await repo.loadColors(brand),
    ];
    final BrandEquivalentFinder finder = BrandEquivalentFinder(everything);
    final MarkerColor copicBlack = everything.firstWhere(
      (MarkerColor c) => c.colorId == 'copic:100',
    );
    final groups = finder.closestTo(copicBlack, limit: 1);
    expect(groups, hasLength(14));
    for (final g in groups) {
      final double lightness = hexToLab(g.closest!.color.hex).l;
      // Spectrum Noir's own black is a dark grey on its chart (L* 33).
      expect(lightness, lessThan(40), reason: g.brand.label);
    }
  });

  group('Copic lines', () {
    test('Sketch, Ciao and Classic are lines of the one Copic brand', () async {
      final List<MarkerColor> colors = await repo.loadColors(MarkerBrand.copic);
      int count(String line) =>
          colors.where((MarkerColor c) => c.lines.contains(line)).length;
      expect(
        (count('sketch'), count('ciao'), count('classic')),
        (358, 180, 214),
      );
      expect(
        colors.every((MarkerColor c) => c.lines.first == 'sketch'),
        isTrue,
      );
      expect(
        MarkerBrand.copic.productLines.map((BrandLine l) => l.label),
        <String>['Sketch', 'Ciao', 'Classic'],
      );
    });

    test('colour ids are exactly the ones Copic had before lines existed', () async {
      final Object? source = jsonDecode(
        File('tool/data/baseline/copic_colors_source.json').readAsStringSync(),
      );
      final Set<String> before = <String>{
        for (final Object? row in source! as List<dynamic>)
          'copic:${((row! as Map<String, dynamic>)['number'] as String).trim().toUpperCase()}',
      };
      final List<MarkerColor> colors = await repo.loadColors(MarkerBrand.copic);
      expect(colors.map((MarkerColor c) => c.colorId).toSet(), before);
      // Hex, names and sets did not move either: only `lines` was added.
      final MarkerColor blender = colors.firstWhere(
        (MarkerColor c) => c.newCode == '0',
      );
      expect(blender.newName, 'Colorless Blender');
      expect(blender.hex, 'ffffff');
      expect(blender.sets, isEmpty);
      expect(
        colors.firstWhere((MarkerColor c) => c.newCode == '100').hex,
        '000000',
      );
    });

    test('range labels name the ranges in the brand order', () async {
      expect(
        MarkerBrand.copic.rangeLabels(<String>['classic', 'sketch']),
        <String>['Sketch', 'Classic'],
      );
      expect(MarkerBrand.arrtx.rangeLabels(<String>['ALP', 'OROS']), <String>[
        'OROS',
        'ALP',
      ]);
      expect(
        MarkerBrand.spectrumNoir.rangeLabels(<String>['triblend']),
        <String>['TriBlend'],
      );
      expect(
        MarkerBrand.ohuhuOahu.rangeLabels(<String>['kaala', 'oahu']),
        <String>['Oahu', 'Kaala'],
      );
      // Availability codes are not ranges a person would read.
      expect(MarkerBrand.finecolour.rangeLabels(<String>['EF100']), isEmpty);
      expect(
        MarkerBrand.touchTwin.rangeLabels(<String>['touchTwinMarker']),
        isEmpty,
      );
      expect(MarkerBrand.decoTime.rangeLabels(<String>[]), isEmpty);
    });

    test('a payload written before lines existed still parses', () {
      final List<MarkerColor> parsed = parseColors(
        '[{"code":"BV04","name":"Blue Berry","hex":"#aabbcc","sets":[]}]',
        brand: MarkerBrand.copic,
      );
      expect(parsed.single.colorId, 'copic:BV04');
      expect(parsed.single.lines, isEmpty);
      expect(parsed.single.toJson().containsKey('lines'), isFalse);
    });
  });

  group('Spectrum Noir', () {
    test('is one brand with classic, illustrator and triblend lines', () async {
      final List<MarkerColor> colors = await repo.loadColors(
        MarkerBrand.spectrumNoir,
      );
      Set<String> codes(String line) => <String>{
        for (final MarkerColor c in colors)
          if (c.lines.contains(line)) c.newCode,
      };
      expect(
        (
          codes('classic').length,
          codes('illustrator').length,
          codes('triblend').length,
        ),
        (168, 216, 144),
      );
      expect(codes('classic').difference(codes('illustrator')), isEmpty);
      expect(codes('triblend').difference(codes('illustrator')), isEmpty);
      expect(
        MarkerBrand.spectrumNoir.productLines.map((BrandLine l) => l.id),
        <String>['classic', 'illustrator', 'triblend'],
      );
    });

    test('uses the official chart names and hex, and the chart codes', () async {
      final List<MarkerColor> colors = await repo.loadColors(
        MarkerBrand.spectrumNoir,
      );
      MarkerColor byCode(String code) =>
          colors.singleWhere((MarkerColor c) => c.newCode == code);
      expect(byCode('DR1').newName, 'Red');
      expect(byCode('BL').newName, 'Blender');
      expect(byCode('TB').newName, 'True Black');
      // MarkerMatchDB called them BLENDER and TRUEBLACK, had codes as names and
      // could not read BT6.
      expect(colors.any((MarkerColor c) => c.newCode == 'BLENDER'), isFalse);
      expect(colors.any((MarkerColor c) => c.newCode == 'TRUEBLACK'), isFalse);
      expect(byCode('BT6').newName, 'Peacock Blue');
      expect(byCode('BT6').lines, <String>['classic', 'illustrator']);
      expect(colors.where((MarkerColor c) => c.newCode == c.newName), isEmpty);
    });
  });

  group('Arrtx', () {
    test('OROS and ALP lines; unnamed colours show their code', () async {
      final List<MarkerColor> colors = await repo.loadColors(MarkerBrand.arrtx);
      expect(
        colors.where((MarkerColor c) => c.lines.contains('OROS')),
        hasLength(328),
      );
      expect(
        colors.where((MarkerColor c) => c.lines.contains('ALP')),
        hasLength(226),
      );
      final List<MarkerColor> unnamed = colors
          .where((MarkerColor c) => c.newName == c.newCode)
          .toList();
      expect(unnamed, hasLength(90));
      expect(unnamed.every((MarkerColor c) => c.lines.length == 1), isTrue);
      expect(
        colors.where((MarkerColor c) => c.newName.startsWith('OROS ')),
        isEmpty,
      );
      expect(
        colors.singleWhere((MarkerColor c) => c.newCode == '502').newName,
        '502',
      );
      expect(
        colors.singleWhere((MarkerColor c) => c.newCode == '120').newName,
        'Black',
      );
    });
  });

  group('MarkerMatchDB brands', () {
    test('Touch Twin keeps both tips; PB72 is dropped as ambiguous', () async {
      final List<MarkerColor> touch = await repo.loadColors(
        MarkerBrand.touchTwin,
      );
      expect(
        touch.every(
          (MarkerColor c) =>
              c.lines.join(',') == 'touchTwinMarker,touchTwinBrush',
        ),
        isTrue,
      );
      expect(touch.any((MarkerColor c) => c.newCode == 'PB72'), isFalse);
    });

    test('Prismacolor Premier PM codes carry their PB alias', () async {
      final List<MarkerColor> prisma = await repo.loadColors(
        MarkerBrand.prismacolor,
      );
      for (final MarkerColor color in prisma) {
        expect(color.newCode, matches(RegExp(r'^PM\d+$')));
        expect(color.oldCode, color.newCode.replaceFirst('PM', 'PB'));
        expect(resolveBaseColor(color.oldCode.toLowerCase(), prisma), color);
      }
      // Typed the way it is printed on the pen, with a space.
      expect(resolveBaseColor('pm 23', prisma)?.colorId, 'prismacolor:PM23');
      expect(resolveBaseColor('PB 23', prisma)?.colorId, 'prismacolor:PM23');
    });

    test(
      'Promarker Brush is its own brand: 15 codes are not Promarker colours',
      () async {
        final List<MarkerColor> promarker = await repo.loadColors(
          MarkerBrand.promarker,
        );
        final List<MarkerColor> brush = await repo.loadColors(
          MarkerBrand.promarkerBrush,
        );
        final Set<String> promarkerCodes = promarker
            .map((MarkerColor c) => c.newCode)
            .toSet();
        expect(
          brush.where((MarkerColor c) => !promarkerCodes.contains(c.newCode)),
          hasLength(15),
        );
        expect(brush.first.colorId, 'promarker_brush:Y828');
      },
    );
  });

  test('onboarding counts and collection hints exist in all six languages', () {
    for (final AppLocalizations messages in <AppLocalizations>[
      l10n,
      ...l10nTranslated,
    ]) {
      for (final MarkerBrand brand in newBrands) {
        final String line = messages.onboardingBrandLine(brand);
        final Iterable<RegExpMatch> numbers = RegExp(r'\d+').allMatches(line);
        expect(numbers, hasLength(1), reason: '${brand.label}: $line');
        expect(
          int.parse(numbers.single.group(0)!),
          counts[brand],
          reason: line,
        );
        final String hint = messages.individualMarkersHint(brand);
        expect(hint, contains(brand.label));
        expect(hint, isNot(messages.collectionDecoHint));
        expect(
          messages.paletteUnknownCode(brand.name, 'zz', 'ex'),
          contains(brand.label),
        );
        expect(
          messages.paletteNoAvailableColors(brand.name),
          contains(brand.label),
        );
      }
      for (final MarkerBrand brand in MarkerBrand.values) {
        expect(messages.onboardingBrandLine(brand), isNotEmpty);
        expect(messages.individualMarkersHint(brand), isNotEmpty);
      }
    }
  });
}
