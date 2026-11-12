part of 'palette_page.dart';

/// The result on screen: the strip with its codes, the role/reason rows, the
/// variations, the chain notes and the paint order.
extension _PaletteResultSection on _PalettePageState {
  /// The strip with its codes, role/reason card, variations and paint order.
  List<Widget> _buildResult({required bool split}) {
    final BlendingChain? chain = _shownChain;
    if (chain != null) return _buildChainResult(chain);
    final MarkerColor? base = _stripBase;
    // The base is the first band of the strip; companions follow it.
    final int offset = base == null ? 0 : 1;
    final bool photo = _photoMode;
    final List<MarkerColor> stripMarkers = <MarkerColor>[
      ?base,
      for (final suggestion in _suggestions) suggestion.color,
    ];
    final List<String> stripHexes = <String>[
      for (final MarkerColor c in stripMarkers) c.hex,
    ];
    final Set<int> locked = photo
        ? const <int>{}
        : <int>{
            if (base != null) 0,
            for (var index = 0; index < _suggestions.length; index++)
              if (_isLocked(_suggestions[index])) index + offset,
          };
    return <Widget>[
      paletteInset(
        _resultHeader(
          title: context.l10n.paletteResultTitle(_suggestions.length + offset),
        ),
        top: InkSpacing.section,
      ),
      paletteInset(
        PaletteStrip(
          colors: _seenAll(stripHexes),
          labels: _stripCodes(stripMarkers),
          brandLabels: _stripBrands(stripMarkers),
          lockedIndices: locked,
        ),
        top: InkSpacing.headingGap,
      ),
      paletteInset(
        Card(
          child: Column(
            children: <Widget>[
              for (var index = 0; index < _suggestions.length; index++)
                PaletteSuggestionRow(
                  key: ValueKey<String>(
                    'palette-row-${_rowId(_suggestions[index].color)}',
                  ),
                  suggestion: _suggestions[index],
                  mixed: _mixed,
                  role: _roleFor(_suggestions[index]),
                  locked: _isLocked(_suggestions[index]),
                  last: index == _suggestions.length - 1,
                  onToggleLock: photo
                      ? null
                      : () => _toggleLock(_suggestions[index]),
                ),
            ],
          ),
        ),
        top: InkSpacing.block,
      ),
      if (!photo)
        Padding(
          padding: const EdgeInsets.only(top: InkSpacing.block),
          child: InkChipRow(
            // Side by side on a tablet there is room for the lines: no chip
            // is cut by the edge of its half.
            wrap: split,
            fadeEnds: true,
            semanticLabel: context.l10n.paletteVariationsLabel,
            children: <Widget>[
              for (final variation in QuickPaletteVariation.values)
                InkChip(
                  label: context.l10n.variationName(variation),
                  selected: false,
                  onSelected: (_) => _applyVariation(variation),
                ),
            ],
          ),
        ),
      ..._buildPaintOrder(),
    ];
  }

  /// What to tell the user about the chain on screen, or why there is none:
  /// a short chain, a base at the end of its family, the missing marker.
  ///
  /// The whole range is offered even when there is no chain yet (the
  /// collection is empty, or the base is not in it): that is the one way to
  /// get a chain without owning a single marker of the family.
  List<Widget> _buildChainNotes() {
    if (!_chainMode) return const <Widget>[];
    final BlendingChainResult? result = _chainResult;
    final AppLocalizations t = context.l10n;
    final BlendingChain? chain = (result == null || result.best == null)
        ? null
        : _chain;
    final List<String> messages = <String>[];
    if (result != null) {
      if (chain == null) {
        messages.add(switch (result.gap) {
          BlendingGap.lighter => t.paletteChainNeedLighter,
          BlendingGap.darker => t.paletteChainNeedDarker,
          _ => t.paletteChainNeedBoth,
        });
      } else {
        if (result.isShort) {
          messages.add(
            t.paletteChainShort(chain.colors.length, result.requested),
          );
        }
        if (chain.baseIsLightest && !result.lighterAvailable) {
          messages.add(t.paletteChainBaseLightest);
        }
        if (chain.baseIsDarkest && !result.darkerAvailable) {
          messages.add(t.paletteChainBaseDarkest);
        }
      }
    }
    // "Search the whole range" is offered when there is no chain yet only for
    // users with no usable marker; owners must type a base first, and a chain
    // loaded from a saved palette must not show it (it already has its chain).
    final bool noResultNoChain = _chainResult == null && _chain == null;
    final bool canWiden =
        !_chainWholeRange &&
        _range.length > _available.length &&
        (_chainResult != null
            ? (chain == null || result?.isShort == true)
            : (noResultNoChain && !_hasMarkers));
    return <Widget>[
      if (_chainWholeRange)
        paletteInset(
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // The range the chain came from, not the one in use now.
              PaletteInfoCard(message: _chainRangeNote(t)),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: InkButton.text(
                  key: const ValueKey<String>('palette-chain-my-markers'),
                  label: t.paletteChainMyMarkers,
                  onPressed: () => _setChainWholeRange(false),
                ),
              ),
            ],
          ),
          top: InkSpacing.block,
        ),
      if (messages.isNotEmpty)
        paletteInset(
          KeyedSubtree(
            key: const ValueKey<String>('palette-chain-note'),
            child: PaletteInfoCard(message: messages.join(' ')),
          ),
          top: InkSpacing.block,
        ),
      if (canWiden)
        paletteInset(
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: InkButton.secondary(
              key: const ValueKey<String>('palette-chain-whole-range'),
              label: t.paletteChainWholeRange,
              onPressed: () => _setChainWholeRange(true),
            ),
          ),
          top: InkSpacing.s8,
        ),
    ];
  }

  /// The strip, the steps (lightest first), the other chains and the hint of
  /// a blending chain, then the paint order.
  List<Widget> _buildChainResult(BlendingChain chain) {
    final AppLocalizations t = context.l10n;
    final List<String> roles = blendingChainRoles(chain);
    final Set<String> mine = <String>{
      for (final MarkerColor c in _available) c.colorId,
    };
    final BlendingChainResult? result = _chainResult;
    final int count = chain.colors.length;
    final List<String> chainHexes = <String>[
      for (final MarkerColor c in chain.colors) c.hex,
    ];
    return <Widget>[
      paletteInset(
        _resultHeader(title: t.paletteChainResultTitle(count)),
        top: InkSpacing.section,
      ),
      paletteInset(
        PaletteStrip(
          colors: _seenAll(chainHexes),
          labels: _stripCodes(chain.colors),
          brandLabels: _stripBrands(chain.colors),
          lockedIndices: <int>{chain.baseIndex},
        ),
        top: InkSpacing.headingGap,
      ),
      paletteInset(
        Card(
          child: Column(
            children: <Widget>[
              for (int i = 0; i < count; i++)
                PaletteSuggestionRow(
                  key: ValueKey<String>(
                    'palette-row-${_rowId(chain.colors[i])}',
                  ),
                  mixed: _mixed,
                  suggestion: PaletteSuggestion(
                    color: chain.colors[i],
                    reason: roles[i],
                  ),
                  role: roles[i],
                  roleText: t.paletteChainStep(i + 1, t.roleLabel(roles[i])),
                  note: mine.contains(chain.colors[i].colorId)
                      ? null
                      : t.matchNotOwnedBadge,
                  locked: false,
                  last: i == count - 1,
                  onToggleLock: null,
                ),
            ],
          ),
        ),
        top: InkSpacing.block,
      ),
      if (result != null && result.chains.length > 1)
        Padding(
          padding: const EdgeInsets.only(top: InkSpacing.block),
          child: InkChipRow(
            semanticLabel: t.paletteChainOptionsLabel,
            children: <Widget>[
              for (int i = 0; i < result.chains.length; i++)
                InkChip(
                  key: ValueKey<String>('palette-chain-option-$i'),
                  label: t.paletteChainOption(i + 1),
                  selected: i == _chainIndex,
                  onSelected: (_) => _selectChain(i),
                ),
            ],
          ),
        ),
      paletteInset(
        KeyedSubtree(
          key: const ValueKey<String>('palette-chain-hint'),
          child: PaletteInfoCard(message: t.paletteChainHint),
        ),
        top: InkSpacing.block,
      ),
      ..._buildPaintOrder(),
    ];
  }

  /// The labels under the strip: the bare codes, at the size they always
  /// have. When the palette mixes brands the brand goes on a line of its own
  /// above each ([_stripBrands]), never in the same line.
  List<String> _stripCodes(List<MarkerColor> markers) => <String>[
    for (final MarkerColor c in markers) c.newCode,
  ];

  /// The short brand name over each code of the strip, or `null` when the
  /// codes are shown without their brand (see [_mixed]).
  List<String>? _stripBrands(List<MarkerColor> markers) => _mixed
      ? <String>[
          for (final MarkerColor c in markers)
            MarkerBrand.fromId(c.brandId).shortLabel,
        ]
      : null;

  List<String> _seenAll(List<String> hexes) => <String>[
    for (final String hex in hexes) seenHex(hex, _vision, values: _values),
  ];

  /// The row that titles a result with the AI badge and the "⋯".
  Widget _resultHeader({required String title}) => PaletteResultHeader(
    title: title,
    aiLabel: _aiUsed
        ? context.l10n.aiResultLabel(
            _aiModel,
            aiCount: _aiCount,
            total: _aiTotal,
          )
        : null,
    menuItems: _resultMenuItems(),
  );

  /// The secondary actions of the result: Share · Share as text · Easel mode ·
  /// Colour vision (the preview of `palette_vision`) · Report (only with an AI
  /// result) · Clear.
  List<InkMenuItem> _resultMenuItems() => <InkMenuItem>[
    InkMenuItem(
      key: const ValueKey<String>('palette-share'),
      label: context.l10n.paletteShareButton,
      icon: InkIcons.share,
      onSelected: _sharePalette,
    ),
    InkMenuItem(
      key: const ValueKey<String>('palette-share-text'),
      label: context.l10n.paletteShareTextButton,
      icon: InkIcons.copy,
      onSelected: _sharePaletteText,
    ),
    InkMenuItem(
      key: const ValueKey<String>('palette-easel-open'),
      label: context.l10n.paletteEaselTitle,
      icon: InkIcons.columns,
      onSelected: _openEasel,
    ),
    InkMenuItem(
      key: const ValueKey<String>('palette-vision-open'),
      label: context.l10n.paletteVisionTitle,
      icon: InkIcons.eye,
      onSelected: _openVision,
    ),
    if (_aiUsed)
      InkMenuItem(
        key: const ValueKey<String>('palette-ai-report'),
        label: context.l10n.paletteAiReportButton,
        icon: InkIcons.flag,
        onSelected: _reportAi,
      ),
    InkMenuItem(
      key: const ValueKey<String>('palette-clear'),
      label: context.l10n.paletteClearButton,
      icon: InkIcons.trash2,
      destructive: true,
      onSelected: _clear,
    ),
  ];

  /// The true colours and codes of the palette on screen (a chain in painting
  /// order, or the base plus the companions), for the colour vision preview.
  ({List<String> hexes, List<String> codes}) _onScreenPalette() {
    final BlendingChain? chain = _shownChain;
    if (chain != null) {
      return (
        hexes: <String>[for (final MarkerColor c in chain.colors) c.hex],
        codes: <String>[
          for (final MarkerColor c in chain.colors) _codeLabel(c),
        ],
      );
    }
    final MarkerColor? base = _stripBase;
    return (
      hexes: <String>[
        if (base != null) base.hex,
        for (final PaletteSuggestion s in _suggestions) s.color.hex,
      ],
      codes: <String>[
        if (base != null) _codeLabel(base),
        for (final PaletteSuggestion s in _suggestions) _codeLabel(s.color),
      ],
    );
  }

  /// Opens the colour vision preview (spec §2.2) in a sheet: the page keeps
  /// only the chosen vision, the picker and the pairs live in the sheet.
  Future<void> _openVision() async {
    final ({List<String> hexes, List<String> codes}) palette =
        _onScreenPalette();
    await showInkSheet<void>(
      context: context,
      builder: (BuildContext context) => PaletteVisionSheet(
        initial: _vision,
        initialValues: _values,
        hexes: palette.hexes,
        codes: palette.codes,
        onChanged: (ColorVisionType? type) {
          if (mounted) {
            _setState(() {
              _vision = type;
              _values = false;
            });
          }
        },
        onValuesChanged: (bool on) {
          if (mounted) {
            _setState(() {
              _values = on;
              if (on) _vision = null;
            });
          }
        },
      ),
    );
  }

  /// The paint order of the palette on screen, folded behind a disclosure.
  List<Widget> _buildPaintOrder() {
    final List<PlanStep> steps = _paintPlan();
    if (steps.isEmpty) return const <Widget>[];
    return <Widget>[
      PaintOrderSection(
        steps: steps,
        hexOf: (String code) =>
            seenHex(_hexForCode(code), _vision, values: _values),
        open: _paintOrderOpen,
        onToggle: () => _setState(() => _paintOrderOpen = !_paintOrderOpen),
      ),
    ];
  }

  List<PlanStep> _paintPlan() => buildPaintPlan(
    mixed: _mixed,
    t: context.l10n,
    chain: _shownChain,
    base: _stripBase,
    photoMode: _photoMode,
    keepOrder: _mode == PaletteMode.customPalette || _photoMode,
    suggestions: _suggestions,
    photoRole: _photoRole,
    roleFor: _roleFor,
  );
}
