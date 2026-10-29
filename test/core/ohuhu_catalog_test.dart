import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/collection_selection.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/core/natural_sort.dart';

/// Data-quality tests for the bundled catalogs. A failure here means the data
/// (or `tool/data/generate_ohuhu.py`) is wrong: report it, do not loosen it.
const baselinePath = 'tool/data/baseline/oahu_colors_v1.json';

final hexPattern = RegExp(r'^[0-9a-f]{6}$');

List<MarkerColor> loadBrand(MarkerBrand brand) =>
    parseColors(File(brand.assetPath).readAsStringSync(), brand: brand);

/// The Oahu catalog as it shipped before product lines existed (321 colours).
List<Map<String, dynamic>> loadBaseline() =>
    (jsonDecode(File(baselinePath).readAsStringSync()) as List)
        .cast<Map<String, dynamic>>();

/// The twelve Oahu packs that existed before lines: their ids are persisted.
Set<String> originalSetIds() => {
  for (final set in OahuSet.values)
    if (set.line == MarkerLine.oahu && set.source == SetSource.official) set.id,
};

void main() {
  final ohuhu = loadBrand(MarkerBrand.ohuhuOahu);
  final deco = loadBrand(MarkerBrand.decoTime);
  final baseline = loadBaseline();

  group('shared data quality', () {
    for (final brand in MarkerBrand.values) {
      final colors = loadBrand(brand);
      test('${brand.label}: codes are unique (case-insensitive)', () {
        final codes = colors.map((c) => c.newCode.toUpperCase()).toList();
        expect(codes.toSet().length, codes.length);
        expect(colors.map((c) => c.colorId).toSet().length, colors.length);
      });
      test('${brand.label}: hex is always 6 lowercase digits', () {
        expect(colors.where((c) => !hexPattern.hasMatch(c.hex)), isEmpty);
      });
      test('${brand.label}: every colour belongs to at least one set', () {
        expect(
          colors.where((c) => c.sets.isEmpty).map((c) => c.newCode),
          isEmpty,
        );
      });
      test('${brand.label}: names are clean and not merged', () {
        final problems = <String>[];
        for (final c in colors) {
          for (final name in {c.newName, c.oldName}) {
            if (name.isEmpty) problems.add('${c.newCode}: empty name');
            if (name != name.trim()) {
              problems.add('${c.newCode}: "$name" padded');
            }
            if (name.contains('  ')) {
              problems.add('${c.newCode}: "$name" has double space');
            }
            if (name.contains(RegExp(r'[a-z][A-Z]'))) {
              problems.add('${c.newCode}: "$name" looks merged');
            }
            if (name.contains('*')) {
              problems.add('${c.newCode}: "$name" has *');
            }
            if (name.length > 40) {
              problems.add('${c.newCode}: "$name" too long');
            }
          }
          if (c.newCode != c.newCode.trim() || c.newCode.contains(' ')) {
            problems.add('${c.newCode}: bad code');
          }
        }
        expect(problems, isEmpty);
      });
    }
  });

  group('Ohuhu catalog', () {
    final membersBySet = <String, List<MarkerColor>>{};
    for (final color in ohuhu) {
      for (final id in color.sets) {
        membersBySet.putIfAbsent(id, () => []).add(color);
      }
    }

    test('colour count and ordering are deterministic', () {
      expect(ohuhu.length, 503);
      expect(ohuhu.first.newCode, '0');
      // Baseline colours keep their frozen order, added ones follow in
      // natural order (numeric ties such as BV15 / BV015 by plain order).
      final baselineCodes = baseline.map((e) => e['newCode']).toList();
      expect(ohuhu.take(321).map((c) => c.newCode), baselineCodes);
      final added = ohuhu.skip(321).map((c) => c.newCode).toList();
      final sorted = [...added]
        ..sort((a, b) {
          final natural = naturalCodeComparator(a, b);
          return natural != 0 ? natural : a.compareTo(b);
        });
      expect(added, sorted);
    });

    test('every set id in the data is a known OahuSet and vice versa', () {
      expect(
        membersBySet.keys.toSet().difference(OahuSet.byId.keys.toSet()),
        isEmpty,
      );
      expect(
        OahuSet.byId.keys.toSet().difference(membersBySet.keys.toSet()),
        isEmpty,
      );
    });

    for (final set in OahuSet.values) {
      test('${set.id}: member count equals the count implied by its name', () {
        final members = membersBySet[set.id] ?? const <MarkerColor>[];
        expect(
          members.length,
          set.expectedMemberCount,
          reason:
              '${set.fullLabel} names ${set.colorCount} colours'
              '${set.includesBlender ? ' + blender' : ''}',
        );
        expect(
          members.any((c) => c.newCode == '0'),
          set.includesBlender,
          reason: 'blender membership of ${set.id}',
        );
      });
    }

    test('lines are valid, non-empty and consistent with set membership', () {
      final lineIds = MarkerLine.values.map((l) => l.id).toSet();
      for (final color in ohuhu) {
        expect(color.lines, isNotEmpty, reason: color.newCode);
        expect(lineIds.containsAll(color.lines), isTrue, reason: color.newCode);
        expect(color.lines.toSet().length, color.lines.length);
        for (final id in color.sets) {
          expect(
            color.lines,
            contains(OahuSet.byId[id]!.line.id),
            reason: '${color.newCode} in $id',
          );
        }
      }
      expect(ohuhu.firstWhere((c) => c.newCode == '0').lines, [
        'oahu',
        'honolulu',
        'kaala',
      ]);
    });

    test('set line metadata is coherent', () {
      for (final set in OahuSet.values) {
        if (set.line != MarkerLine.oahu) {
          expect(set.id, startsWith('${set.line.id}_'));
        }
        expect(OahuSet.forLine(set.line), contains(set));
        if (set.isLegacy) expect(set.isCommunity, isTrue, reason: set.id);
      }
      for (final id in [
        'basic_6',
        'pastel_6',
        'skin_6',
        'white_24',
        'white_48',
        'white_72',
        'white_128',
        'white_200',
      ]) {
        final set = OahuSet.byId[id]!;
        expect(set.source, SetSource.community, reason: id);
        expect(set.isLegacy, isTrue, reason: id);
        expect(set.line, MarkerLine.oahu, reason: id);
      }
      expect(MarkerBrand.ohuhuOahu.lines, MarkerLine.values);
      expect(MarkerBrand.decoTime.lines, isEmpty);
    });

    test('Honolulu and Kaala add exactly 182 colours on top of Oahu', () {
      expect(ohuhu.where((c) => c.inLine(MarkerLine.oahu)).length, 321);
      expect(ohuhu.where((c) => !c.inLine(MarkerLine.oahu)).length, 182);
      expect(ohuhu.where((c) => c.inLine(MarkerLine.honolulu)).length, 364);
      expect(ohuhu.where((c) => c.inLine(MarkerLine.kaala)).length, 200);
    });
  });

  group('Oahu golden comparison with the pre-lines catalog', () {
    final byCode = {for (final c in ohuhu) c.newCode: c};
    final original = originalSetIds();

    test('baseline file is the 321-colour Oahu catalog', () {
      expect(baseline.length, 321);
      expect(original.length, 12);
    });

    test('every original colour is unchanged (names, old codes, hex)', () {
      for (final item in baseline) {
        final now = byCode[item['newCode']];
        expect(now, isNotNull, reason: '${item['newCode']} missing');
        expect(now!.newName, item['newName'], reason: now.newCode);
        expect(now.oldCode, item['oldCode'], reason: now.newCode);
        expect(now.oldName, item['oldName'], reason: now.newCode);
        expect(now.hex, item['hex'], reason: now.newCode);
        expect(now.brandId, 'ohuhu_oahu');
      }
    });

    test('membership of the 12 original sets is identical', () {
      for (final item in baseline) {
        final now = byCode[item['newCode']]!;
        expect(
          now.sets.where(original.contains).toList(),
          (item['sets'] as List).cast<String>(),
          reason: now.newCode,
        );
      }
      // No new colour leaked into an original set or into the Oahu line.
      final baselineCodes = baseline.map((e) => e['newCode']).toSet();
      for (final c in ohuhu.where((c) => !baselineCodes.contains(c.newCode))) {
        expect(c.sets.where(original.contains), isEmpty, reason: c.newCode);
        expect(c.inLine(MarkerLine.oahu), isFalse, reason: c.newCode);
      }
    });

    test('baseline colours keep a stable colorId and the Oahu line', () {
      for (final item in baseline) {
        final now = byCode[item['newCode']]!;
        expect(
          now.colorId,
          'ohuhu_oahu:${(item['newCode'] as String).toUpperCase()}',
        );
        expect(now.inLine(MarkerLine.oahu), isTrue);
      }
    });
  });

  group('migration of data stored before product lines existed', () {
    test('a pre-lines catalog payload loads as Oahu-only', () {
      final legacy = parseColors(
        File(baselinePath).readAsStringSync(),
        brand: MarkerBrand.ohuhuOahu,
      );
      expect(legacy.length, 321);
      expect(
        legacy.every((c) => c.lines.length == 1 && c.inLine(MarkerLine.oahu)),
        isTrue,
      );
      expect(legacy.first.toJson()['lines'], ['oahu']);
    });

    test('colours without lines keep their original JSON shape', () {
      expect(deco.first.lines, isEmpty);
      expect(deco.first.toJson().containsKey('lines'), isFalse);
      final legacyJson = ohuhu.first.toJson()..remove('lines');
      expect(MarkerColor.fromJson(legacyJson).lines, isEmpty);
      expect(MarkerColor.fromJson(ohuhu[5].toJson()), ohuhu[5]);
    });

    test('stored set ids, owned codes and palettes still resolve', () {
      final byCode = {for (final c in ohuhu) c.newCode.toUpperCase(): c};
      // Persisted set ids resolve to the same OahuSet.
      for (final item in baseline) {
        for (final id in (item['sets'] as List).cast<String>()) {
          expect(OahuSet.byId[id], isNotNull, reason: id);
        }
      }
      // Unscoped legacy owned codes and namespaced ones resolve to Ohuhu.
      final owned = scopedCodesForBrand({
        'bv04',
        'ohuhu_oahu:R12',
        'decotime:01',
      }, 'ohuhu_oahu');
      expect(owned, {'BV04', 'R12'});
      expect(byCode.keys, containsAll(owned));
      // A saved palette's colours are looked up by code in the catalog.
      final saved = SavedPalette(
        id: 'p',
        name: 'n',
        baseCode: 'BV04',
        baseName: 'Light Cornflower',
        mode: PaletteMode.triad,
        paletteSize: 3,
        createdAtEpochMs: 1,
        colorCodes: ['BV04', 'R12', 'YR114'],
      );
      expect(saved.brandId, 'ohuhu_oahu');
      expect(saved.colorCodes.every(byCode.containsKey), isTrue);
    });

    test('selections made before lines yield exactly the old colour lists', () {
      for (final id in originalSetIds()) {
        final expected = {
          for (final item in baseline)
            if ((item['sets'] as List).contains(id)) item['newCode'] as String,
        };
        final now = swatchCandidateColors(
          colors: ohuhu,
          brand: MarkerBrand.ohuhuOahu,
          activeSetIds: {id},
        ).map((c) => c.newCode).toList();
        expect(now.toSet(), expected, reason: id);
        expect(now.length, expected.length, reason: id);
      }
      final defaults = swatchCandidateColors(
        colors: ohuhu,
        brand: MarkerBrand.ohuhuOahu,
      );
      final classic160 = swatchCandidateColors(
        colors: ohuhu,
        brand: MarkerBrand.ohuhuOahu,
        activeSetIds: {'classic_160'},
      );
      expect(defaults, classic160);
      expect(AppSettings().effectiveSetIds(), {'classic_160'});
    });

    test('the retired oahu_colors.json asset is gone, the new one loads', () {
      expect(MarkerBrand.ohuhuOahu.assetFile, 'ohuhu_colors.json');
      expect(File('assets/data/oahu_colors.json').existsSync(), isFalse);
      expect(File(MarkerBrand.ohuhuOahu.assetPath).existsSync(), isTrue);
    });
  });
}
