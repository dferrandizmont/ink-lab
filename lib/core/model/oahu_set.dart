import '../json_value.dart';
import 'marker_line.dart';

/// Where the existence of a pack is documented.
enum SetSource {
  /// Named on Ohuhu's own colour-codes index page.
  official,

  /// Known only from the community "Ohuhu Legend" spreadsheet (older packs,
  /// regional or white-case editions, packs not on the official page).
  /// The UI should present these as "older / community data".
  community,
}

/// An Ohuhu pack. Historically only Oahu packs existed, hence the name; the
/// enum now covers every line (see [line]). Ids of the original twelve Oahu
/// packs are persisted in settings, saved palettes and backups: never rename
/// them.
///
/// [colorCount] is the count named by the pack ("Oahu 160" = 160 markers).
/// [includesBlender] adds the colourless blender (code 0), which the Oahu
/// classic packs ship on top of the named count. The generator and the data
/// quality tests both enforce `members == expectedMemberCount`.
enum OahuSet {
  classic40('classic_40', '40', colorCount: 40, includesBlender: true),
  classic60('classic_60', '60', colorCount: 60, includesBlender: true),
  classic80('classic_80', '80', colorCount: 80, includesBlender: true),
  classic100('classic_100', '100', colorCount: 100, includesBlender: true),
  classic120('classic_120', '120', colorCount: 120, includesBlender: true),
  classic160('classic_160', '160', colorCount: 160, includesBlender: true),
  classic200('classic_200', '200', colorCount: 200, includesBlender: true),
  new120('new_120', '120 New', colorCount: 120, includesBlender: true),
  classic320('classic_320', '320', colorCount: 320, includesBlender: true),
  skin36('skin_36', '36 Skin', colorCount: 36, isCore: false),
  gray36('gray_36', '36 Gray', colorCount: 36, isCore: false),
  pastel48('pastel_48', '48 Pastel', colorCount: 48, isCore: false),
  basic6(
    'basic_6',
    '6 Basic',
    colorCount: 6,
    isCore: false,
    source: SetSource.community,
    isLegacy: true,
  ),
  pastel6(
    'pastel_6',
    '6 Pastel',
    colorCount: 6,
    isCore: false,
    source: SetSource.community,
    isLegacy: true,
  ),
  skin6(
    'skin_6',
    '6 Skin',
    colorCount: 6,
    isCore: false,
    source: SetSource.community,
    isLegacy: true,
  ),
  white24(
    'white_24',
    'White Case 24',
    colorCount: 24,
    source: SetSource.community,
    isLegacy: true,
  ),
  white48(
    'white_48',
    'White Case 48',
    colorCount: 48,
    source: SetSource.community,
    isLegacy: true,
  ),
  white72(
    'white_72',
    'White Case 72',
    colorCount: 72,
    source: SetSource.community,
    isLegacy: true,
  ),
  white128(
    'white_128',
    'White Case 128',
    colorCount: 128,
    source: SetSource.community,
    isLegacy: true,
  ),
  white200(
    'white_200',
    'White Case 200',
    colorCount: 200,
    source: SetSource.community,
    isLegacy: true,
  ),
  honolulu24('honolulu_24', '24', colorCount: 24, line: MarkerLine.honolulu),
  honolulu48('honolulu_48', '48', colorCount: 48, line: MarkerLine.honolulu),
  honolulu72('honolulu_72', '72', colorCount: 72, line: MarkerLine.honolulu),
  honolulu104(
    'honolulu_104',
    '104',
    colorCount: 104,
    line: MarkerLine.honolulu,
  ),
  honolulu120(
    'honolulu_120',
    '120',
    colorCount: 120,
    line: MarkerLine.honolulu,
  ),
  honolulu168(
    'honolulu_168',
    '168',
    colorCount: 168,
    line: MarkerLine.honolulu,
  ),
  honolulu216(
    'honolulu_216',
    '216',
    colorCount: 216,
    line: MarkerLine.honolulu,
  ),
  honolulu320(
    'honolulu_320',
    '320',
    colorCount: 320,
    line: MarkerLine.honolulu,
  ),
  honoluluPastelSweet48(
    'honolulu_pastel_sweet_48',
    '48 Sweetness Pastels',
    colorCount: 48,
    line: MarkerLine.honolulu,
    isCore: false,
    source: SetSource.community,
  ),
  honoluluMidtones48(
    'honolulu_midtones_48',
    '48 Mid-Tones',
    colorCount: 48,
    line: MarkerLine.honolulu,
    isCore: false,
  ),
  honoluluPastelBlossom48(
    'honolulu_pastel_blossom_48',
    '48 Blossoming Pastels',
    colorCount: 48,
    line: MarkerLine.honolulu,
    isCore: false,
    source: SetSource.community,
  ),
  honoluluPastel96(
    'honolulu_pastel_96',
    '96 Pastels',
    colorCount: 96,
    line: MarkerLine.honolulu,
    isCore: false,
  ),
  honoluluSkin24(
    'honolulu_skin_24',
    '24 Skin',
    colorCount: 24,
    line: MarkerLine.honolulu,
    isCore: false,
  ),
  honoluluSkin36(
    'honolulu_skin_36',
    '36 Skin',
    colorCount: 36,
    line: MarkerLine.honolulu,
    isCore: false,
  ),
  honoluluGray36(
    'honolulu_gray_36',
    '36 Gray',
    colorCount: 36,
    line: MarkerLine.honolulu,
    isCore: false,
  ),
  honoluluJapan80V1(
    'honolulu_japan_80_v1',
    'Japan 80 (V1)',
    colorCount: 80,
    line: MarkerLine.honolulu,
    source: SetSource.community,
    isLegacy: true,
  ),
  honoluluJapan80V2(
    'honolulu_japan_80_v2',
    'Japan 80 (V2)',
    colorCount: 80,
    line: MarkerLine.honolulu,
    source: SetSource.community,
    isLegacy: true,
  ),
  honoluluWhite24V1(
    'honolulu_white_24_v1',
    'White Case 24 (V1)',
    colorCount: 24,
    line: MarkerLine.honolulu,
    source: SetSource.community,
    isLegacy: true,
  ),
  honoluluWhite24V2(
    'honolulu_white_24_v2',
    'White Case 24 (V2)',
    colorCount: 24,
    line: MarkerLine.honolulu,
    source: SetSource.community,
    isLegacy: true,
  ),
  honoluluWhite40(
    'honolulu_white_40',
    'White Case 40',
    colorCount: 40,
    line: MarkerLine.honolulu,
    source: SetSource.community,
    isLegacy: true,
  ),
  honoluluWhite80V1(
    'honolulu_white_80_v1',
    'White Case 80 (V1)',
    colorCount: 80,
    line: MarkerLine.honolulu,
    source: SetSource.community,
    isLegacy: true,
  ),
  honoluluWhite80V2(
    'honolulu_white_80_v2',
    'White Case 80 (V2)',
    colorCount: 80,
    line: MarkerLine.honolulu,
    source: SetSource.community,
    isLegacy: true,
  ),
  honoluluWhite120V1(
    'honolulu_white_120_v1',
    'White Case 120 (V1)',
    colorCount: 120,
    line: MarkerLine.honolulu,
    source: SetSource.community,
    isLegacy: true,
  ),
  honoluluWhite120V2(
    'honolulu_white_120_v2',
    'White Case 120 (V2)',
    colorCount: 120,
    line: MarkerLine.honolulu,
    source: SetSource.community,
    isLegacy: true,
  ),
  honoluluWhite200V1(
    'honolulu_white_200_v1',
    'White Case 200 (V1)',
    colorCount: 200,
    line: MarkerLine.honolulu,
    source: SetSource.community,
    isLegacy: true,
  ),
  honoluluWhite200V2(
    'honolulu_white_200_v2',
    'White Case 200 (V2)',
    colorCount: 200,
    line: MarkerLine.honolulu,
    source: SetSource.community,
    isLegacy: true,
  ),
  kaalaBasic24(
    'kaala_basic_24',
    '24 Basic',
    colorCount: 24,
    line: MarkerLine.kaala,
  ),
  kaalaSkin24(
    'kaala_skin_24',
    '24 Skin',
    colorCount: 24,
    line: MarkerLine.kaala,
    isCore: false,
  ),
  kaalaIllustration60(
    'kaala_illustration_60',
    '60 Illustration',
    colorCount: 60,
    line: MarkerLine.kaala,
  ),
  kaalaLandscape60(
    'kaala_landscape_60',
    '60 Landscape',
    colorCount: 60,
    line: MarkerLine.kaala,
  ),
  kaalaPastel60(
    'kaala_pastel_60',
    '60 Pastels',
    colorCount: 60,
    line: MarkerLine.kaala,
    isCore: false,
    source: SetSource.community,
  ),
  kaalaBasic108(
    'kaala_basic_108',
    '108 Basic',
    colorCount: 108,
    line: MarkerLine.kaala,
    source: SetSource.community,
  );

  const OahuSet(
    this.id,
    this.label, {
    required this.colorCount,
    this.line = MarkerLine.oahu,
    this.isCore = true,
    this.source = SetSource.official,
    this.isLegacy = false,
    this.includesBlender = false,
  });
  final String id;

  /// Short label, unique inside its [line] (e.g. "160", "White Case 24").
  final String label;
  final int colorCount;
  final MarkerLine line;
  final bool isCore;
  final SetSource source;

  /// Older edition (white cases, V1 boxes, 6 packs): show with a muted
  /// "older / community data" hint.
  final bool isLegacy;
  final bool includesBlender;

  /// Number of colours the catalog must list for this pack.
  int get expectedMemberCount => colorCount + (includesBlender ? 1 : 0);
  bool get isCommunity => source == SetSource.community;

  /// Label including the line, e.g. "Honolulu 48" or "Oahu 160".
  String get fullLabel => '${line.label} $label';

  static final Map<String, OahuSet> byId = {
    for (final value in values) value.id: value,
  };

  /// Packs of one line, in declaration order.
  static List<OahuSet> forLine(MarkerLine line) =>
      List.unmodifiable(values.where((set) => set.line == line));

  String toJson() => enumJson(this);
  static OahuSet fromJson(Object? json) => decodeEnum(values, json);
}

/// Ohuhu packs now span several lines; this alias reads better at new call
/// sites while `OahuSet` stays valid for existing ones.
typedef OhuhuSet = OahuSet;
