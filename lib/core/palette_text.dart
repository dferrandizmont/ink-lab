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
// The compact line (version 1) is
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

  /// Whether they came from the compact `inklab:palette:v1:` line.
  final bool compact;

  /// The brand the compact line names, lower case; `null` without one.
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

  /// The version of the compact line this app writes and reads.
  static const int version = 1;

  /// The most markers one palette read from text may hold.
  static const int maxColors = 12;

  /// The most characters of a text that are read; the rest is ignored. A
  /// palette of twelve markers is under 300, so this is generous, and it keeps
  /// reading a pasted wall of text instant.
  static const int maxLength = 4096;

  /// The longest word looked at as a code. A longer one is never a code.
  static const int maxCodeLength = 64;

  /// The text separator of the readable lines.
  static const String separator = ' · ';

  /// The compact line for [codes] of the brand [brandId].
  static String compactLine({
    required String brandId,
    required List<String> codes,
  }) =>
      '$scheme:v$version:${brandId.toLowerCase()}:'
      '${codes.map(Uri.encodeComponent).join(',')}';

  /// The whole message: [header], one `code · name · role` line per marker
  /// (`code · name` without a role), a blank line and the compact line.
  static String format({
    required String header,
    required String brandId,
    required List<PaletteTextLine> lines,
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
        compactLine(
          brandId: brandId,
          codes: <String>[for (final PaletteTextLine l in lines) l.code],
        ),
      );
    return out.toString();
  }

  static final RegExp _compact = RegExp(
    '${RegExp.escape(scheme)}:v(\\d+):([a-z0-9_]+):([^\\r\\n]*)',
    caseSensitive: false,
  );
  static final RegExp _listNumber = RegExp(r'^\d+[.)]$');
  static final RegExp _codeLike = RegExp(r'^[A-Za-z0-9][A-Za-z0-9.\-]*$');
  static final RegExp _separators = RegExp(r'[\s,;|]+');
  static final RegExp _lines = RegExp(r'\r\n|\r|\n');

  /// Reads the palette in [text].
  ///
  /// 1. A compact version 1 line anywhere in the text wins: its brand and its
  ///    codes are taken as written. A line of another version is skipped.
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
    if (text.length > maxLength) text = text.substring(0, maxLength);
    for (final RegExpMatch match in _compact.allMatches(text)) {
      if (int.tryParse(match.group(1)!) != version) continue;
      final List<String> codes = <String>[];
      for (final String raw in match.group(3)!.split(',')) {
        if (raw.length > maxCodeLength) continue;
        final String code = _decode(_trimEnd(raw.trim()));
        if (code.isNotEmpty) codes.add(code);
      }
      if (codes.isEmpty) continue;
      final (List<String> distinct, int repeated) = _distinct(codes);
      return PaletteTextImport(
        codes: distinct,
        compact: true,
        brandId: match.group(2)!.toLowerCase(),
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
