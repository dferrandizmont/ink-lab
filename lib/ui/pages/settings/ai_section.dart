import 'dart:async';

import 'package:flutter/material.dart';

import '../../../ai/ai.dart';
import '../../../app_scope.dart';
import '../../../data/data.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/section_card.dart';
import 'ai_model_picker.dart';
import 'constants.dart';
import 'settings_widgets.dart';
import '../../../l10n/l10n.dart';

/// The configuration of the optional AI advisor.
///
/// All rules live in [AiSettingsController]; this widget only renders its state
/// and forwards taps. The API key is entered in a masked field, handed straight
/// to the controller and never kept here after a successful save.
class AiSettingsSection extends StatefulWidget {
  const AiSettingsSection({
    super.key,
    required this.scope,
    required this.changes,
  });

  /// The app services.
  final AppScope scope;

  /// The stream of the AI settings.
  final Stream<AiSettings> changes;

  @override
  State<AiSettingsSection> createState() => _AiSettingsSectionState();
}

class _AiSettingsSectionState extends State<AiSettingsSection>
    with WidgetsBindingObserver {
  final TextEditingController _textModel = TextEditingController();
  final TextEditingController _maxTokens = TextEditingController();
  final TextEditingController _apiKey = TextEditingController();
  final FocusNode _textFocus = FocusNode();
  final FocusNode _maxTokensFocus = FocusNode();
  final FocusNode _apiKeyFocus = FocusNode();

  late final AiSettingsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AiSettingsController(
      settings: widget.scope.aiSettings,
      secrets: widget.scope.secrets,
      service: widget.scope.aiService,
      changes: widget.changes,
    );
    _textModel.text = _controller.value.textModel;
    _maxTokens.text = '${_controller.value.maxTokens}';
    _controller.addListener(_onController);
    WidgetsBinding.instance.addObserver(this);
    unawaited(_controller.initialize());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Back from the system settings or the background: the model may have
    // finished downloading meanwhile.
    if (state == AppLifecycleState.resumed) {
      unawaited(_controller.refreshOnDevice());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.removeListener(_onController);
    _controller.dispose();
    _textModel.dispose();
    _maxTokens.dispose();
    _apiKey.dispose();
    _textFocus.dispose();
    _maxTokensFocus.dispose();
    _apiKeyFocus.dispose();
    super.dispose();
  }

  void _onController() {
    if (!mounted) return;
    final AiSettings value = _controller.value;
    // Only refresh fields that are not being edited, so an external change (a
    // backup import) does not steal the cursor.
    if (!_textFocus.hasFocus && _textModel.text != value.textModel) {
      _textModel.text = value.textModel;
    }
    if (!_maxTokensFocus.hasFocus && _maxTokens.text != '${value.maxTokens}') {
      _maxTokens.text = '${value.maxTokens}';
    }
    setState(() {});
  }

  // ---------------------------------------------------------------------------
  // Actions
  // ---------------------------------------------------------------------------

  Future<void> _onToggleEnabled(bool value) async {
    if (!value) {
      await _controller.setEnabled(false);
      return;
    }
    final String disclosure = switch (_effectiveProvider) {
      AiProvider.local =>
        _onDeviceOffered
            ? context.l10n.settingsAiDisclosureColourTheory
            : context.l10n.settingsAiDisclosureColourTheoryNoOnDevice,
      AiProvider.onDevice => context.l10n.settingsAiDisclosureOnDevice,
      AiProvider.openRouter => context.l10n.settingsAiDisclosure,
    };
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(context.l10n.settingsAiDisclosureTitle),
        content: Text(disclosure, key: const ValueKey<String>('ai-disclosure')),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.l10n.settingsAiDisclosureCancel),
          ),
          FilledButton(
            key: const ValueKey<String>('ai-disclosure-confirm'),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(context.l10n.settingsAiDisclosureConfirm),
          ),
        ],
      ),
    );
    if (confirmed == true) await _controller.setEnabled(true);
  }

  Future<void> _saveKey() async {
    final bool saved = await _controller.saveKey(_apiKey.text);
    // The key lives only in this controller; drop it as soon as it is stored.
    if (saved) _apiKey.clear();
  }

  Future<void> _removeKey() async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(context.l10n.settingsAiRemoveKeyTitle),
        content: Text(context.l10n.settingsAiRemoveKeyBody),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.l10n.settingsCancel),
          ),
          FilledButton(
            key: const ValueKey<String>('ai-remove-key-confirm'),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(context.l10n.settingsAiRemoveKeyConfirm),
          ),
        ],
      ),
    );
    if (confirmed == true) await _controller.removeKey();
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  /// The provider the user picked. It is never reinterpreted: the platform may
  /// report the on-device model as unavailable for a moment after an update or
  /// on a phone that cannot run it (a backup from another phone), and showing
  /// colour theory then made the choice look reset. The advisor still falls
  /// back to colour theory while the model is missing; the section says so.
  AiProvider get _effectiveProvider => _controller.provider;

  /// Offered where the phone has an on-device model, and always while it is
  /// the stored choice so the selection stays visible.
  bool get _onDeviceOffered =>
      _controller.onDeviceSupported ||
      _controller.provider == AiProvider.onDevice;

  @override
  Widget build(BuildContext context) {
    final bool onDeviceOffered = _onDeviceOffered;
    final AiProvider selectedProvider = _effectiveProvider;
    final bool onDevice = selectedProvider == AiProvider.onDevice;
    final bool openRouter = selectedProvider == AiProvider.openRouter;
    return SettingsGroup(
      title: context.l10n.settingsAiGroup,
      trailing: context.l10n.settingsAiOffByDefault,
      children: <Widget>[
        SettingsSwitchRow(
          label: context.l10n.settingsAiEnabled,
          subtitle: switch (selectedProvider) {
            AiProvider.local =>
              onDeviceOffered
                  ? context.l10n.settingsAiEnabledSubtitleColourTheory
                  : context
                        .l10n
                        .settingsAiEnabledSubtitleColourTheoryNoOnDevice,
            AiProvider.onDevice =>
              context.l10n.settingsAiEnabledSubtitleOnDevice,
            AiProvider.openRouter =>
              context.l10n.settingsAiEnabledSubtitleOpenRouter,
          },
          value: _controller.enabled,
          onChanged: _onToggleEnabled,
        ),
        SettingsControlRow(
          label: context.l10n.settingsAiProvider,
          stacked: true,
          // Three long options: a radio list, not a segmented control.
          control: Semantics(
            container: true,
            label: context.l10n.settingsAiProvider,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SettingsRadioRow(
                  label: context.l10n.settingsAiProviderColourTheory,
                  selected: selectedProvider == AiProvider.local,
                  onTap: () => _controller.setProvider(AiProvider.local),
                ),
                // Offered only where the phone has an on-device model: there
                // is no "not available" row on iOS or unsupported devices.
                if (onDeviceOffered)
                  SettingsRadioRow(
                    label: context.l10n.settingsAiProviderOnDevice,
                    semantic: context.l10n.settingsAiOnDeviceName,
                    selected: selectedProvider == AiProvider.onDevice,
                    onTap: () => _controller.setProvider(AiProvider.onDevice),
                  ),
                SettingsRadioRow(
                  label: context.l10n.settingsAiProviderOpenRouter,
                  selected: selectedProvider == AiProvider.openRouter,
                  onTap: () => _controller.setProvider(AiProvider.openRouter),
                ),
              ],
            ),
          ),
        ),
        SettingsCaption(switch (selectedProvider) {
          AiProvider.local => context.l10n.settingsAiExplainColourTheory,
          AiProvider.onDevice => context.l10n.settingsAiExplainOnDevice,
          AiProvider.openRouter => context.l10n.settingsAiExplainOpenRouter,
        }, textKey: const ValueKey<String>('ai-provider-explanation')),
        if (onDevice) _buildOnDevice(),
        if (openRouter) ...<Widget>[
          _buildApiKey(),
          _buildConnection(),
          _buildModels(),
          _Block(child: _buildTemperature()),
          _Block(child: _buildMaxTokens()),
        ],
        SettingsSwitchRow(
          label: context.l10n.settingsAiAutoFallback,
          subtitle: context.l10n.settingsAiAutoFallbackSubtitle,
          value: _controller.autoFallback,
          onChanged: _controller.setAutoFallback,
        ),
      ],
    );
  }

  /// Status of the on-device model and the action that matches it.
  Widget _buildOnDevice() {
    final InkColors ink = InkColors.of(context);
    final OnDeviceStatus status = _controller.onDeviceStatus;
    final TextStyle note = AppTypography.secondary.copyWith(color: ink.fg2);
    final bool downloading = status == OnDeviceStatus.downloading;
    return _Block(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            context.l10n.settingsAiOnDeviceName,
            style: AppTypography.body.copyWith(color: ink.fg),
          ),
          const SizedBox(height: InkSpacing.s4),
          Text(
            switch (status) {
              OnDeviceStatus.available => context.l10n.settingsAiOnDeviceReady,
              OnDeviceStatus.downloading =>
                context.l10n.settingsAiOnDeviceDownloading,
              OnDeviceStatus.unavailable =>
                context.l10n.settingsAiOnDeviceUnavailable,
              OnDeviceStatus.downloadable =>
                context.l10n.settingsAiOnDeviceDownloadable,
            },
            key: const ValueKey<String>('ai-on-device-status'),
            style: note,
          ),
          if (status == OnDeviceStatus.downloadable || downloading) ...<Widget>[
            const SizedBox(height: InkSpacing.group),
            _ActionWithProgress(
              busy: downloading,
              button: InkButton.secondary(
                key: const ValueKey<String>('ai-on-device-download'),
                label: context.l10n.settingsAiOnDeviceDownload,
                icon: InkIcons.download,
                onPressed: downloading ? null : _controller.downloadOnDevice,
              ),
            ),
          ],
          if (downloading && _controller.onDeviceBytes > 0) ...<Widget>[
            const SizedBox(height: InkSpacing.s8),
            Text(
              context.l10n.onDeviceProgressText(
                _controller.onDeviceBytes,
                total: _controller.onDeviceTotalBytes,
              ),
              key: const ValueKey<String>('ai-on-device-progress'),
              style: note,
            ),
            if (_controller.onDeviceTotalBytes > 0) ...<Widget>[
              const SizedBox(height: InkSpacing.s8),
              LinearProgressIndicator(
                key: const ValueKey<String>('ai-on-device-bar'),
                value:
                    (_controller.onDeviceBytes / _controller.onDeviceTotalBytes)
                        .clamp(0.0, 1.0),
              ),
            ],
          ] else if (downloading &&
              (_controller.onDeviceStalled ||
                  !_controller.onDeviceDownloadRunning)) ...<Widget>[
            // No progress event for a while, or a download the app did not
            // start (AICore keeps it queued): explain the wait calmly.
            const SizedBox(height: InkSpacing.s8),
            Text(
              context.l10n.settingsAiOnDevicePreparing,
              key: const ValueKey<String>('ai-on-device-preparing'),
              style: note,
            ),
          ],
          if (status != OnDeviceStatus.available) ...<Widget>[
            const SizedBox(height: InkSpacing.s4),
            InkButton.text(
              key: const ValueKey<String>('ai-on-device-check-again'),
              label: context.l10n.settingsAiOnDeviceCheckAgain,
              onPressed: _controller.refreshOnDevice,
            ),
          ],
          if (_controller.onDeviceDownloadFailed &&
              status == OnDeviceStatus.downloadable) ...<Widget>[
            const SizedBox(height: InkSpacing.s8),
            Text(
              context.l10n.settingsAiOnDeviceFailed,
              key: const ValueKey<String>('ai-on-device-error'),
              style: AppTypography.secondary.copyWith(color: ink.error),
            ),
          ],
          const SizedBox(height: InkSpacing.s8),
          Text(context.l10n.settingsAiOnDevicePrivacy, style: note),
        ],
      ),
    );
  }

  Widget _buildApiKey() {
    final InkColors ink = InkColors.of(context);
    final Widget keyLabel = Text(
      context.l10n.settingsAiApiKey,
      style: AppTypography.body.copyWith(color: ink.fg),
    );
    final Widget keyNote = Text(
      context.l10n.settingsAiApiKeySubtitle,
      style: AppTypography.secondary.copyWith(color: ink.fg2),
    );
    return _Block(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (_controller.hasStoredKey) ...<Widget>[
            Row(
              children: <Widget>[
                Expanded(child: keyLabel),
                Text(
                  _controller.maskedKey ?? '',
                  key: const ValueKey<String>('ai-masked-key'),
                  style: AppTypography.code.copyWith(color: ink.fg),
                ),
                InkButton.text(
                  key: const ValueKey<String>('ai-remove-key'),
                  label: context.l10n.settingsAiApiKeyRemove,
                  onPressed: _removeKey,
                ),
              ],
            ),
            const SizedBox(height: InkSpacing.group),
            keyNote,
          ] else ...<Widget>[
            keyLabel,
            const SizedBox(height: InkSpacing.group),
            keyNote,
            const SizedBox(height: InkSpacing.headingGap),
            TextField(
              key: const ValueKey<String>('ai-api-key-field'),
              controller: _apiKey,
              focusNode: _apiKeyFocus,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              enableIMEPersonalizedLearning: false,
              autofillHints: null,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _saveKey(),
              decoration: InputDecoration(
                labelText: context.l10n.settingsAiApiKey,
                hintText: SettingsConstants.aiApiKeyHint,
              ),
            ),
            const SizedBox(height: InkSpacing.buttonGap),
            InkButton(
              key: const ValueKey<String>('ai-save-key'),
              label: context.l10n.settingsAiApiKeySave,
              expand: true,
              onPressed: _saveKey,
            ),
          ],
          if (_controller.keyError case final AiKeyError error) ...<Widget>[
            const SizedBox(height: InkSpacing.s8),
            Text(
              _keyErrorMessage(error),
              key: const ValueKey<String>('ai-key-error'),
              style: AppTypography.secondary.copyWith(color: ink.error),
            ),
          ],
          if (_controller.keyJustSaved) ...<Widget>[
            const SizedBox(height: InkSpacing.s8),
            Text(
              context.l10n.settingsAiApiKeySaved,
              key: const ValueKey<String>('ai-key-saved'),
              style: AppTypography.secondary.copyWith(color: ink.action),
            ),
          ],
        ],
      ),
    );
  }

  String _keyErrorMessage(AiKeyError error) => switch (error) {
    AiKeyError.invalid => context.l10n.settingsAiApiKeyInvalid,
    AiKeyError.unreadable => context.l10n.settingsAiApiKeyUnreadable,
    AiKeyError.storage => context.l10n.settingsAiApiKeyStorageError,
  };

  Widget _buildConnection() {
    final InkColors ink = InkColors.of(context);
    final AiConnectionResult? connection = _controller.lastConnection;
    return _Block(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _ActionWithProgress(
            busy: _controller.testingConnection,
            button: InkButton.secondary(
              key: const ValueKey<String>('ai-test-connection'),
              label: _controller.testingConnection
                  ? context.l10n.settingsAiTestingConnection
                  : context.l10n.settingsAiTestConnection,
              onPressed:
                  _controller.testingConnection || !_controller.hasStoredKey
                  ? null
                  : _controller.testConnection,
            ),
          ),
          if (connection is AiConnectionOk) ...<Widget>[
            const SizedBox(height: InkSpacing.s8),
            Text(
              context.l10n.settingsAiConnectionOk(connection.modelCount),
              key: const ValueKey<String>('ai-connection-ok'),
              style: AppTypography.secondary.copyWith(color: ink.action),
            ),
          ],
          if (connection is AiConnectionFailure) ...<Widget>[
            const SizedBox(height: InkSpacing.s8),
            Text(
              context.l10n.settingsAiConnectionFailed(
                context.l10n.aiFailureMessage(
                  connection.reason,
                  connection.message,
                ),
              ),
              key: const ValueKey<String>('ai-connection-error'),
              style: AppTypography.secondary.copyWith(color: ink.error),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildModels() {
    final InkColors ink = InkColors.of(context);
    final List<AiModelDescriptor> models = _controller.availableModels;
    final TextStyle note = AppTypography.secondary.copyWith(color: ink.fg2);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _Block(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _ActionWithProgress(
                busy: _controller.loadingModels,
                button: InkButton.secondary(
                  key: const ValueKey<String>('ai-load-models'),
                  label: context.l10n.settingsAiModelsLoad,
                  icon: InkIcons.download,
                  onPressed:
                      _controller.loadingModels || !_controller.hasStoredKey
                      ? null
                      : _controller.loadModels,
                ),
              ),
              if (!_controller.hasStoredKey) ...<Widget>[
                const SizedBox(height: InkSpacing.s8),
                Text(context.l10n.settingsAiModelsNeedsKey, style: note),
              ],
              if (_controller.modelsError
                  case final PaletteFailureReason reason) ...<Widget>[
                const SizedBox(height: InkSpacing.s8),
                Text(
                  context.l10n.aiFailureText(reason),
                  key: const ValueKey<String>('ai-models-error'),
                  style: AppTypography.secondary.copyWith(color: ink.error),
                ),
              ],
              if (models.isEmpty &&
                  _controller.modelsLoaded &&
                  _controller.modelsError == null) ...<Widget>[
                const SizedBox(height: InkSpacing.s8),
                Text(context.l10n.settingsAiModelsEmpty, style: note),
              ],
            ],
          ),
        ),
        const Divider(),
        InkListRow(
          key: const ValueKey<String>('ai-text-model-row'),
          label: context.l10n.settingsAiPrimaryModel,
          // The model name and id can be long: they get their own lines
          // under the label, in full.
          subtitle: _modelLabel(_controller.textModel),
          chevron: true,
          onTap: () =>
              showAiModelPicker(context, controller: _controller, multi: false),
        ),
        const Divider(),
        InkListRow(
          key: const ValueKey<String>('ai-fallbacks-row'),
          label: context.l10n.settingsAiFallbacksTitle,
          value: context.l10n.settingsAiFallbacksCount(
            _controller.textFallbacks.length,
            AiSettings.maxFallbacks,
          ),
          chevron: true,
          onTap: () =>
              showAiModelPicker(context, controller: _controller, multi: true),
        ),
        Padding(
          padding: InkSpacing.card,
          child: Text(
            _controller.usingRecommendedDefaults
                ? '${context.l10n.settingsAiRecommendedDefault}. '
                      '${context.l10n.settingsAiFreeModelsNote}'
                : context.l10n.settingsAiFreeModelsNote,
            key: const ValueKey<String>('ai-free-models-note'),
            style: note,
          ),
        ),
      ],
    );
  }

  /// The display name of [id] when it is in the loaded catalog, else the id.
  String _modelLabel(String id) {
    if (id.trim().isEmpty) return context.l10n.settingsAiModelNone;
    for (final AiModelDescriptor model in _controller.allModels) {
      if (model.id == id) return model.name;
    }
    return id;
  }

  Widget _buildTemperature() {
    final InkColors ink = InkColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                context.l10n.settingsAiTemperature,
                style: AppTypography.body.copyWith(color: ink.fg),
              ),
            ),
            Text(
              _controller.temperature.toStringAsFixed(2),
              style: AppTypography.data.copyWith(color: ink.fg2),
            ),
          ],
        ),
        Slider(
          value: _controller.temperature.clamp(0, 1),
          min: 0,
          max: 1,
          divisions: 20,
          label: _controller.temperature.toStringAsFixed(2),
          onChanged: _controller.setTemperature,
        ),
      ],
    );
  }

  Widget _buildMaxTokens() {
    return TextField(
      controller: _maxTokens,
      focusNode: _maxTokensFocus,
      keyboardType: TextInputType.number,
      onChanged: _onMaxTokens,
      decoration: InputDecoration(
        labelText: context.l10n.settingsAiMaxTokens,
        hintText: SettingsConstants.aiMaxTokensHint,
      ),
    );
  }

  void _onMaxTokens(String raw) {
    final int? tokens = int.tryParse(raw.trim());
    if (tokens == null || tokens < 0) return;
    _controller.setMaxTokens(tokens);
  }
}

/// A padded block of controls inside the AI card.
class _Block extends StatelessWidget {
  const _Block({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: InkSpacing.card, child: child);
  }
}

/// A button with a small progress indicator beside it while it works.
class _ActionWithProgress extends StatelessWidget {
  const _ActionWithProgress({required this.button, required this.busy});

  final Widget button;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        button,
        if (busy) ...<Widget>[
          const SizedBox(width: InkSpacing.buttonGap),
          const SizedBox.square(
            dimension: InkGeometry.smallIcon,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ],
      ],
    );
  }
}
