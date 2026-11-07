import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:ink_lab/core/marker_repository.dart';
import 'package:ink_lab/core/models.dart';

import 'fixtures.dart';

void main() {
  // Every brand but Ohuhu (whose backups are covered by backup_service_test):
  // the 14 others, whatever their id looks like (spaces, digits, lines).
  for (final brand in MarkerBrand.values.skip(1)) {
    test(
      '${brand.label} collection, palettes, matches and custom colours survive backup',
      () async {
        final repo = MarkerRepository(
          loadAsset: (path) => File(path).readAsStringSync(),
        );
        final colors = await repo.loadColors(brand);
        final color = colors.first;
        // A palette of another brand, to prove brands stay apart.
        final other = brand == MarkerBrand.decoTime
            ? MarkerBrand.copic
            : MarkerBrand.decoTime;
        final source = await harness();
        await source.appSettings.setBrand(brand);
        await source.appSettings.setExtraMarkerIds({
          color.colorId,
          'decotime:01',
        });
        await source.appSettings.setFavorites({color.colorId});
        await source.ownColors.set(color.colorId, 'abcdef');
        await source.wishlist.add(colors[1].colorId);
        await source.dried.add(colors[2].colorId);
        await source.savedPalettes.save(
          palette(
            id: 'new',
            brandId: brand.id,
            baseCode: color.newCode,
            baseName: color.newName,
            colorCodes: colors.take(3).map((c) => c.newCode).toList(),
          ),
        );
        await source.savedPalettes.save(
          palette(id: 'existing', brandId: other.id),
        );
        await source.history.record(
          pick(brandId: brand.id, matchedCode: color.newCode),
        );
        final exported = source.backup().exportJson();
        final target = await harness();
        await target.backup().importJson(exported);
        expect(target.backup().exportJson(), exported);
        expect(target.appSettings.brand, brand);
        expect(target.appSettings.settings.extraMarkerIds, {
          color.colorId,
          'decotime:01',
        });
        expect(target.appSettings.favorites, {color.colorId});
        expect(target.ownColors.hexOf(color.colorId), 'abcdef');
        expect(target.savedPalettes.palettesOf(brand).single.brandId, brand.id);
        expect(target.savedPalettes.palettesOf(other).single.id, 'existing');
        expect(target.history.entries.single.brandId, brand.id);
      },
    );
  }
}
