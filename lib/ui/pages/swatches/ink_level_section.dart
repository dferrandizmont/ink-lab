import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show MaxLengthEnforcement;

import '../../../data/marker_extras_repository.dart';
import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/ink_chip.dart';
import 'swatch_marker_row.dart' show swatchTextHeight;

/// "Ink level" of an owned marker: three chips (full, running out, dried
/// out), exactly one on, and the refill note under them.
///
/// The three chips are always there and always the same size, whichever is
/// on; the note row is one row high with or without a note, so choosing a
/// level or writing a note never moves anything above or below.
class InkLevelSection extends StatelessWidget {
  const InkLevelSection({
    super.key,
    required this.level,
    required this.onChanged,
    required this.note,
    required this.onEditNote,
  });

  final InkLevel level;
  final ValueChanged<InkLevel>? onChanged;

  /// The refill note, or `null`.
  final String? note;
  final VoidCallback? onEditNote;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final AppLocalizations l10n = context.l10n;
    String labelOf(InkLevel value) => switch (value) {
      InkLevel.full => l10n.inkLevelFull,
      InkLevel.runningOut => l10n.commonRunningOut,
      InkLevel.dried => l10n.commonDried,
    };
    return Column(
      key: const ValueKey<String>('swatch-ink-level'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Semantics(
          header: true,
          child: Text(
            l10n.inkLevelTitle,
            style: AppTypography.body.copyWith(color: ink.fg),
          ),
        ),
        const SizedBox(height: InkSpacing.group),
        Wrap(
          spacing: InkSpacing.chipGap,
          runSpacing: 0,
          children: <Widget>[
            for (final InkLevel value in InkLevel.values)
              InkChip(
                key: ValueKey<String>('swatch-ink-${value.name}'),
                label: labelOf(value),
                selected: level == value,
                // Choosing the level that is on again does nothing: one
                // chip is always on.
                onSelected: onChanged == null
                    ? null
                    : (_) {
                        if (level != value) onChanged!(value);
                      },
                semanticLabel: labelOf(value),
              ),
          ],
        ),
        const SizedBox(height: InkSpacing.group),
        // What the level means. The three notes share the room of the
        // longest one, so choosing a level does not move the note row.
        _FixedHint(
          index: level.index,
          texts: <String>[
            l10n.inkLevelFullNote,
            l10n.inkLevelRunningOutNote,
            l10n.driedNote,
          ],
          keys: const <Key?>[
            ValueKey<String>('swatch-full-note'),
            ValueKey<String>('swatch-running-out-note'),
            ValueKey<String>('swatch-dried-note'),
          ],
        ),
        const SizedBox(height: InkSpacing.group),
        _NoteRow(note: note, onTap: onEditNote),
      ],
    );
  }
}

/// One of [texts] in `secondary`, in a box as high as the highest of them at
/// the width and text size it has.
class _FixedHint extends StatelessWidget {
  const _FixedHint({
    required this.index,
    required this.texts,
    required this.keys,
  });

  final int index;
  final List<String> texts;
  final List<Key?> keys;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final TextStyle style = AppTypography.secondary.copyWith(color: ink.fg2);
    final TextDirection direction = Directionality.of(context);
    final TextScaler scaler = MediaQuery.textScalerOf(context);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double height = 0;
        for (final String text in texts) {
          final TextPainter painter = TextPainter(
            text: TextSpan(text: text, style: style),
            textDirection: direction,
            textScaler: scaler,
          )..layout(maxWidth: constraints.maxWidth);
          if (painter.height > height) height = painter.height;
          painter.dispose();
        }
        return SizedBox(
          height: height,
          child: Align(
            alignment: AlignmentDirectional.topStart,
            child: Text(texts[index], key: keys[index], style: style),
          ),
        );
      },
    );
  }
}

/// The refill note: a row that opens the editor, like "My colour".
class _NoteRow extends StatelessWidget {
  const _NoteRow({required this.note, required this.onTap});

  final String? note;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final AppLocalizations l10n = context.l10n;
    return InkWell(
      key: const ValueKey<String>('swatch-refill-note-row'),
      onTap: onTap,
      borderRadius: InkRadii.controlRadius,
      // The row keeps the room of the sentence that invites to write a note,
      // so writing a short one does not shrink it.
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double textWidth =
              constraints.maxWidth -
              (InkGeometry.swatchRow +
                  InkSpacing.s12 +
                  InkSpacing.group +
                  InkGeometry.smallIcon);
          final double text = <String>[l10n.refillNoteEmpty, ?note]
              .map(
                (String t) => swatchTextHeight(
                  context,
                  t,
                  AppTypography.secondary,
                  textWidth,
                ),
              )
              .reduce((double x, double y) => x > y ? x : y);
          final double height =
              swatchTextHeight(
                context,
                l10n.refillNoteTitle,
                AppTypography.body,
                textWidth,
              ) +
              text;
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: height + InkSpacing.s8 > InkGeometry.rowTall
                  ? height + InkSpacing.s8
                  : InkGeometry.rowTall,
            ),
            child: _content(context, ink, l10n),
          );
        },
      ),
    );
  }

  Widget _content(BuildContext context, InkColors ink, AppLocalizations l10n) {
    return Row(
      children: <Widget>[
        SizedBox.square(
          dimension: InkGeometry.swatchRow,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: InkRadii.controlRadius,
              border: Border.all(color: ink.line),
            ),
            child: Center(
              child: InkIcon(
                InkIcons.edit3,
                size: InkGeometry.smallIcon,
                color: ink.fg2,
              ),
            ),
          ),
        ),
        const SizedBox(width: InkSpacing.s12),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                l10n.refillNoteTitle,
                style: AppTypography.body.copyWith(color: ink.fg),
              ),
              Text(
                note ?? l10n.refillNoteEmpty,
                key: const ValueKey<String>('swatch-refill-note-text'),
                style: AppTypography.secondary.copyWith(
                  color: note == null ? ink.fg2 : ink.fg,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: InkSpacing.group),
        InkIcon(
          InkIcons.chevronRight,
          size: InkGeometry.smallIcon,
          color: ink.fg2,
        ),
      ],
    );
  }
}

/// Asks for the refill note. Returns the text the user saved (empty to remove
/// the note), or `null` when the dialog is dismissed.
Future<String?> showRefillNoteDialog(
  BuildContext context, {
  required String? current,
}) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => _RefillNoteDialog(current: current),
  );
}

class _RefillNoteDialog extends StatefulWidget {
  const _RefillNoteDialog({required this.current});

  final String? current;

  @override
  State<_RefillNoteDialog> createState() => _RefillNoteDialogState();
}

class _RefillNoteDialogState extends State<_RefillNoteDialog> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.current ?? '',
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    return AlertDialog(
      key: const ValueKey<String>('swatch-refill-note-dialog'),
      title: Text(l10n.refillNoteTitle),
      content: TextField(
        key: const ValueKey<String>('swatch-refill-note-field'),
        controller: _controller,
        autofocus: true,
        maxLength: MarkerExtrasRepository.maxNoteLength,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        textInputAction: TextInputAction.done,
        onSubmitted: (String value) => Navigator.of(context).pop(value),
        decoration: InputDecoration(hintText: l10n.refillNoteHint),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.settingsCancel),
        ),
        if (widget.current != null)
          TextButton(
            key: const ValueKey<String>('swatch-refill-note-remove'),
            onPressed: () => Navigator.of(context).pop(''),
            child: Text(l10n.refillNoteRemove),
          ),
        FilledButton(
          key: const ValueKey<String>('swatch-refill-note-save'),
          onPressed: () => Navigator.of(context).pop(_controller.text),
          child: Text(l10n.refillNoteSave),
        ),
      ],
    );
  }
}
