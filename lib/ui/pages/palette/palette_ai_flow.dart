part of 'palette_page.dart';

/// The optional AI advisor: availability, the suggestion request and its
/// typed failures, and the report of a suggestion.
extension _PaletteAiFlow on _PalettePageState {
  /// Recomputes whether the AI button should be offered.
  Future<void> _refreshAiAvailability() async {
    final scope = _scope;
    if (scope == null) return;
    final bool available = await scope.aiService.isAiAvailable();
    if (!mounted) return;
    if (available != _aiAvailable) _setState(() => _aiAvailable = available);
  }

  /// Applies the local engine's answer in place (call inside [setState]).
  void _applyLocalAdvice(PaletteAdvisorRequest request) {
    final advice = widget.advisor.advise(request);
    switch (advice) {
      case PaletteAdviceSuccess(:final suggestions):
        _failure = null;
        _suggestions = _mergeLocked(suggestions);
      case PaletteAdviceFailure(:final reason):
        _failure = reason;
        _suggestions = const <PaletteSuggestion>[];
    }
  }

  /// Runs the optional AI advisor for the current request.
  ///
  /// Never blocks: the advisor already falls back to the local engine, and any
  /// throw is caught here. The local result already on screen is kept when the
  /// AI fails, and the typed reason is shown next to the button.
  Future<void> _suggestWithAi() async {
    final scope = _scope;
    if (scope == null || _aiLoading) return;
    // Nothing to suggest without a marker of the collection: the button is
    // off, and the request never carries the whole range of the brand.
    if (!_hasMarkers) return;
    // The locked colours stay, so only a palette the user worked on asks.
    if (await _approveReplacement() == _Approval.refused || !mounted) return;
    final _PaletteSnapshot? previous = _snapshot();
    final request = _buildRequest();
    final int version = ++_aiVersion;
    _setState(() {
      _aiLoading = true;
      _aiUsed = false;
      _aiModel = '';
      _aiCount = 0;
      _aiTotal = 0;
      _aiError = null;
      _unknownInput = false;
      _notice = null;
    });
    try {
      final advisor = await scope.aiService.buildAdvisor();
      final ai.PaletteAdvice advice = await advisor.advise(request);
      if (!mounted || version != _aiVersion) return;
      _setState(() {
        _aiLoading = false;
        switch (advice) {
          case ai.PaletteAdviceSuccess(
            :final suggestions,
            :final modelUsed,
            :final tips,
            :final aiCount,
          ):
            // The local fallback reports no model; the AI always names one.
            if (modelUsed.isNotEmpty) {
              _failure = null;
              _suggestions = _mergeLocked(suggestions);
              _aiUsed = true;
              _aiModel = modelUsed;
              _aiProvider = _scope?.aiSettings.value.provider;
              _aiCount = aiCount;
              _aiTotal = suggestions.length;
            } else {
              _aiUsed = false;
              _aiError = tips.isNotEmpty ? tips.first : aiFellBackNote;
              _keepLocalResult(request, suggestions);
            }
          case ai.PaletteAdviceFailure(:final reason, :final message):
            _aiUsed = false;
            _aiError = message.isNotEmpty ? message : reason.userMessage;
            _keepLocalResult(request, null);
        }
      });
    } catch (_) {
      if (!mounted || version != _aiVersion) return;
      _setState(() {
        _aiLoading = false;
        _aiUsed = false;
        _aiError = aiFellBackNote;
        _keepLocalResult(request, null);
      });
    }
    // Only a suggestion that changed the palette offers its undo: a failed
    // call keeps the palette that was on screen.
    if (mounted && version == _aiVersion) _afterReplacement(previous);
  }

  /// Keeps the local result on screen after a failed AI call (call inside
  /// [setState]); computes one only when there is none yet.
  void _keepLocalResult(
    PaletteAdvisorRequest request,
    List<PaletteSuggestion>? fallback,
  ) {
    if (_suggestions.isNotEmpty) return;
    if (fallback != null && fallback.isNotEmpty) {
      _failure = null;
      _suggestions = _mergeLocked(fallback);
      return;
    }
    _applyLocalAdvice(request);
  }

  /// Asks why, then opens the email app with the suggestion's text. The
  /// message holds no key, no photo and no setting but the fields of
  /// [AiReport.body]; the user reviews and sends it from the email app.
  Future<void> _reportAi() async {
    final scope = _scope;
    if (scope == null || !_aiUsed) return;
    final AiReportReason? reason = await showDialog<AiReportReason>(
      context: context,
      builder: (BuildContext context) => const PaletteAiReportDialog(),
    );
    if (reason == null || !mounted) return;
    final MarkerColor? base = _stripBase;
    final AiProvider provider = _aiProvider ?? scope.aiSettings.value.provider;
    final String subject = AiReport.subject(reason);
    final String body = AiReport.body(
      appVersion: app_version.appVersion,
      provider: provider == AiProvider.onDevice ? 'on-device' : 'OpenRouter',
      model: _aiModel,
      // Every brand of the result ("Ohuhu + DecoTime"), not only the active
      // one.
      brand: paletteBrandsLabel(_sharedColors(), fallback: _brand),
      context: _useScenario ? _scenario.id : _mode.name,
      // With "Mix my brands" a code says its brand ("DecoTime 91").
      baseCode: base == null ? '-' : _codeLabel(base),
      items: <AiReportItem>[
        for (final PaletteSuggestion suggestion in _suggestions)
          AiReportItem(
            code: _codeLabel(suggestion.color),
            role: _roleFor(suggestion),
            reason: suggestion.reason,
          ),
      ],
    );
    final Uri uri = AiReport.mailto(subject: subject, body: body);
    final l10n = context.l10n;
    final ScaffoldMessengerState? messenger = ScaffoldMessenger.maybeOf(
      context,
    );
    bool opened;
    try {
      opened = await _launchEmail(uri);
    } catch (_) {
      opened = false;
    }
    if (!opened) {
      await Clipboard.setData(
        ClipboardData(
          text: AiReport.plainText(subject: subject, body: body),
        ),
      );
    }
    messenger
      ?..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          key: const ValueKey<String>('palette-ai-report-result'),
          content: Text(
            opened ? l10n.paletteAiReportThanks : l10n.paletteAiReportCopied,
          ),
        ),
      );
  }
}
