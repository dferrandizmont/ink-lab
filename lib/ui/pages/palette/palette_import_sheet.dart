import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData;

import '../../../core/palette_text.dart';
import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/page_header.dart';

/// "Import from text": a sheet to paste a palette shared as text (or a plain
/// list of marker codes) and load it.
///
/// The sheet only gathers the text. [onImport] reads it and either loads the
/// palette, answering `null` (the sheet closes), or answers why it could not,
/// which the sheet shows under the field and keeps open so the text can be
/// fixed. An empty answer keeps the sheet open with nothing to say: the user
/// chose not to replace the palette on screen, and the text is still there.
/// The text comes from the clipboard (the "Paste" button, only on a tap) or
/// from typing; nothing is read in the background.
class PaletteImportSheet extends StatefulWidget {
  const PaletteImportSheet({super.key, required this.onImport});

  /// Loads the palette in the text; returns the reason when it cannot (an
  /// empty one when the user decided not to load it).
  final Future<String?> Function(String text) onImport;

  @override
  State<PaletteImportSheet> createState() => _PaletteImportSheetState();
}

class _PaletteImportSheetState extends State<PaletteImportSheet> {
  /// The line height of the error text and how many lines its slot holds.
  static const double _errorLine = 20;
  static const int _errorLines = 4;

  /// What the field holds at most: one character more than the parser
  /// reads, so the parser can tell a text that was cut and leave out the
  /// code the cut fell in (see `PaletteText.parse`).
  static const int _fieldLength = PaletteText.maxLength + 1;

  final TextEditingController _controller = TextEditingController();
  String? _error;

  /// The text is being read (the question about the palette on screen may be
  /// open): a second tap must not load it twice.
  bool _loading = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _paste() async {
    ClipboardData? data;
    try {
      data = await Clipboard.getData(Clipboard.kTextPlain);
    } catch (_) {
      // No clipboard to read: the field stays as it is.
    }
    String? text = data?.text;
    if (!mounted || text == null || text.trim().isEmpty) return;
    // Only what the parser reads: a pasted wall of text is cut.
    if (text.length > _fieldLength) text = text.substring(0, _fieldLength);
    _controller.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
    setState(() => _error = null);
  }

  Future<void> _load() async {
    if (_loading) return;
    _loading = true;
    final String? reason;
    try {
      reason = await widget.onImport(_controller.text);
    } finally {
      _loading = false;
    }
    if (!mounted) return;
    if (reason == null) {
      Navigator.of(context).maybePop();
      return;
    }
    // An empty reason: the user kept the palette on screen. Nothing to say.
    final String? message = reason.isEmpty ? null : reason;
    setState(() => _error = message);
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations t = context.l10n;
    final InkColors ink = InkColors.of(context);
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            // Room for the sheet's close button.
            padding: const EdgeInsets.only(
              right: InkSpacing.sheetCloseClearance,
            ),
            child: InkSectionHeading(t.paletteImportTitle),
          ),
          const SizedBox(height: InkSpacing.group),
          Text(
            t.paletteImportHint,
            style: AppTypography.secondary.copyWith(color: ink.fg2),
          ),
          const SizedBox(height: InkSpacing.block),
          TextField(
            key: const ValueKey<String>('palette-import-field'),
            controller: _controller,
            minLines: 4,
            maxLines: 4,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            maxLength: _fieldLength,
            // The counter would add a line under the field: not shown.
            buildCounter: (
              BuildContext context, {
              required int currentLength,
              required bool isFocused,
              required int? maxLength,
            }) => null,
            autocorrect: false,
            enableSuggestions: false,
            style: AppTypography.code.copyWith(color: ink.fg),
            onChanged: (_) {
              if (_error != null) setState(() => _error = null);
            },
          ),
          // The slot of the error is always there, as tall as four lines of
          // text, so nothing moves when an error appears.
          SizedBox(
            height:
                MediaQuery.textScalerOf(context).scale(_errorLine) *
                    _errorLines +
                InkSpacing.block,
            child: _error == null
                ? null
                : Padding(
                    padding: const EdgeInsets.only(top: InkSpacing.block),
                    child: Row(
                      key: const ValueKey<String>('palette-import-error'),
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        InkIcon(
                          InkIcons.alertCircle,
                          size: InkGeometry.mediumIcon,
                          color: ink.error,
                        ),
                        const SizedBox(width: InkSpacing.buttonGap),
                        Expanded(
                          child: Text(
                            _error!,
                            style: AppTypography.secondary.copyWith(
                              color: ink.fg,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          const SizedBox(height: InkSpacing.block),
          // One under the other, each the full width: a label never has to
          // fit half a row, in any language or text size.
          InkButton.secondary(
            key: const ValueKey<String>('palette-import-paste'),
            label: t.paletteImportPaste,
            icon: InkIcons.copy,
            expand: true,
            onPressed: _paste,
          ),
          const SizedBox(height: InkSpacing.buttonGap),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: _controller,
            builder: (BuildContext context, TextEditingValue value, _) =>
                InkButton(
                  key: const ValueKey<String>('palette-import-load'),
                  label: t.paletteImportAction,
                  expand: true,
                  onPressed: value.text.trim().isEmpty ? null : _load,
                ),
          ),
        ],
      ),
    );
  }
}
