import 'dart:async';

import 'package:flutter/material.dart';

import '../../../app_scope.dart';
import '../../../l10n/l10n.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/section_card.dart';
import 'dialogs.dart';

/// How many colours of their own the user has stored, with a way to reset
/// them all.
///
/// Renders a row of the "Colour matching" card; the page owns the group.
class OwnColorsSection extends StatefulWidget {
  const OwnColorsSection({super.key, required this.scope});

  /// The app services.
  final AppScope scope;

  @override
  State<OwnColorsSection> createState() => _OwnColorsSectionState();
}

class _OwnColorsSectionState extends State<OwnColorsSection> {
  late final Stream<Map<String, String>> _changes =
      widget.scope.ownColors.changes;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, String>>(
      stream: _changes,
      initialData: widget.scope.ownColors.colors,
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, String>> snapshot) {
            final int count =
                (snapshot.data ?? const <String, String>{}).length;
            return InkListRow(
              key: const ValueKey<String>('settings-own-colors-count'),
              label: context.l10n.settingsOwnColorsCount(count),
              trailing: count == 0
                  ? null
                  : InkButton.text(
                      key: const ValueKey<String>('settings-own-colors-reset'),
                      label: context.l10n.settingsOwnColorsReset,
                      onPressed: () => _reset(context),
                    ),
            );
          },
    );
  }

  Future<void> _reset(BuildContext context) async {
    final bool confirmed = await confirmAction(
      context,
      title: context.l10n.settingsOwnColorsResetTitle,
      body: context.l10n.settingsOwnColorsResetBody,
      confirmLabel: context.l10n.settingsOwnColorsReset,
    );
    if (!confirmed) return;
    await widget.scope.ownColors.clear();
  }
}
