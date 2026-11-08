import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';

/// Asks for a palette name.
///
/// The dialog owns its [TextEditingController] so it is disposed with the
/// widget, not while the route is still animating out.
class PaletteSaveNameDialog extends StatefulWidget {
  const PaletteSaveNameDialog({super.key, required this.initial});

  final String initial;

  @override
  State<PaletteSaveNameDialog> createState() => _SaveNameDialogState();
}

class _SaveNameDialogState extends State<PaletteSaveNameDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initial);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.l10n.paletteSaveDialogTitle),
      content: TextField(
        key: const ValueKey<String>('palette-name-field'),
        controller: _controller,
        autofocus: true,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          labelText: context.l10n.paletteSaveDialogHint,
        ),
        onSubmitted: (value) => Navigator.of(context).pop(value.trim()),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.l10n.paletteSaveDialogCancel),
        ),
        FilledButton(
          key: const ValueKey<String>('palette-save-confirm'),
          onPressed: () => Navigator.of(context).pop(_controller.text.trim()),
          child: Text(context.l10n.paletteSaveDialogConfirm),
        ),
      ],
    );
  }
}
