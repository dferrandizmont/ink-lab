import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app_scope.dart';
import '../../../data/data.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/ink_button.dart';
import 'backup_file_io.dart';
import 'dialogs.dart';
import 'settings_widgets.dart';
import '../../../l10n/l10n.dart';

/// The export and the import of the user data.
///
/// Renders the row of the "Your data" card; the page owns the group.
class BackupSection extends StatefulWidget {
  const BackupSection({
    super.key,
    required this.scope,
    this.fileIo = const SystemBackupFileIo(),
  });

  /// The app services.
  final AppScope scope;

  /// The share sheet and the file picker of the backup file (tests inject a
  /// fake).
  final BackupFileIo fileIo;

  @override
  State<BackupSection> createState() => _BackupSectionState();
}

/// What the backup file is busy with.
enum _FileWork { saving, restoring }

class _BackupSectionState extends State<BackupSection> {
  AppScope get scope => widget.scope;

  /// The backup file work in progress, or `null`. While it runs the two file
  /// buttons are off, so a second tap cannot start a second backup.
  _FileWork? _work;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final _FileWork? work = _work;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SettingsControlRow(
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
        ),
        // What the backup holds, and that photos are not part of it.
        SettingsCaption(
          context.l10n.settingsBackupSubtitle,
          textKey: const ValueKey<String>('settings-backup-caption'),
        ),
        // The same data in a ZIP file, with the diary photos.
        SettingsControlRow(
          label: l10n.settingsBackupFileTitle,
          stacked: true,
          caption: l10n.settingsBackupFileCaption,
          control: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              InkButton.secondary(
                key: const ValueKey<String>('settings-backup-file-save'),
                label: l10n.settingsSaveBackupFile,
                expand: true,
                loading: work == _FileWork.saving,
                onPressed: work == null ? _saveFile : null,
              ),
              const SizedBox(height: InkSpacing.buttonGap),
              InkButton.secondary(
                key: const ValueKey<String>('settings-backup-file-restore'),
                label: l10n.settingsRestoreBackupFile,
                expand: true,
                loading: work == _FileWork.restoring,
                onPressed: work == null ? _restoreFile : null,
              ),
              if (work != null)
                Semantics(
                  liveRegion: true,
                  child: Padding(
                    padding: const EdgeInsets.only(top: InkSpacing.group),
                    child: Text(
                      work == _FileWork.saving
                          ? l10n.settingsBackupFileSaving
                          : l10n.settingsBackupFileRestoring,
                      key: const ValueKey<String>(
                        'settings-backup-file-progress',
                      ),
                      style: AppTypography.secondary.copyWith(
                        color: InkColors.of(context).fg2,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  BackupArchiveService get _archiveService => BackupArchiveService(
    backup: _service,
    photos: scope.artworkDiary.photoStore,
  );

  /// Builds the ZIP with the data and the diary photos and hands it to the
  /// system share sheet.
  Future<void> _saveFile() async {
    final AppLocalizations l10n = context.l10n;
    setState(() => _work = _FileWork.saving);
    String? problem;
    try {
      final Uint8List bytes = await _archiveService.exportArchive();
      await widget.fileIo.shareBackup(bytes, backupFileName(DateTime.now()));
    } on BackupArchiveException catch (error) {
      problem = backupArchiveMessage(l10n, error);
    } catch (_) {
      problem = l10n.settingsBackupFileSaveFailed;
    }
    if (!mounted) return;
    setState(() => _work = null);
    if (problem != null) showMessage(context, problem);
  }

  /// Lets the user pick a backup ZIP, asks to replace the data and restores
  /// it, photos included.
  Future<void> _restoreFile() async {
    final AppLocalizations l10n = context.l10n;
    setState(() => _work = _FileWork.restoring);
    String? problem;
    String? done;
    BackupFilePick? pick;
    try {
      pick = await widget.fileIo.pickBackup();
      if (pick == null) {
        if (mounted) setState(() => _work = null);
        return;
      }
      if (pick.length > BackupArchiveService.defaultMaxArchiveBytes) {
        throw const BackupArchiveException(
          'the file is bigger than a backup may be',
          reason: BackupArchiveReason.tooLarge,
        );
      }
      final Uint8List bytes = await pick.read();
      // A file that is not a ZIP is refused before the user is asked to
      // replace anything.
      if (!_looksLikeZip(bytes)) {
        throw const BackupArchiveException(
          'the file is not a ZIP archive',
          reason: BackupArchiveReason.notAnArchive,
        );
      }
      if (!mounted) return;
      setState(() => _work = null);
      final bool confirmed = await confirmAction(
        context,
        title: l10n.settingsImportConfirmTitle,
        body: l10n.settingsRestoreConfirmBody,
        confirmLabel: l10n.settingsImportConfirm,
      );
      if (!confirmed || !mounted) return;
      setState(() => _work = _FileWork.restoring);
      await _archiveService.importArchive(bytes);
      done = l10n.settingsBackupFileRestored;
    } on BackupArchiveException catch (error) {
      problem = backupArchiveMessage(l10n, error);
    } on BackupFormatException catch (error) {
      problem = l10n.settingsImportFailed(
        error.field == null
            ? error.message
            : '${error.message} (${error.field})',
      );
    } catch (_) {
      problem = l10n.settingsBackupFileReadFailed;
    } finally {
      await pick?.discard();
    }
    if (!mounted) return;
    setState(() => _work = null);
    showMessage(context, problem ?? done ?? '');
  }

  /// Whether [bytes] start like a ZIP archive.
  static bool _looksLikeZip(Uint8List bytes) =>
      bytes.length >= 4 && bytes[0] == 0x50 && bytes[1] == 0x4B;

  BackupService get _service => BackupService(
    appSettings: scope.settings,
    savedPalettes: scope.savedPalettes,
    history: scope.matchHistory,
    aiSettings: scope.aiSettings,
    ownColors: scope.ownColors,
    wishlist: scope.wishlist,
    dried: scope.dried,
    artworkDiary: scope.artworkDiary,
    ideaFavorites: scope.ideaFavorites,
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

/// The short message for a backup archive that was refused.
///
/// Every [BackupArchiveReason] has its own text; an exception without a
/// reason (the document inside was refused) shows the reason it carries.
String backupArchiveMessage(
  AppLocalizations l10n,
  BackupArchiveException error,
) {
  return switch (error.reason) {
    BackupArchiveReason.notAnArchive => l10n.settingsBackupFileNotZip,
    BackupArchiveReason.tooLarge => l10n.settingsBackupFileTooLarge,
    BackupArchiveReason.entryTooLarge => l10n.settingsBackupFileEntryTooLarge,
    BackupArchiveReason.tooManyEntries ||
    BackupArchiveReason.badEntryName ||
    BackupArchiveReason.duplicateEntry => l10n.settingsBackupFileDamaged,
    BackupArchiveReason.unsupportedFormat => l10n.settingsBackupFileUnsupported,
    BackupArchiveReason.notAPhoto => l10n.settingsBackupFileNotAPhoto,
    BackupArchiveReason.writeFailed => l10n.settingsBackupFileWriteFailed,
    null => l10n.settingsImportFailed(
      error.field == null ? error.message : '${error.message} (${error.field})',
    ),
  };
}
