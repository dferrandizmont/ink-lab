// A palette as text, and back.
//
// "Share as text" writes a short human-readable message and, as its last
// line, one compact line the app itself can read back:
//
//   Ink Lab palette · DecoTime · Recommended
//   03 · Soft Rose · Base
//   05 · Dusty Plum · Shadow
//   12 · Ivory · Highlight
//
//   inklab:palette:v1:decotime:03,05,12
//
// The compact line of a palette of one brand (version 1) is
//
//   inklab:palette:v1:<brand id>:<code>,<code>,...
//
// * `inklab:palette` is the fixed scheme and `v1` the format version.
// * `<brand id>` is `MarkerBrand.id` (`ohuhu_oahu`, `decotime`, `copic`,
//   `finecolour`), lower case.
// * the codes are the markers' new codes in palette order (the base first),
//   each percent-encoded with `Uri.encodeComponent` (so `,` and `:` can never
//   split a code), separated by commas. Nothing else is on the line.
//
// A palette that mixes brands ("Mix my brands") writes version 2, where every
// marker carries its own brand:
//
//   inklab:palette:v2:<brand id>:<code>,<brand id>:<code>,...
//
//   inklab:palette:v2:ohuhu_oahu:BV04,decotime:91
//
// The brand ids are written as they are (`[a-z0-9_]`), each code is
// percent-encoded on its own, and the first `:` of an item splits brand from
// code. A palette of one brand keeps writing version 1, so an older app
// still reads it.
//
// Reading is bounded: at most [PaletteText.maxLength] characters of the text
// are looked at, in one pass (the patterns have no nested repetition and the
// trimming helpers walk each end once), a code longer than
// [PaletteText.maxCodeLength] or a brand id longer than
// [PaletteText.maxBrandLength] is dropped and a palette holds at most
// [PaletteText.maxColors] markers. A text longer than the limit is cut at
// the last separator before it, so a code cut in half is never read as
// another one. Whatever is read is only text: the caller checks every code
// against a catalogue. A code that holds a control or a text-direction
// character is dropped (it would be shown back in a message), and
// [PaletteText.echo] shortens a code for such a message.
//
// Reading is tolerant (see [PaletteText.parse]): the compact line may sit
// anywhere in the pasted text, in any letter case, with spaces after the
// commas. Without it, the readable lines (`code · name · role`) or a plain
// list of codes (commas, spaces or one per line) are read instead.

/// One marker of a palette as a line of the readable text.
typedef PaletteTextLine = ({String code, String name, String? role});

/// What was found in a pasted text.
final class PaletteTextImport {
  const PaletteTextImport({
    required this.codes,
    required this.compact,
    this.brandId,
    this.repeated = 0,
  });

  /// The codes in the order they were written, without repeats (a repeat
  /// differing only in letter case counts as one), at most
  /// [PaletteText.maxColors].
  ///
  /// They are what the text says: the caller checks them against a catalogue.
  final List<String> codes;

  /// Whether they came from a compact line (`inklab:palette:v1:` or `v2:`).
  final bool compact;

  /// The brand a version 1 line names, lower case; `null` without one. A
  /// version 2 line names no single brand: each of its [codes] is a colour id
  /// (`decotime:91`), brand first.
  final String? brandId;

  /// How many codes were left out because the text named them more than once
  /// (a repeat differing only in letter case included).
  final int repeated;

  bool get isEmpty => codes.isEmpty;
}

/// The format of a palette written as text; see the library comment.
abstract final class PaletteText {
  /// The fixed start of the compact line.
  static const String scheme = 'inklab:palette';

  /// The version of the compact line of a palette of one brand.
  static const int version = 1;

  /// The version of the compact line of a palette that mixes brands.
  static const int mixedVersion = 2;

  /// The most markers one palette read from text may hold.
  static const int maxColors = 12;

  /// The most characters of a text that are read; the rest is ignored. A
  /// palette of twelve markers is under 300, so this is generous, and it keeps
  /// reading a pasted wall of text instant.
  static const int maxLength = 4096;

  /// The longest word looked at as a code. A longer one is never a code.
  static const int maxCodeLength = 64;

  /// The longest brand id read (the longest real one has 15 characters).
  static const int maxBrandLength = 24;

  /// The most characters of a code shown back to the user (see [echo]).
  static const int maxEchoLength = 16;

  /// [code] as a message may show it: codes are short, so anything past
  /// [maxEchoLength] characters is cut and marked with an ellipsis.
  static String echo(String code) => code.length > maxEchoLength
      ? '${code.substring(0, maxEchoLength)}…'
      : code;

  /// The text separator of the readable lines.
  static const String separator = ' · ';

  /// The compact line for [codes] of the brand [brandId].
  static String compactLine({
    required String brandId,
    required List<String> codes,
  }) =>
      '$scheme:v$version:${brandId.toLowerCase()}:'
      '${codes.map(Uri.encodeComponent).join(',')}';

  /// The compact line of a palette that mixes brands: every item of
  /// [colorIds] is `brandId:CODE`.
  static String compactMixedLine(List<String> colorIds) {
    final List<String> items = <String>[
      for (final String id in colorIds)
        if (id.indexOf(':') case final int colon when colon > 0)
          '${id.substring(0, colon).toLowerCase()}:'
              '${Uri.encodeComponent(id.substring(colon + 1))}'
        else
          throw ArgumentError.value(id, 'colorIds', 'not a brandId:CODE id'),
    ];
    return '$scheme:v$mixedVersion:${items.join(',')}';
  }

  /// The whole message: [header], one `code · name · role` line per marker
  /// (`code · name` without a role), a blank line and the compact line.
  ///
  /// The compact line is version 2 when [colorIds] is given (a palette that
  /// mixes brands), else version 1 for [brandId] with [compactCodes] (the
  /// codes of [lines] when omitted: a readable line may show the brand in
  /// front of its code, which the compact line must not carry).
  static String format({
    required String header,
    required String brandId,
    required List<PaletteTextLine> lines,
    List<String>? colorIds,
    List<String>? compactCodes,
  }) {
    final StringBuffer out = StringBuffer(header);
    for (final PaletteTextLine line in lines) {
      out.write('\n${line.code}$separator${line.name}');
      final String? role = line.role?.trim();
      if (role != null && role.isNotEmpty) out.write('$separator$role');
    }
    out
      ..write('\n\n')
      ..write(
        colorIds != null
            ? compactMixedLine(colorIds)
            : compactLine(
                brandId: brandId,
                codes:
                    compactCodes ??
                    <String>[for (final PaletteTextLine l in lines) l.code],
              ),
      );
    return out.toString();
  }

  static final RegExp _compact = RegExp(
    '${RegExp.escape(scheme)}:v(\\d+):([^\\r\\n]*)',
    caseSensitive: false,
  );
  static final RegExp _brandId = RegExp(r'^[a-z0-9_]+$', caseSensitive: false);
  static final RegExp _listNumber = RegExp(r'^\d+[.)]$');
  static final RegExp _codeLike = RegExp(r'^[A-Za-z0-9][A-Za-z0-9.\-]*$');
  static final RegExp _separators = RegExp(r'[\s,;|]+');
  static final RegExp _lines = RegExp(r'\r\n|\r|\n');

  /// Reads the palette in [text].
  ///
  /// 1. A compact line anywhere in the text wins. A version 1 line gives its
  ///    brand and its codes as written; a version 2 line gives colour ids
  ///    (`decotime:91`), each with its own brand. A line of another version,
  ///    or an item that is not well formed, is skipped.
  /// 2. Otherwise the text is read line by line. A line of the readable form
  ///    (`03 · Name · role`) gives its first part, if that is one word (the
  ///    header line, with several, gives none). Any other line is a list of
  ///    codes separated by commas, semicolons, bars or spaces.
  ///
  /// In case 2 a word counts as a code when it is in [knownCodes] (upper
  /// case) or, failing that, looks like one: at most eight letters, digits,
  /// dots or hyphens with a digit among them. So "FB" is read when the
  /// catalogue has it, while "hello" is ignored; and "B99", which looks like a
  /// code but is in no catalogue, is read so the caller can report it.
  static PaletteTextImport parse(
    String text, {
    Set<String> knownCodes = const <String>{},
  }) {
    text = _bounded(text);
    for (final RegExpMatch match in _compact.allMatches(text)) {
      final int? found = int.tryParse(match.group(1)!);
      final String payload = match.group(2)!;
      String? brand;
      List<String> codes;
      if (found == version) {
        final int colon = payload.indexOf(':');
        if (colon <= 0) continue;
        brand = payload.substring(0, colon).toLowerCase();
        if (brand.length > maxBrandLength || !_brandId.hasMatch(brand)) {
          continue;
        }
        codes = <String>[
          for (final String raw in payload.substring(colon + 1).split(','))
            if (_compactCode(raw) case final String code) code,
        ];
      } else if (found == mixedVersion) {
        codes = <String>[
          for (final String raw in payload.split(','))
            if (_compactColorId(raw) case final String id) id,
        ];
      } else {
        continue;
      }
      if (codes.isEmpty) continue;
      final (List<String> distinct, int repeated) = _distinct(codes);
      return PaletteTextImport(
        codes: distinct,
        compact: true,
        brandId: brand,
        repeated: repeated,
      );
    }
    final List<String> codes = <String>[];
    for (final String rawLine in text.split(_lines)) {
      final String line = rawLine.trim();
      if (line.isEmpty) continue;
      if (line.toLowerCase().startsWith('$scheme:')) continue;
      if (line.contains('·')) {
        final String first = line.split('·').first.trim();
        if (!first.contains(RegExp(r'\s'))) {
          _addCandidate(codes, first, knownCodes);
        }
        continue;
      }
      for (final String word in line.split(_separators)) {
        _addCandidate(codes, word, knownCodes);
      }
    }
    final (List<String> distinct, int repeated) = _distinct(codes);
    return PaletteTextImport(
      codes: distinct,
      compact: false,
      repeated: repeated,
    );
  }

  /// At most [maxLength] characters of [text]. When the limit falls inside a
  /// word, the text is cut at the last separator (a space, a line break, a
  /// comma...) before it: half a code would read as another valid one. One
  /// backwards pass, linear in the length.
  static String _bounded(String text) {
    if (text.length <= maxLength) return text;
    int end = maxLength;
    if (_isSeparator(text.codeUnitAt(end))) return text.substring(0, end);
    while (end > 0 && !_isSeparator(text.codeUnitAt(end - 1))) {
      end--;
    }
    return text.substring(0, end);
  }

  static bool _isSeparator(int unit) =>
      unit == 0x20 || // space
      (unit >= 0x09 && unit <= 0x0D) || // tab and line breaks
      unit == 0x2C || // ,
      unit == 0x3B || // ;
      unit == 0x7C; // |

  /// The code in one item of a version 1 line, or `null` for none.
  static String? _compactCode(String raw) {
    if (raw.length > maxCodeLength) return null;
    final String code = _decode(_trimEnd(raw.trim()));
    return code.isEmpty || !_isPrintable(code) ? null : code;
  }

  /// The colour id (`brand:CODE`, brand in lower case) in one item of a
  /// version 2 line, or `null` when the item is not `<brand id>:<code>`.
  static String? _compactColorId(String raw) {
    if (raw.length > maxCodeLength * 2) return null;
    final String item = _trimEnd(raw.trim());
    final int colon = item.indexOf(':');
    if (colon <= 0) return null;
    final String brand = item.substring(0, colon);
    final String encoded = item.substring(colon + 1);
    if (brand.length > maxBrandLength ||
        !_brandId.hasMatch(brand) ||
        encoded.length > maxCodeLength) {
      return null;
    }
    final String code = _decode(encoded);
    return code.isEmpty || !_isPrintable(code)
        ? null
        : '${brand.toLowerCase()}:$code';
  }

  /// Whether [code] holds no control character and no invisible formatting
  /// or text-direction character: a decoded code is shown back to the user
  /// when the catalogue does not know it, and such a character could hide or
  /// reorder the message around it.
  ///
  /// No surrogate either: no marker code has a character outside the basic
  /// plane, a lone one is not text at all, and [echo] cuts by code unit, so
  /// it could leave half a pair behind.
  static bool _isPrintable(String code) {
    for (final int unit in code.codeUnits) {
      if (unit < 0x20 ||
          (unit >= 0x7F && unit <= 0x9F) ||
          unit == 0x061C || // Arabic letter mark
          (unit >= 0x200B && unit <= 0x200F) || // zero width, LRM, RLM
          (unit >= 0x2028 && unit <= 0x202E) || // separators, embeddings
          (unit >= 0x2060 && unit <= 0x206F) || // joiners, isolates
          (unit >= 0xD800 && unit <= 0xDFFF) || // surrogates
          unit == 0xFEFF) {
        return false;
      }
    }
    return true;
  }

  static void _addCandidate(
    List<String> codes,
    String word,
    Set<String> known,
  ) {
    if (word.length > maxCodeLength || _listNumber.hasMatch(word)) return;
    final String code = _trimEnds(word);
    if (code.isEmpty) return;
    if (known.contains(code.toUpperCase()) ||
        (code.length <= 8 &&
            _codeLike.hasMatch(code) &&
            code.contains(_digit))) {
      codes.add(code);
    }
  }

  static final RegExp _digit = RegExp(r'\d');

  /// [codes] without repeats, in order, at most [maxColors], and how many
  /// repeats were dropped before the limit was reached.
  static (List<String>, int) _distinct(List<String> codes) {
    final Set<String> seen = <String>{};
    final List<String> out = <String>[];
    int repeated = 0;
    for (final String code in codes) {
      if (!seen.add(code.toUpperCase())) {
        repeated++;
        continue;
      }
      out.add(code);
      if (out.length == maxColors) break;
    }
    return (out, repeated);
  }

  static String _decode(String code) {
    try {
      return Uri.decodeComponent(code);
    } catch (_) {
      return code;
    }
  }

  static bool _isAlnum(int unit) =>
      (unit >= 0x30 && unit <= 0x39) ||
      (unit >= 0x41 && unit <= 0x5A) ||
      (unit >= 0x61 && unit <= 0x7A);

  /// [text] without the punctuation a sentence may leave at its end (a `%`
  /// stays: it may start an escape). One pass, linear in the length.
  static String _trimEnd(String text) {
    int end = text.length;
    while (end > 0 &&
        !_isAlnum(text.codeUnitAt(end - 1)) &&
        text.codeUnitAt(end - 1) != 0x25) {
      end--;
    }
    return text.substring(0, end);
  }

  /// [text] without punctuation at either end ("(B08)", "B08,"). One pass at
  /// each end, linear in the length.
  static String _trimEnds(String text) {
    int start = 0;
    int end = text.length;
    while (start < end && !_isAlnum(text.codeUnitAt(start))) {
      start++;
    }
    while (end > start && !_isAlnum(text.codeUnitAt(end - 1))) {
      end--;
    }
    return text.substring(start, end);
  }
}
