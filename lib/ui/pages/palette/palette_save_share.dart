part of 'palette_page.dart';

/// Saving, sharing and loading palettes.
extension _PaletteSaveShare on _PalettePageState {
  Future<void> _save() async {
    final scope = _scope;
    final base = _stripBase;
    if (scope == null || base == null || _suggestions.isEmpty) return;
    final name = await _askName(
      _photoMode
          ? '${base.newCode} ${context.l10n.paletteFromPhotoTitle}'
          : _useScenario
          ? '${base.newCode} ${context.l10n.scenarioLabel(_scenario)}'
          : '${base.newCode} ${context.l10n.modeLabel(_mode)}',
    );
    if (name == null || name.isEmpty) return;
    final now = DateTime.now();
    await scope.savedPalettes.save(
      SavedPalette(
        id: now.microsecondsSinceEpoch.toString(),
        brandId: _brand.id,
        name: name,
        baseCode: base.newCode,
        baseName: base.newName,
        mode: _mode,
        paletteSize: (_suggestions.length + 1).clamp(3, 5),
        createdAtEpochMs: now.millisecondsSinceEpoch,
        // A chain is saved in painting order, light to dark, base in place.
        colorCodes: <String>[
          if (_shownChain != null)
            for (final MarkerColor c in _shownChain!.colors) c.newCode
          else ...<String>[
            base.newCode,
            for (final suggestion in _suggestions) suggestion.color.newCode,
          ],
        ],
        isCustom: _mode == PaletteMode.customPalette,
        scenarioName: _photoMode
            ? PhotoScene.savedName
            : _useScenario
            ? _scenario.id
            : null,
      ),
    );
    // The third saved palette (over every brand) is a milestone for the
    // one-off review prompt.
    unawaited(
      scope.reviewPrompt?.onPaletteSaved(
        scope.savedPalettes.exportByBrand().values.fold<int>(
          0,
          (int sum, List<SavedPalette> list) => sum + list.length,
        ),
      ),
    );
    if (!mounted) return;
    _setState(() => _notice = context.l10n.paletteSavedNotice(name));
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

  /// Shares a saved palette as an image.
  Future<void> _shareSaved(SavedPalette palette) {
    if (_sharing) return Future<void>.value();
    final PaletteCardData data = savedPaletteCardData(
      palette: palette,
      catalog: _catalog,
      baseRole: context.l10n.roleLabel(PaletteRoles.base),
    );
    // None of its codes are in the catalogue any more: nothing to draw.
    if (data.entries.isEmpty) {
      return _runShare(() => throw StateError('empty palette'));
    }
    return _runShare(() => sharePaletteCard(_share, data));
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

  void _loadSaved(SavedPalette palette) {
    final byCode = <String, MarkerColor>{
      for (final color in _catalog) color.newCode.toUpperCase(): color,
    };
    final suggestions = <PaletteSuggestion>[];
    final String baseCode = palette.baseCode.toUpperCase();
    // A saved blending chain holds every step in painting order, base in place.
    BlendingChain? chain;
    final MarkerColor? chainBase = byCode[baseCode];
    if (palette.mode == PaletteMode.blendingChain && chainBase != null) {
      final List<MarkerColor> steps = <MarkerColor>[
        for (final String code in palette.colorCodes)
          if (byCode[code.toUpperCase()] != null) byCode[code.toUpperCase()]!,
      ];
      if (steps.length >= 2 &&
          steps.any((c) => c.colorId == chainBase.colorId)) {
        chain = BlendingChain(colors: steps, base: chainBase);
      }
    }
    for (final code in palette.colorCodes) {
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
    _setState(() {
      _baseInput = palette.baseCode;
      _baseController.text = palette.baseCode;
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
      _notice = context.l10n.paletteLoadedNotice(palette.name);
    });
  }

  /// Starts a diary entry linked to [palette], with its markers.
  Future<void> _addSavedToDiary(SavedPalette palette) async {
    final String notice = context.l10n.diaryAddedNotice;
    final bool saved = await ArtworkEntryPage.open(
      context,
      palette: palette,
      picker: widget.picker,
    );
    if (!saved || !mounted) return;
    _setState(() => _notice = notice);
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
