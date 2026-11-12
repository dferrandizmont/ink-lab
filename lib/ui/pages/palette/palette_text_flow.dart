part of 'palette_page.dart';

/// Id of the palette a pasted text is loaded as (it is never stored).
const String _importedPaletteId = 'import';

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
    // The header names the brand of the markers, or every brand of a mixed
    // palette ("Ohuhu + DecoTime").
    final String header = context.l10n.paletteTextHeader(
      paletteBrandsLabel(colors, fallback: _brand),
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

  /// Whether a pasted palette may bring markers of the brand [brandId]: the
  /// active brand or, with "Mix my brands", one of the brands in the mix.
  /// The same rule for the one brand of a version 1 line and for each marker
  /// of a version 2 line: pasted text never widens the brands in use.
  bool _importsBrand(String brandId) =>
      brandId == _brand.id ||
      (_scopeMixed && _available.any((MarkerColor c) => c.brandId == brandId));

  /// Loads the palette in [text] as a custom palette and says so, or returns
  /// why it cannot (the sheet shows it); an empty answer when the user chose
  /// to keep the palette they worked on (the sheet stays, with the text).
  /// Codes that were not loaded are named in the notice.
  ///
  /// A version 1 line names one brand, which must be one in use
  /// ([_importsBrand]). A version 2 line names the brand of every marker: the
  /// ones of a brand in use are loaded, the others are named as not loaded
  /// (and if that is all of them, the answer is that the palette is of
  /// another brand, as for version 1). Codes without a compact line are
  /// markers of the active brand (with "Mix my brands", also a code only one
  /// of the user's markers has).
  Future<String?> _importFromText(String text) async {
    final AppLocalizations t = context.l10n;
    // The range of the brands in use: nothing else is ever resolved.
    final Map<String, MarkerColor> byId = <String, MarkerColor>{
      for (final MarkerColor color in _catalog)
        color.colorId.toUpperCase(): color,
    };
    final PaletteTextImport found = PaletteText.parse(
      text,
      knownCodes: <String>{
        for (final MarkerColor c in _range)
          if (c.brandId == _brand.id) c.newCode.toUpperCase(),
        if (_scopeMixed)
          for (final MarkerColor c in _available) c.newCode.toUpperCase(),
      },
    );
    if (found.isEmpty) return t.paletteImportNothing;
    final String? lineBrand = found.brandId;
    if (lineBrand != null && !_importsBrand(lineBrand)) {
      return t.paletteImportOtherBrand(
        MarkerBrand.byId[lineBrand]?.label ?? PaletteText.echo(lineBrand),
      );
    }
    final String brandId = lineBrand ?? _brand.id;
    // A version 2 item is a colour id already (`decotime:91`).
    final bool scopedItems = found.compact && lineBrand == null;
    // The brands of the version 2 items left out because they are not in
    // use, in the order they came, and how many items that was.
    final Set<String> otherBrands = <String>{};
    int ofOtherBrands = 0;
    MarkerColor? resolve(String code) {
      if (scopedItems) {
        final String itemBrand = code.substring(0, code.indexOf(':'));
        if (!_importsBrand(itemBrand)) {
          otherBrands.add(itemBrand);
          ofOtherBrands++;
          return null;
        }
        return byId[code.toUpperCase()];
      }
      final MarkerColor? own = byId['$brandId:$code'.toUpperCase()];
      if (own != null || found.compact || !_scopeMixed) return own;
      return resolveBaseColor(code, _available);
    }

    // A code that was not loaded, as the notice names it: cut to a few
    // characters (it is whatever the text said), and a version 2 item with
    // the name of its brand when the app knows it.
    String named(String code) {
      final int colon = scopedItems ? code.indexOf(':') : -1;
      final MarkerBrand? brand = colon > 0
          ? MarkerBrand.byId[code.substring(0, colon)]
          : null;
      return brand == null
          ? PaletteText.echo(code)
          : '${brand.label} ${PaletteText.echo(code.substring(colon + 1))}';
    }

    final List<MarkerColor> known = <MarkerColor>[];
    final List<String> unknown = <String>[];
    final Set<String> seen = <String>{};
    for (final String code in found.codes) {
      final MarkerColor? color = resolve(code);
      if (color == null) {
        unknown.add(named(code));
      } else if (seen.add(color.colorId)) {
        known.add(color);
      }
    }
    final String unknownText = unknown.length > _maxNamedCodes
        ? '${unknown.take(_maxNamedCodes).join(', ')}…'
        : unknown.join(', ');
    if (known.isEmpty) {
      // Every marker is of a brand that is not in use: the palette is of
      // another brand, as a version 1 line of that brand would be.
      if (ofOtherBrands == found.codes.length) {
        return t.paletteImportOtherBrand(
          otherBrands
              .map(
                (String id) =>
                    MarkerBrand.byId[id]?.label ?? PaletteText.echo(id),
              )
              .join(' + '),
        );
      }
      // The brand the codes were read as. With one brand in use it is that
      // brand, as always. With "Mix my brands" it is the brand of a version
      // 1 line or the one every item of a version 2 line names; a version 2
      // line of several brands, or a plain list (read as a marker of any of
      // the user's brands), has no single brand to name: "not an Ohuhu
      // marker" would be false for the others.
      final Set<String> readAs = !_scopeMixed
          ? <String>{brandId}
          : scopedItems
          ? <String>{
              for (final String code in found.codes)
                code.substring(0, code.indexOf(':')),
            }
          : <String>{?lineBrand};
      if (readAs.length != 1) return t.paletteImportNoneKnownMixed(unknownText);
      return t.paletteImportNoneKnown(
        MarkerBrand.byId[readAs.single]?.label ??
            PaletteText.echo(readAs.single),
        unknownText,
      );
    }
    // What the notice says adds up: the markers loaded, then the codes that
    // were not (unknown, or of a brand that is not in use) or were counted
    // once (repeated).
    // The result needs a base and a companion, as saved palettes do. Reject
    // before replacing anything rather than claiming an invisible import.
    if (known.length < 2) return t.paletteImportTooFew;
    final _PaletteNotice notice = _PaletteNotice(
      _PaletteNoticeKind.imported,
      count: known.length,
      unknown: unknownText,
      repeated: found.repeated > 0,
    );
    // Asked here, over the sheet: if the user keeps the palette they worked
    // on, the sheet stays open with the text and nothing changed.
    if (await _approveReplacement(dropsLocks: true) == _Approval.refused ||
        !mounted) {
      return '';
    }
    // Loaded the way a saved custom palette is: the first marker is the base
    // of the strip, the rest follow it. Every marker carries its brand.
    final bool loaded = await _loadSaved(
      SavedPalette(
        id: _importedPaletteId,
        brandId: _brand.id,
        name: t.paletteImportTitle,
        baseCode: known.first.colorId,
        baseName: known.first.newName,
        mode: PaletteMode.customPalette,
        paletteSize: known.length.clamp(3, 5),
        createdAtEpochMs: DateTime.now().millisecondsSinceEpoch,
        colorCodes: <String>[for (final MarkerColor c in known) c.colorId],
        isCustom: true,
      ),
      approved: true,
    );
    if (mounted && loaded) _setState(() => _notice = notice);
    return null;
  }

  /// Opens Easel mode: the palette on screen as large swatches, with the
  /// screen kept awake.
  Future<void> _openEasel() {
    final List<EaselColor> colors = <EaselColor>[
      for (final SharedPaletteColor item in _sharedColors())
        (
          code: _codeLabel(item.color),
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
