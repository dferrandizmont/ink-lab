import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';
import 'package:ink_lab/core/swatch_card_location.dart';
import 'package:ink_lab/ui/pages/collection/collection_summary.dart';

/// Automatic data-quality validation of every bundled colour catalogue.
///
/// The catalogues are discovered by listing `assets/data/*_colors.json`, so a
/// brand added later is checked without touching this file. Entries are read
/// through `parseColors` from `lib/core/marker_repository.dart`, the same code
/// path the app uses, so these tests see exactly what the app sees. The
/// format-specific, deep checks stay where they are
/// (`test/core/ohuhu_catalog_test.dart`, `test/core/copic_catalog_test.dart`,
/// `test/core/finecolour_catalog_test.dart`
/// and `test/core/scene_catalog_test.dart`); this file owns catalogue
/// discovery, the cross-brand shape checks and the invariants those files do
/// not cover (per-line legacy-code uniqueness, identical entries, card
/// locations). A
/// failure here means the data is wrong: report it, never loosen the check.
const String catalogDirectory = 'assets/data';

/// Every generated marker catalogue ends with this suffix.
final RegExp catalogFileName = RegExp(r'_colors\.json$');

/// A catalogue colour is a lowercase, six-digit hex with no `#`.
final RegExp hexPattern = RegExp(r'^[0-9a-f]{6}$');

/// The catalogue files under [catalogDirectory], sorted, so the checks below
/// follow the directory instead of a hardcoded list.
List<String> discoverCatalogFiles() {
  final List<String> files =
      Directory(catalogDirectory)
          .listSync()
          .whereType<File>()
          .map((File file) => file.uri.pathSegments.last)
          .where(catalogFileName.hasMatch)
          .toList()
        ..sort();
  return files;
}

/// The raw key holding the colour code in a brand's catalogue file.
String codeKeyOf(MarkerBrand brand) =>
    brand == MarkerBrand.ohuhuOahu ? 'newCode' : 'code';

/// The raw key holding the colour name in a brand's catalogue file.
String nameKeyOf(MarkerBrand brand) =>
    brand == MarkerBrand.ohuhuOahu ? 'newName' : 'name';

String? stringField(Map<String, dynamic> entry, String key) {
  final Object? value = entry[key];
  return value is String ? value : null;
}

/// The entry with its keys sorted, so two objects are equal only when every
/// field (and value) matches.
Map<String, Object?> canonicalEntry(Map<String, dynamic> entry) {
  final List<String> keys = entry.keys.toList()..sort();
  return <String, Object?>{for (final String key in keys) key: entry[key]};
}

/// Reads and decodes a catalogue file, failing with the file name if it is not
/// a JSON list of objects.
List<Map<String, dynamic>> readEntries(String file) {
  final Object? decoded = jsonDecode(
    File('$catalogDirectory/$file').readAsStringSync(),
  );
  expect(decoded, isA<List<dynamic>>(), reason: '$file must be a JSON list');
  final List<dynamic> list = decoded! as List<dynamic>;
  final List<Map<String, dynamic>> entries = <Map<String, dynamic>>[];
  for (int index = 0; index < list.length; index++) {
    final Object? value = list[index];
    if (value is! Map<String, dynamic>) {
      fail('$file: entry #$index is not a JSON object');
    }
    entries.add(value);
  }
  return entries;
}

void main() {
  final List<String> files = discoverCatalogFiles();
  final Map<String, MarkerBrand> brandByFile = <String, MarkerBrand>{
    for (final MarkerBrand brand in MarkerBrand.values) brand.assetFile: brand,
  };
  final String pubspec = File('pubspec.yaml').readAsStringSync();

  test('every *_colors.json is a registered brand and vice versa', () {
    expect(files, isNotEmpty, reason: 'no catalogues under $catalogDirectory');
    expect(
      files.toSet(),
      brandByFile.keys.toSet(),
      reason:
          'a new catalogue needs a MarkerBrand entry, and every MarkerBrand '
          'must have its file',
    );
    for (final String file in files) {
      expect(
        File('$catalogDirectory/$file').existsSync(),
        isTrue,
        reason: '$file is missing',
      );
      expect(
        pubspec,
        contains('- assets/data/$file'),
        reason: '$file is not declared under assets in pubspec.yaml',
      );
    }
  });

  for (final String file in files) {
    final MarkerBrand? brand = brandByFile[file];
    group(file, () {
      if (brand == null) {
        test('is a registered brand', () {
          fail(
            '$file has no MarkerBrand with assetFile "$file": the app would '
            'never load it',
          );
        });
        return;
      }
      final String codeKey = codeKeyOf(brand);
      final String nameKey = nameKeyOf(brand);

      test('is a JSON list parsed 1:1 by the app', () {
        final List<Map<String, dynamic>> entries = readEntries(file);
        final String raw = File(
          '$catalogDirectory/$file',
        ).readAsStringSync();
        final List<MarkerColor> parsed = parseColors(raw, brand: brand);
        expect(entries, isNotEmpty, reason: '$file has no entries');
        // No length comparison: parseColors maps one-to-one over the decoded
        // list, so it would always match. Parsing not throwing above, plus the
        // brand being applied, is what this test protects.
        expect(
          parsed.every((MarkerColor c) => c.brandId == brand.id),
          isTrue,
          reason: 'the app scopes $file to ${brand.id}',
        );
      });

      test('every entry has a non-empty code, name and 6-digit hex', () {
        final List<Map<String, dynamic>> entries = readEntries(file);
        final List<MarkerColor> parsed = parseColors(
          File('$catalogDirectory/$file').readAsStringSync(),
          brand: brand,
        );
        final List<String> problems = <String>[];
        for (int index = 0; index < entries.length; index++) {
          final Map<String, dynamic> entry = entries[index];
          final String label =
              stringField(entry, codeKey) ?? 'entry #$index';
          final String? code = stringField(entry, codeKey);
          if (code == null || code.trim().isEmpty) {
            problems.add('$label: $codeKey is empty or not a string');
          } else if (code != code.trim()) {
            problems.add('$label: $codeKey "$code" is padded');
          }
          final String? name = stringField(entry, nameKey);
          if (name == null || name.trim().isEmpty) {
            problems.add('$label: $nameKey is empty or not a string');
          }
          final String? hex = stringField(entry, 'hex');
          final String normalized =
              (hex ?? '').trim().toLowerCase().replaceFirst('#', '');
          if (!hexPattern.hasMatch(normalized)) {
            problems.add('$label: hex "$hex" is not six hex digits');
          }
        }
        // Belt and braces: what the app reads must be well formed too.
        for (final MarkerColor color in parsed) {
          if (color.newCode.trim().isEmpty) {
            problems.add('${color.colorId}: parsed code is empty');
          }
          if (color.newName.trim().isEmpty) {
            problems.add('${color.colorId}: parsed name is empty');
          }
          if (!hexPattern.hasMatch(color.hex)) {
            problems.add('${color.colorId}: parsed hex "${color.hex}" is bad');
          }
        }
        expect(problems, isEmpty, reason: problems.join('\n'));
      });

      test('codes are unique and no two entries are identical', () {
        final List<Map<String, dynamic>> entries = readEntries(file);
        final List<MarkerColor> parsed = parseColors(
          File('$catalogDirectory/$file').readAsStringSync(),
          brand: brand,
        );
        final List<String> problems = <String>[];

        final Map<String, String> seenCodes = <String, String>{};
        for (final MarkerColor color in parsed) {
          final String key = color.newCode.toUpperCase();
          final String? first = seenCodes[key];
          if (first != null) {
            problems.add(
              'duplicate code "$key": "$first" and "${color.newCode}"',
            );
          } else {
            seenCodes[key] = color.newCode;
          }
        }

        final Map<String, String> seenEntries = <String, String>{};
        for (final Map<String, dynamic> entry in entries) {
          final String label = stringField(entry, codeKey) ?? '(no code)';
          final String key = jsonEncode(canonicalEntry(entry));
          final String? first = seenEntries[key];
          if (first != null) {
            problems.add(
              '$label is identical in every field to $first',
            );
          } else {
            seenEntries[key] = label;
          }
        }
        expect(problems, isEmpty, reason: problems.join('\n'));
      });

      test('set and line ids exist where the app defines them', () {
        final Set<String> knownSets = switch (brand) {
          MarkerBrand.ohuhuOahu => OahuSet.byId.keys.toSet(),
          MarkerBrand.decoTime => decoTimeFamilyIds.toSet(),
          MarkerBrand.copic || MarkerBrand.finecolour => <String>{},
        };
        final Set<String> knownLines = switch (brand) {
          MarkerBrand.ohuhuOahu => MarkerLine.byId.keys.toSet(),
          MarkerBrand.finecolour => {'EF100', 'EF101', 'EF102', 'EF103'},
          _ => <String>{},
        };
        final List<MarkerColor> parsed = parseColors(
          File('$catalogDirectory/$file').readAsStringSync(),
          brand: brand,
        );
        final List<String> problems = <String>[];
        for (final MarkerColor color in parsed) {
          for (final String id in color.sets) {
            if (!knownSets.contains(id)) {
              problems.add('${color.newCode}: unknown set "$id"');
            }
          }
          for (final String id in color.lines) {
            if (!knownLines.contains(id)) {
              problems.add('${color.newCode}: unknown line "$id"');
            }
          }
        }
        expect(problems, isEmpty, reason: problems.join('\n'));
      });
    });
  }

  group('Ohuhu legacy codes', () {
    final List<MarkerColor> parsed = parseColors(
      File(MarkerBrand.ohuhuOahu.assetPath).readAsStringSync(),
      brand: MarkerBrand.ohuhuOahu,
    );

    test('an old code is unique inside each product line', () {
      // Ohuhu's lines share one code system since 2023, so the same legacy
      // code may legitimately appear once per line (e.g. E280 is Oahu's code
      // for Y611 and Honolulu's for Y62); that cross-line sharing is fine. A
      // repeat inside one line is not: the app resolves a legacy code to the
      // first match, so two markers of the same line sharing it are ambiguous.
      //
      // A colour's `lines` lists every line it is sold in, not only the one
      // that owns its legacy code, so a marker that merely appears in another
      // line's packs would look like it belonged there and cause false
      // collisions. The generator fills `lines` in LINE_ORDER (oahu, honolulu,
      // kaala) and takes oldCode from the first of those lines that has one,
      // so the line that owns the legacy code is the first entry of `lines`.
      final Map<String, List<MarkerColor>> byOldCode =
          <String, List<MarkerColor>>{};
      for (final MarkerColor color in parsed) {
        if (color.oldCode.isNotEmpty) {
          byOldCode.putIfAbsent(color.oldCode, () => <MarkerColor>[]).add(color);
        }
      }
      final List<String> problems = <String>[];
      byOldCode.forEach((String oldCode, List<MarkerColor> colors) {
        final Map<String, List<MarkerColor>> byLine =
            <String, List<MarkerColor>>{};
        for (final MarkerColor color in colors) {
          // parseColors guarantees a non-empty `lines`, defaulting to Oahu.
          final String line = color.lines.first;
          byLine.putIfAbsent(line, () => <MarkerColor>[]).add(color);
        }
        byLine.forEach((String line, List<MarkerColor> inLine) {
          if (inLine.length > 1) {
            problems.add(
              'old code "$oldCode" repeats on line "$line": '
              '${inLine.map((MarkerColor c) => c.newCode).join(', ')}',
            );
          }
        });
      });
      expect(problems, isEmpty, reason: problems.join('\n'));
    });
  });

  test('oahu_card_locations.json maps a code to its own set and a real card', () {
    final String raw = File(
      MarkerRepository.cardLocationsAssetPath,
    ).readAsStringSync();
    final Map<String, Map<String, int>> catalog =
        decodeSwatchCardLocationCatalog(raw);
    expect(
      catalog,
      isNotEmpty,
      reason: 'oahu_card_locations.json did not decode',
    );
    final List<MarkerColor> ohuhu = parseColors(
      File(MarkerBrand.ohuhuOahu.assetPath).readAsStringSync(),
      brand: MarkerBrand.ohuhuOahu,
    );
    final Set<String> allCodes =
        ohuhu.map((MarkerColor c) => c.newCode.toUpperCase()).toSet();
    // The rule buildSwatchCardLocationLabels applies: a label is only shown
    // for a code that belongs to the profile's set and for card > 0. The data
    // must satisfy both, or the mapping is silently ignored by the app.
    final Map<String, Set<String>> codesBySet = <String, Set<String>>{};
    for (final MarkerColor color in ohuhu) {
      final String code = color.newCode.toUpperCase();
      for (final String setId in color.sets) {
        codesBySet.putIfAbsent(setId, () => <String>{}).add(code);
      }
    }
    final List<String> problems = <String>[];
    catalog.forEach((String setId, Map<String, int> codeToCard) {
      if (!OahuSet.byId.containsKey(setId)) {
        problems.add('set "$setId" is not a known Ohuhu set');
      }
      final Set<String> members = codesBySet[setId] ?? const <String>{};
      codeToCard.forEach((String code, int card) {
        final String normalized = code.toUpperCase();
        if (!allCodes.contains(normalized)) {
          problems.add('$setId: card $card names code "$code", absent in Ohuhu');
        }
        if (card <= 0) {
          problems.add(
            '$setId: code "$code" has card $card; the app shows a label only '
            'when card > 0',
          );
        }
        if (!members.contains(normalized)) {
          problems.add(
            '$setId: code "$code" is not in set "$setId", so the app would '
            'show no location for it',
          );
        }
      });
    });
    expect(problems, isEmpty, reason: problems.join('\n'));
  });
}
