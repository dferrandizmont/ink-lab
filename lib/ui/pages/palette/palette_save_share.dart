part of 'palette_page.dart';

/// Saving, sharing and loading palettes.
extension _PaletteSaveShare on _PalettePageState {
  Future<void> _save() async {
    final scope = _scope;
    final base = _stripBase;
    if (scope == null || base == null || _suggestions.isEmpty) return;
    // The base as the field names it: with its brand when the code alone
    // would not say which marker it is ("DecoTime 91 Recommended").
    final String baseLabel = _baseValue(base);
    final name = await _askName(
      _photoMode
          ? '$baseLabel ${context.l10n.paletteFromPhotoTitle}'
          : _useScenario
          ? '$baseLabel ${context.l10n.scenarioLabel(_scenario)}'
          : '$baseLabel ${context.l10n.modeLabel(_mode)}',
    );
    if (name == null || name.isEmpty) return;
    final now = DateTime.now();
    await scope.savedPalettes.save(
      SavedPalette(
        id: now.microsecondsSinceEpoch.toString(),
        brandId: _brand.id,
        name: name,
        baseCode: _storedCodes(<MarkerColor>[base]).single,
        baseName: base.newName,
        mode: _mode,
        paletteSize: (_suggestions.length + 1).clamp(3, 5),
        createdAtEpochMs: now.millisecondsSinceEpoch,
        colorCodes: _currentCodes(base),
        isCustom: _mode == PaletteMode.customPalette,
        scenarioName: _photoMode
            ? PhotoScene.savedName
            : _useScenario
            ? _scenario.id
            : null,
      ),
    );
    unawaited(scope.reviewPrompt?.onSuccess());
    if (!mounted) return;
    // The confirmation is where the finger is: the Save button turns into
    // "Saved" (see [_isSaved]) and a snack bar names the palette. A banner at
    // the top of the page would be out of view, and would outlive the palette.
    final ScaffoldMessengerState? messenger = ScaffoldMessenger.maybeOf(
      context,
    );
    messenger
      ?..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          key: const ValueKey<String>('palette-saved-snack'),
          content: Text(context.l10n.paletteSavedNotice(name)),
        ),
      );
    _setState(() {
      _workedPalette = true;
      _paletteEdited = false;
    });
  }

  /// The markers of the palette on screen in saved order: a chain in painting
  /// order, light to dark, base in place; otherwise the base plus the
  /// companions.
  List<MarkerColor> _currentColors(MarkerColor base) => <MarkerColor>[
    if (_shownChain != null)
      ..._shownChain!.colors
    else ...<MarkerColor>[
      base,
      for (final PaletteSuggestion suggestion in _suggestions) suggestion.color,
    ],
  ];

  /// [colors] as a saved palette stores them. A palette of the active brand
  /// alone is stored as it always was, by bare codes that belong to the
  /// palette's `brandId`; as soon as the palette on screen holds a marker of
  /// another brand, every marker is stored with its brand (`decotime:91`).
  List<String> _storedCodes(List<MarkerColor> colors) {
    final MarkerColor? base = _stripBase;
    final bool branded = <MarkerColor>[
      ...?(base == null ? null : _currentColors(base)),
      ...colors,
    ].any((MarkerColor c) => c.brandId != _brand.id);
    return <String>[
      for (final MarkerColor c in colors) branded ? c.colorId : c.newCode,
    ];
  }

  /// The codes saved for the palette on screen.
  List<String> _currentCodes(MarkerColor base) =>
      _storedCodes(_currentColors(base));

  /// Whether the palette on screen is already among the saved ones (the same
  /// markers in the same order), under any brand: a palette that mixes
  /// brands is stored under the brand in use when it was saved, and must not
  /// be saved again under another. Deleting the saved palette makes it
  /// saveable again; changing the palette does too.
  bool get _isSaved {
    final AppScope? scope = _scope;
    final MarkerColor? base = _stripBase;
    if (scope == null || base == null || _suggestions.isEmpty) return false;
    final List<String> codes = <String>[
      for (final MarkerColor c in _currentColors(base)) c.colorId.toUpperCase(),
    ];
    return scope.savedPalettes.all.any((SavedPalette saved) {
      if (saved.colorCodes.length != codes.length) return false;
      for (int i = 0; i < codes.length; i++) {
        if (saved.colorIds[i].toUpperCase() != codes[i]) return false;
      }
      return true;
    });
  }

  /// The type or scene name that titles the palette on screen.
  String get _shareTitle => _photoMode
      ? context.l10n.paletteFromPhotoTitle
      : _useScenario
      ? context.l10n.scenarioLabel(_scenario)
      : context.l10n.modeLabel(_mode);

  /// Renders the palette on screen (AI and scene palettes included) as an
  /// image and opens the share sheet.
  Future<void> _sharePalette() async {
    final MarkerColor? base = _stripBase;
    if (_sharing || base == null || _suggestions.isEmpty) return;
    final PaletteCardData data = paletteCardData(
      title: _shareTitle,
      brand: _brand,
      colors: _sharedColors(),
    );
    await _runShare(() => sharePaletteCard(_share, data));
  }

  /// The markers of the palette on screen, in strip order, each with its
  /// localised role: a chain in painting order, or the base plus the
  /// companions. What the image, the text and Easel mode all show.
  List<SharedPaletteColor> _sharedColors() {
    final MarkerColor? base = _stripBase;
    final BlendingChain? chain = _shownChain;
    if (chain != null) {
      final List<String> chainRoles = blendingChainRoles(chain);
      return <SharedPaletteColor>[
        for (int i = 0; i < chain.colors.length; i++)
          (color: chain.colors[i], role: context.l10n.roleLabel(chainRoles[i])),
      ];
    }
    return <SharedPaletteColor>[
      if (base != null)
        (
          color: base,
          role: _photoMode
              ? _photoRole(base)
              : context.l10n.roleLabel(PaletteRoles.base),
        ),
      for (final PaletteSuggestion suggestion in _suggestions)
        (
          color: suggestion.color,
          role: context.l10n.roleLabel(_roleFor(suggestion)),
        ),
    ];
  }

  /// Shares a saved palette as an image. Its markers may be of other brands
  /// than the ones in use: their catalogues are read first.
  Future<void> _shareSaved(SavedPalette palette) async {
    if (_sharing) return;
    final String baseRole = context.l10n.roleLabel(PaletteRoles.base);
    await _runShare(() async {
      final List<MarkerColor> catalog = await _withBrands(
        _catalog,
        palette.brandIds,
      );
      final PaletteCardData data = savedPaletteCardData(
        palette: palette,
        catalog: catalog,
        baseRole: baseRole,
      );
      // None of its codes are in the catalogue any more: nothing to draw.
      if (data.entries.isEmpty) throw StateError('empty palette');
      await sharePaletteCard(_share, data);
    });
  }

  Future<void> _runShare(Future<void> Function() share) async {
    final ScaffoldMessengerState? messenger = ScaffoldMessenger.maybeOf(
      context,
    );
    final String failed = context.l10n.shareFailed;
    _setState(() => _sharing = true);
    try {
      await share();
    } catch (_) {
      messenger
        ?..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            key: const ValueKey<String>('palette-share-failed'),
            content: Text(failed),
          ),
        );
    } finally {
      if (mounted) _setState(() => _sharing = false);
    }
  }

  Future<String?> _askName(String initial) => showDialog<String>(
    context: context,
    builder: (BuildContext context) => PaletteSaveNameDialog(initial: initial),
  );

  /// Puts [palette] on screen and returns whether it did (the user may refuse
  /// to replace a palette they worked on; [approved] when they were already
  /// asked).
  ///
  /// The markers of a mixed palette keep their brands whatever brand is in
  /// use; a palette saved before brands could mix holds bare codes of its
  /// own brand and loads as it always did.
  Future<bool> _loadSaved(SavedPalette palette, {bool approved = false}) async {
    // The sheet that hands the palette over closes right after this call: a
    // question must not open under it and be closed in its place.
    await Future<void>.delayed(Duration.zero);
    if (!mounted) return false;
    if (!approved &&
        (await _approveReplacement(dropsLocks: true) == _Approval.refused ||
            !mounted)) {
      return false;
    }
    final List<MarkerColor> catalog = await _withBrands(
      _catalog,
      palette.brandIds,
    );
    if (!mounted) return false;
    final _PaletteSnapshot? previous = _snapshot();
    final byCode = <String, MarkerColor>{
      for (final color in catalog) color.colorId.toUpperCase(): color,
    };
    final suggestions = <PaletteSuggestion>[];
    final String baseCode = palette.baseColorId.toUpperCase();
    // A saved blending chain holds every step in painting order, base in place.
    BlendingChain? chain;
    final MarkerColor? chainBase = byCode[baseCode];
    if (palette.mode == PaletteMode.blendingChain && chainBase != null) {
      final List<MarkerColor> steps = <MarkerColor>[
        for (final String code in palette.colorIds)
          if (byCode[code.toUpperCase()] != null) byCode[code.toUpperCase()]!,
      ];
      if (steps.length >= 2 &&
          steps.any((c) => c.colorId == chainBase.colorId)) {
        chain = BlendingChain(colors: steps, base: chainBase);
      }
    }
    for (final code in palette.colorIds) {
      // The base is the first band of the strip, not a companion row. Older
      // saved palettes hold the companions only.
      if (code.toUpperCase() == baseCode) continue;
      final color = byCode[code.toUpperCase()];
      if (color != null) {
        suggestions.add(
          PaletteSuggestion(color: color, reason: PaletteReasons.loaded),
        );
      }
    }
    final MarkerColor? base = byCode[baseCode];
    // The base field names the brand when the palette (or the collection)
    // holds more than the active one.
    final bool branded =
        _scopeMixed || palette.brandIds.any((String id) => id != _brand.id);
    _cancelAi();
    _setState(() {
      _catalog = catalog;
      _baseInput = base == null
          ? palette.baseCode
          : markerCodeLabel(base, mixed: branded);
      _mode = palette.mode;
      _paletteSize = (suggestions.length + 1).clamp(3, 5);
      _useScenario = false;
      _dropPhoto();
      _dropChain();
      _failure = null;
      _unknownInput = false;
      _lockedCodes = const <String>[];
      _lockedSuggestions.clear();
      _suggestions = suggestions;
      if (chain != null) {
        _paletteSize = chain.colors.length.clamp(3, 5);
        _showChain(chain);
      }
      _aiUsed = false;
      _aiError = null;
      // A palette of "My palettes" is one the user keeps; a pasted one is a
      // fresh result.
      _workedPalette = palette.id != _importedPaletteId;
      _paletteEdited = false;
      _notice = _PaletteNotice(_PaletteNoticeKind.loaded, name: palette.name);
    });
    if (previous != null && previous.differsFrom(this)) _offerUndo(previous);
    return true;
  }

  /// Starts a diary entry linked to [palette], with its markers.
  Future<void> _addSavedToDiary(SavedPalette palette) async {
    final bool saved = await ArtworkEntryPage.open(
      context,
      palette: palette,
      picker: widget.picker,
    );
    if (!saved || !mounted) return;
    _setState(() => _notice = const _PaletteNotice(_PaletteNoticeKind.diary));
  }

  /// Opens the brand's saved palettes as a draggable selector (spec §2.2):
  /// loading, sharing, adding to the diary and deleting all happen there.
  Future<void> _openSavedPalettes(AppScope scope) => SavedPalettesSheet.show(
    context,
    scope: scope,
    brand: _brand,
    onLoad: _loadSaved,
    onShare: _shareSaved,
    onAddToDiary: _addSavedToDiary,
    onImport: _openImport,
  );
}
