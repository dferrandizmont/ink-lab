part of 'palette_page.dart';

/// Palettes as text and the other views of the palette on screen: "Share as
/// text", "Import from text" and Easel mode.
extension _PaletteTextFlow on _PalettePageState {
  /// Most unknown codes named in a message; the rest is "…".
  static const int _maxNamedCodes = 6;

  /// Shares the palette on screen as text: a readable list and, as the last
  /// line, the compact line [PaletteText] reads back.
  Future<void> _sharePaletteText() async {
    final List<SharedPaletteColor> colors = _sharedColors();
    if (_sharing || colors.isEmpty) return;
    final String header = context.l10n.paletteTextHeader(
      _brand.label,
      _shareTitle,
    );
    final String text = paletteShareText(
      header: header,
      brand: _brand,
      colors: colors,
    );
    await _runShare(() => _share.shareText(text, subject: header));
  }

  /// Opens the sheet that reads a palette from pasted text.
  Future<void> _openImport() => showInkSheet<void>(
    context: context,
    builder: (BuildContext context) =>
        PaletteImportSheet(onImport: _importFromText),
  );

  /// Loads the palette in [text] as a custom palette and says so, or returns
  /// why it cannot (the sheet shows it). Codes the catalogue does not know
  /// are named in the notice.
  String? _importFromText(String text) {
    final AppLocalizations t = context.l10n;
    final Map<String, MarkerColor> byCode = <String, MarkerColor>{
      for (final MarkerColor color in _catalog)
        color.newCode.toUpperCase(): color,
    };
    final PaletteTextImport found = PaletteText.parse(
      text,
      knownCodes: byCode.keys.toSet(),
    );
    if (found.isEmpty) return t.paletteImportNothing;
    final String? brandId = found.brandId;
    if (brandId != null && brandId != _brand.id) {
      return t.paletteImportOtherBrand(
        MarkerBrand.byId[brandId]?.label ?? brandId,
      );
    }
    final List<MarkerColor> known = <MarkerColor>[];
    final List<String> unknown = <String>[];
    final Set<String> seen = <String>{};
    for (final String code in found.codes) {
      final MarkerColor? color = byCode[code.toUpperCase()];
      if (color == null) {
        unknown.add(code);
      } else if (seen.add(color.colorId)) {
        known.add(color);
      }
    }
    final String unknownText = unknown.length > _maxNamedCodes
        ? '${unknown.take(_maxNamedCodes).join(', ')}…'
        : unknown.join(', ');
    if (known.isEmpty) {
      return t.paletteImportNoneKnown(_brand.label, unknownText);
    }
    // Loaded the way a saved custom palette is: the first marker is the base
    // of the strip, the rest follow it.
    _loadSaved(
      SavedPalette(
        id: 'import',
        brandId: _brand.id,
        name: t.paletteImportTitle,
        baseCode: known.first.newCode,
        baseName: known.first.newName,
        mode: PaletteMode.customPalette,
        paletteSize: known.length.clamp(3, 5),
        createdAtEpochMs: DateTime.now().millisecondsSinceEpoch,
        colorCodes: <String>[for (final MarkerColor c in known) c.newCode],
        isCustom: true,
      ),
    );
    // What the notice says adds up: the markers loaded, then the codes that
    // were not (unknown to the brand) or were counted once (repeated).
    final String notice = <String>[
      t.paletteImportDone(known.length),
      if (unknown.isNotEmpty) t.paletteImportUnknown(unknownText),
      if (found.repeated > 0) t.paletteImportRepeated,
    ].join(' ');
    _setState(() => _notice = notice);
    return null;
  }

  /// Opens Easel mode: the palette on screen as large swatches, with the
  /// screen kept awake.
  Future<void> _openEasel() {
    final List<EaselColor> colors = <EaselColor>[
      for (final SharedPaletteColor item in _sharedColors())
        (
          code: item.color.newCode,
          name: item.color.newName,
          role: item.role ?? '',
          hex: item.color.hex,
        ),
    ];
    return PaletteEaselPage.open(
      context,
      colors: colors,
      vision: _vision,
      values: _values,
      awake: widget.screenAwake,
    );
  }
}
