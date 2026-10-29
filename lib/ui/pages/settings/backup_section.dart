import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app_scope.dart';
import '../../../data/data.dart';
import '../../widgets/ink_button.dart';
import 'dialogs.dart';
import 'settings_widgets.dart';
import '../../../l10n/l10n.dart';

/// The export and the import of the user data.
///
/// Renders the row of the "Your data" card; the page owns the group.
class BackupSection extends StatelessWidget {
  const BackupSection({super.key, required this.scope});

  /// The app services.
  final AppScope scope;

  @override
  Widget build(BuildContext context) {
    return SettingsControlRow(
      label: context.l10n.settingsBackupTitle,
      control: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          InkButton(
            label: context.l10n.settingsExportBackup,
            variant: InkButtonVariant.smallSecondary,
            onPressed: () => _export(context),
          ),
          const SizedBox(width: 8),
          InkButton(
            label: context.l10n.settingsImportBackup,
            variant: InkButtonVariant.smallSecondary,
            onPressed: () => _import(context),
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }

  BackupService get _service => BackupService(
    appSettings: scope.settings,
    savedPalettes: scope.savedPalettes,
    history: scope.matchHistory,
    aiSettings: scope.aiSettings,
  );

  Future<void> _export(BuildContext context) async {
    final String json = _service.exportJson(pretty: true);
    await Clipboard.setData(ClipboardData(text: json));
    if (!context.mounted) return;
    showMessage(context, context.l10n.settingsBackupExported);
  }

  Future<void> _import(BuildContext context) async {
    final String? text = await showDialog<String>(
      context: context,
      builder: (BuildContext context) => const _ImportDialog(),
    );
    if (text == null || text.trim().isEmpty) return;
    if (!context.mounted) return;

    final String? problem = _validate(context, text);
    if (problem != null) {
      showMessage(context, problem);
      return;
    }

    final bool confirmed = await confirmAction(
      context,
      title: context.l10n.settingsImportConfirmTitle,
      body: context.l10n.settingsImportConfirmBody,
      confirmLabel: context.l10n.settingsImportConfirm,
    );
    if (!confirmed) return;

    try {
      await _service.importJson(text);
    } on BackupFormatException catch (error) {
      if (!context.mounted) return;
      showMessage(
        context,
        context.l10n.settingsImportFailed(
          error.field == null
              ? error.message
              : '${error.message} (${error.field})',
        ),
      );
      return;
    } catch (error) {
      if (!context.mounted) return;
      showMessage(context, context.l10n.settingsImportFailed('$error'));
      return;
    }
    if (!context.mounted) return;
    showMessage(context, context.l10n.settingsBackupImported);
  }

  /// Checks the pasted document before anything is replaced.
  ///
  /// Returns the message to show, or `null` when the document looks like a
  /// backup this build can read.
  String? _validate(BuildContext context, String text) {
    final Object? decoded;
    try {
      decoded = jsonDecode(text);
    } on FormatException {
      return context.l10n.settingsImportInvalidJson;
    }
    if (decoded is! Map) return context.l10n.settingsImportInvalidDocument;
    final Object? version = decoded[BackupService.versionField];
    if (version is! int) return context.l10n.settingsImportInvalidDocument;
    if (version < 1 || version > BackupService.currentVersion) {
      return context.l10n.settingsImportUnsupportedVersion(version);
    }
    return null;
  }
}

/// The dialog that asks for the backup to import.
class _ImportDialog extends StatefulWidget {
  const _ImportDialog();

  @override
  State<_ImportDialog> createState() => _ImportDialogState();
}

class _ImportDialogState extends State<_ImportDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.l10n.settingsImportTitle),
      content: SizedBox(
        width: double.maxFinite,
        child: TextField(
          controller: _controller,
          minLines: 4,
          maxLines: 8,
          decoration: InputDecoration(
            hintText: context.l10n.settingsImportHint,
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.l10n.settingsCancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(_controller.text),
          child: Text(context.l10n.settingsImportConfirm),
        ),
      ],
    );
  }
}
