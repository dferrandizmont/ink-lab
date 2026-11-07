import '../json_value.dart';
import 'marker_line.dart';

enum MarkerBrand {
  /// The Ohuhu brand. The constant and the stored id keep the historical
  /// "Oahu" spelling so colour ids (`ohuhu_oahu:BV04`), favourites, owned
  /// markers, saved palettes and backups keep working; the brand itself now
  /// covers the [MarkerLine]s Oahu, Honolulu and Kaala (`ohuhu_colors.json`).
  /// Its label is "Ohuhu": Oahu is one of its series, never the brand.
  ohuhuOahu('ohuhu_oahu', 'Ohuhu', 'ohuhu_colors.json', MarkerLine.values),
  decoTime('decotime', 'DecoTime', 'decotime_colors.json'),
  copic('copic', 'Copic', 'copic_colors.json'),
  finecolour('finecolour', 'Finecolour', 'finecolour_colors.json'),
  touchTwin('touch_twin', 'Touch Twin', 'touch_twin_colors.json'),
  promarker('promarker', 'Promarker', 'promarker_colors.json'),

  /// Winsor & Newton's Brushmarker range. It is its own brand, not a line of
  /// [promarker]: only 57 of its 72 codes exist in Promarker's 148 and eight of
  /// those share a code with a different name and colour.
  promarkerBrush(
    'promarker_brush',
    'Promarker Brush',
    'promarker_brush_colors.json',
  ),
  prismacolor('prismacolor', 'Prismacolor Premier', 'prismacolor_colors.json'),

  /// One brand for the whole Spectrum Noir ink-code system: its ranges are the
  /// lines `classic`, `illustrator` and `triblend` (see [productLines]).
  spectrumNoir('spectrum_noir', 'Spectrum Noir', 'spectrum_noir_colors.json'),

  /// Arrtx sells OROS and ALP, which share colour codes: lines `OROS`, `ALP`.
  arrtx('arrtx', 'Arrtx', 'arrtx_colors.json'),
  kurecolor('kurecolor', 'ZIG Kurecolor', 'kurecolor_colors.json'),
  graphit('graphit', "Graph'it", 'graphit_colors.json'),
  marvyLePlume(
    'marvy_le_plume',
    'Marvy Le Plume',
    'marvy_le_plume_colors.json',
  ),
  blickBrush('blick_brush', 'Blick Studio Brush', 'blick_brush_colors.json'),
  artistsLoft('artists_loft', "Artist's Loft", 'artists_loft_colors.json');

  const MarkerBrand(
    this.id,
    this.label,
    this.assetFile, [
    this.lines = const <MarkerLine>[],
  ]);
  final String id;
  final String label;
  final String assetFile;

  /// Selectable Ohuhu product lines (retail sets are per line). The line ids
  /// of every other brand are only metadata on its colours, see [productLines];
  /// ownership is selected marker by marker.
  final List<MarkerLine> lines;

  /// Every product line a colour of this brand can list in `lines`, with its
  /// label. Empty for brands that publish one range (DecoTime, Promarker...).
  /// The ids are stored in the catalogues, so they never change.
  List<BrandLine> get productLines => switch (this) {
    ohuhuOahu => <BrandLine>[
      for (final MarkerLine line in MarkerLine.values)
        BrandLine(line.id, line.label),
    ],
    copic => const <BrandLine>[
      BrandLine('sketch', 'Sketch'),
      BrandLine('ciao', 'Ciao'),
      BrandLine('classic', 'Classic'),
    ],
    finecolour => const <BrandLine>[
      BrandLine('EF100', 'EF100'),
      BrandLine('EF101', 'EF101'),
      BrandLine('EF102', 'EF102'),
      BrandLine('EF103', 'EF103'),
    ],
    touchTwin => const <BrandLine>[
      BrandLine('touchTwinMarker', 'Touch Twin Marker'),
      BrandLine('touchTwinBrush', 'Touch Twin Brush'),
    ],
    spectrumNoir => const <BrandLine>[
      BrandLine('classic', 'Classic'),
      BrandLine('illustrator', 'Illustrator'),
      BrandLine('triblend', 'TriBlend'),
    ],
    arrtx => const <BrandLine>[
      BrandLine('OROS', 'OROS'),
      BrandLine('ALP', 'ALP'),
    ],
    _ => const <BrandLine>[],
  };

  /// The names of the ranges of this brand a [colorLines] list puts a colour
  /// in, in the brand's order: "Sketch, Ciao", "Classic, Illustrator, TriBlend".
  /// Empty for the brands whose line ids are availability codes (Finecolour's
  /// EF100..EF103, Touch Twin's tips), which say nothing a person would read.
  List<String> rangeLabels(List<String> colorLines) {
    if (this == finecolour || this == touchTwin) return const <String>[];
    return <String>[
      for (final BrandLine line in productLines)
        if (colorLines.contains(line.id)) line.label,
    ];
  }

  /// Whether ownership can be selected through the catalogue's retail sets.
  /// Brands without these sets are collected one marker at a time.
  bool get hasRetailSets => this == ohuhuOahu;
  String get assetPath => 'assets/data/$assetFile';
  static final Map<String, MarkerBrand> byId = {
    for (final value in values) value.id: value,
  };
  static MarkerBrand fromId(String? raw) => byId[raw?.trim()] ?? ohuhuOahu;
  String toJson() => enumJson(this);
  static MarkerBrand fromJson(Object? json) => decodeEnum(values, json);
}

/// A product line of a brand as the catalogues list it in `lines`: a stable
/// [id] and a [label] that is a proper name, shown as it is in every language.
final class BrandLine {
  const BrandLine(this.id, this.label);
  final String id;
  final String label;
}

enum BrandScope {
  singleBrand('Single brand'),
  mixedBrands('Mixed brands');

  const BrandScope(this.label);
  final String label;
  String toJson() => enumJson(this);
  static BrandScope fromJson(Object? json) => decodeEnum(values, json);
}
