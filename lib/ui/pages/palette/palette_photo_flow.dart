part of 'palette_page.dart';

/// "From a photo": pick, read, analyse and show the photo as a palette.
extension _PalettePhotoFlow on _PalettePageState {
  /// Asks for a photo, finds its dominant colours on the device and shows the
  /// nearest owned markers. The photo is read into memory only: it is not
  /// stored and never leaves the phone.
  ///
  /// Every await is followed by a check of the flow's token: if the photo was
  /// dropped meanwhile (Clear, another type, a saved palette...) the late
  /// result is ignored.
  Future<void> _pickPhotoScene() async {
    if (_photoBusy) return;
    // A photo palette has no locks: the ones on screen go.
    if (await _approveReplacement(dropsLocks: true) == _Approval.refused ||
        !mounted) {
      return;
    }
    final _PaletteSnapshot? previous = _snapshot();
    final PhotoSource? source = await showPhotoSourceSheet(context);
    if (source == null || !mounted) return;
    final int token = ++_photoToken;
    _setState(() {
      _photoBusy = true;
      _photoError = null;
      _notice = null;
    });
    final PhotoPickResult result = await _picker.pick(source);
    if (!mounted || token != _photoToken) return;
    final AppLocalizations t = context.l10n;
    switch (result) {
      case PhotoPicked(:final Uint8List bytes):
        await _loadPhotoScene(bytes, token, previous);
      case PhotoPickCancelled():
        _setState(() => _photoBusy = false);
      case PhotoPickDenied(:final PhotoSource source):
        _setState(() {
          _photoBusy = false;
          _photoError = source == PhotoSource.camera
              ? t.matchCameraDenied
              : t.matchGalleryDenied;
        });
      case PhotoPickFailed():
        _setState(() {
          _photoBusy = false;
          _photoError = t.matchPickFailed;
        });
    }
  }

  Future<void> _loadPhotoScene(
    Uint8List bytes,
    int token,
    _PaletteSnapshot? previous,
  ) async {
    final AppLocalizations t = context.l10n;
    Map<int, List<PhotoColor>> colors;
    try {
      // The decoded pixels live only until the colours are found.
      final SampledImage sampled = await _decode(bytes);
      if (!mounted || token != _photoToken) return;
      colors = await _extract(sampled);
      if (!mounted || token != _photoToken) return;
    } on PhotoDecodeException {
      if (!mounted || token != _photoToken) return;
      _setState(() {
        _photoBusy = false;
        _photoError = t.matchDecodeFailed;
      });
      return;
    } catch (_) {
      if (!mounted || token != _photoToken) return;
      _setState(() {
        _photoBusy = false;
        _photoError = t.paletteFromPhotoEmpty;
      });
      return;
    }
    final PhotoScene scene = PhotoScene(bytes: bytes, colors: colors);
    // Needs a base and at least one companion, from markers the user owns.
    if (matchPhotoColorsToMarkers(
          scene.colorsFor(_companions + 1),
          _available,
        ).length <
        2) {
      scene.dispose();
      _setState(() {
        _photoBusy = false;
        _photoError = t.paletteFromPhotoEmpty;
      });
      return;
    }
    _setState(() {
      _photoScene?.dispose();
      _photoBusy = false;
      _photoError = null;
      _photoScene = scene;
      _useScenario = true;
      if (_mode == PaletteMode.customPalette) _mode = PaletteMode.recommended;
      _failure = null;
      _unknownInput = false;
      _lockedCodes = const <String>[];
      _lockedSuggestions.clear();
      // A pending AI answer must not overwrite the photo palette.
      _aiVersion++;
      _aiLoading = false;
      _aiUsed = false;
      _aiError = null;
    });
    _recompute();
    _afterReplacement(previous);
  }

  /// Shows the photo as a palette of the chosen size (call from [_recompute]):
  /// the colours found for that size, matched to the owned markers.
  void _applyPhotoScene(PhotoScene scene) {
    final List<PhotoMarkerPick> picks = matchPhotoColorsToMarkers(
      scene.colorsFor(_companions + 1),
      _available,
    ).take(_companions + 1).toList();
    _setState(() {
      _unknownInput = false;
      _aiUsed = false;
      _aiError = null;
      _lockedCodes = const <String>[];
      _lockedSuggestions.clear();
      _photoPicks = picks;
      if (picks.length < 2) {
        // The collection changed under the photo: nothing close is left.
        _suggestions = const <PaletteSuggestion>[];
        _failure = _available.isEmpty
            ? PaletteFailureReason.noAvailableColors
            : null;
        _photoError = _available.isEmpty
            ? null
            : context.l10n.paletteFromPhotoEmpty;
        return;
      }
      _failure = null;
      _photoError = null;
      _suggestions = <PaletteSuggestion>[
        for (final PhotoMarkerPick pick in picks.skip(1))
          PaletteSuggestion(color: pick.marker, reason: PaletteReasons.photo),
      ];
    });
  }

  /// The role line of [marker] in a photo palette: "Photo colour · 32 %".
  String _photoRole(MarkerColor marker) {
    for (final PhotoMarkerPick pick in _photoPicks) {
      if (pick.marker.colorId == marker.colorId) {
        return context.l10n.paletteFromPhotoRole(
          (pick.source.share * 100).round(),
        );
      }
    }
    return context.l10n.paletteFromPhotoTitle;
  }

  /// Whether a photo colour has no usable owned marker among those shown.
  bool get _photoHasFarPick =>
      _photoMode &&
      _photoPicks.any((PhotoMarkerPick p) => !MatchQuality.isUsable(p.deltaE));

  /// Forgets the photo and what came from it (call inside [setState]).
  ///
  /// It also ends a photo still being read: its result is dropped when it
  /// arrives and the spinner is cleared here.
  void _dropPhoto() {
    _photoScene?.dispose();
    _photoScene = null;
    _photoPicks = const <PhotoMarkerPick>[];
    _photoError = null;
    _photoToken++;
    _photoBusy = false;
  }
}
