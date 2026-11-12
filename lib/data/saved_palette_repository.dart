import 'dart:async';
import 'dart:convert';

import '../core/models.dart';
import 'data_exceptions.dart';
import 'key_value_store.dart';
import 'replay_stream.dart';

/// Saved palettes, scoped by brand.
///
/// Each brand keeps its own list, newest first. A palette is de-duplicated by
/// id and by its content signature (name, base, mode, size and codes), then the
/// list is capped at [SavedPaletteRepository.maxPerBrand] entries with the
/// oldest dropped.
///
/// A palette is stored once, under its `brandId` (the brand in use when it
/// was saved). One that mixes brands is still *listed* under every brand it
/// holds a marker of ([listedFor]), so it does not vanish when the user
/// changes brand; [delete] takes the brand it is stored under.
abstract class SavedPaletteRepository {
  /// Kotlin kept a bounded history; the cap and the de-duplication rule are
  /// re-stated here as named constants so they are easy to audit and adjust.
  static const int maxPerBrand = 100;

  List<SavedPalette> palettesOf(MarkerBrand brand);

  /// Emits the brand's current list, then every change to that brand.
  Stream<List<SavedPalette>> watch(MarkerBrand brand);

  /// The palettes a list of [brand] shows, newest first: the ones stored
  /// under it and the ones stored under another brand that hold one of its
  /// markers (a palette saved with "Mix my brands"). Each palette once.
  List<SavedPalette> listedFor(MarkerBrand brand);

  /// Emits [listedFor] now, then after every change to any brand.
  Stream<List<SavedPalette>> watchListed(MarkerBrand brand);

  /// Every stored palette, of every brand.
  Iterable<SavedPalette> get all;

  /// Emits after every change to the palettes of any brand.
  Stream<void> get changes;

  Future<void> load();
  Future<void> save(SavedPalette palette);
  Future<void> delete(MarkerBrand brand, String id);
  Future<void> clearBrand(MarkerBrand brand);

  /// All brands that currently hold at least one palette, keyed by brand id.
  Map<String, List<SavedPalette>> exportByBrand();

  /// Replaces the stored palettes for every brand, as a backup restore does.
  Future<void> restore(Map<String, List<SavedPalette>> byBrandId);
}

/// [SavedPaletteRepository] on top of a [KeyValueStore].
///
/// One key per brand: `saved_palettes:<brandId>`, holding the JSON array of
/// [SavedPalette] objects produced by `SavedPalette.toJson` (the Kotlin field
/// names).
final class StoredSavedPaletteRepository implements SavedPaletteRepository {
  StoredSavedPaletteRepository(this._store);

  static String keyFor(MarkerBrand brand) => 'saved_palettes:${brand.id}';

  final KeyValueStore _store;
  final StreamController<MarkerBrand> _brands =
      StreamController<MarkerBrand>.broadcast();
  final Map<MarkerBrand, List<SavedPalette>> _byBrand = {};

  @override
  List<SavedPalette> palettesOf(MarkerBrand brand) =>
      _byBrand[brand] ?? const [];

  @override
  Stream<List<SavedPalette>> watch(MarkerBrand brand) =>
      replayStream<List<SavedPalette>>(
        () => palettesOf(brand),
        _brands.stream
            .where((changed) => changed == brand)
            .map((_) => palettesOf(brand)),
      );

  @override
  List<SavedPalette> listedFor(MarkerBrand brand) {
    final List<SavedPalette> own = palettesOf(brand);
    final List<SavedPalette> others = <SavedPalette>[
      for (final MarkerBrand other in MarkerBrand.values)
        if (other != brand)
          for (final SavedPalette palette in palettesOf(other))
            if (palette.brandIds.contains(brand.id)) palette,
    ];
    if (others.isEmpty) return own;
    final Set<String> ids = <String>{};
    final List<SavedPalette> listed = <SavedPalette>[
      for (final SavedPalette palette in <SavedPalette>[...own, ...others])
        if (palette.id.isEmpty || ids.add(palette.id)) palette,
    ];
    // Newest first, like each brand's own list; a stable sort keeps the
    // stored order of palettes saved at the same instant.
    final List<int> order = <int>[for (int i = 0; i < listed.length; i++) i]
      ..sort((int a, int b) {
        final int byDate = listed[b].createdAtEpochMs.compareTo(
          listed[a].createdAtEpochMs,
        );
        return byDate != 0 ? byDate : a.compareTo(b);
      });
    return List<SavedPalette>.unmodifiable(<SavedPalette>[
      for (final int i in order) listed[i],
    ]);
  }

  @override
  Stream<List<SavedPalette>> watchListed(MarkerBrand brand) =>
      replayStream<List<SavedPalette>>(
        () => listedFor(brand),
        _brands.stream.map((_) => listedFor(brand)),
      );

  @override
  Iterable<SavedPalette> get all sync* {
    for (final MarkerBrand brand in MarkerBrand.values) {
      yield* palettesOf(brand);
    }
  }

  @override
  Stream<void> get changes => _brands.stream.map<void>((_) {});

  @override
  Future<void> load() async {
    for (final brand in MarkerBrand.values) {
      _byBrand[brand] = _decode(
        await _store.getString(keyFor(brand)),
        keyFor(brand),
      );
    }
  }

  @override
  Future<void> save(SavedPalette palette) async {
    final brand = MarkerBrand.fromId(palette.brandId);
    final next = [palette, ...palettesOf(brand)];
    await _storePalettes(brand, next);
  }

  @override
  Future<void> delete(MarkerBrand brand, String id) async {
    final next = palettesOf(brand).where((p) => p.id != id).toList();
    if (next.length == palettesOf(brand).length) return;
    await _storePalettes(brand, next);
  }

  @override
  Future<void> clearBrand(MarkerBrand brand) async {
    await _storePalettes(brand, const []);
  }

  @override
  Map<String, List<SavedPalette>> exportByBrand() => {
    for (final brand in MarkerBrand.values)
      if (palettesOf(brand).isNotEmpty) brand.id: palettesOf(brand),
  };

  @override
  Future<void> restore(Map<String, List<SavedPalette>> byBrandId) async {
    for (final brand in MarkerBrand.values) {
      final source = byBrandId[brand.id] ?? byBrandId[brand.id.toLowerCase()];
      await _storePalettes(brand, source ?? const []);
    }
  }

  Future<void> _storePalettes(
    MarkerBrand brand,
    List<SavedPalette> palettes,
  ) async {
    final normalized = _normalize(palettes);
    _byBrand[brand] = normalized;
    await _store.setString(
      keyFor(brand),
      jsonEncode(normalized.map((p) => p.toJson()).toList()),
    );
    _brands.add(brand);
  }

  List<SavedPalette> _normalize(List<SavedPalette> palettes) {
    final byId = <String>{};
    final bySignature = <String>{};
    final result = <SavedPalette>[];
    for (final palette in palettes) {
      if (palette.id.isNotEmpty && !byId.add(palette.id)) continue;
      if (!bySignature.add(_signature(palette))) continue;
      result.add(palette);
      if (result.length == SavedPaletteRepository.maxPerBrand) break;
    }
    return List.unmodifiable(result);
  }

  String _signature(SavedPalette palette) => [
    palette.brandId,
    palette.name,
    palette.baseCode,
    palette.mode.toJson(),
    palette.paletteSize,
    palette.colorCodes.join(','),
  ].join('|');

  List<SavedPalette> _decode(String? raw, String key) {
    if (raw == null || raw.trim().isEmpty) return const [];
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) {
        throw DataStoreException('expected a JSON array of palettes', key: key);
      }
      return List.unmodifiable(
        decoded.map(
          (item) =>
              SavedPalette.fromJson((item as Map).cast<String, dynamic>()),
        ),
      );
    } on DataStoreException {
      rethrow;
    } catch (error) {
      throw DataStoreException(
        'could not parse saved palettes: $error',
        key: key,
      );
    }
  }
}
