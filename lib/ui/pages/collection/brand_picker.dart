import 'package:flutter/material.dart';

import '../../../app_scope.dart';
import '../../../core/models.dart';
import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/ink_sheet.dart';

/// Opens the brand picker in an [InkSheet]; choosing a brand applies it at
/// once and closes the sheet.
Future<void> showBrandPicker(
  BuildContext context, {
  required AppScope scope,
}) => showInkSheet<void>(
  context: context,
  builder: (BuildContext context) => BrandPickerSheet(scope: scope),
);

/// Every [MarkerBrand] as a row, the current one ticked. The brand list can
/// keep growing, so it lives behind the picker, never inline. Scrolls when
/// the list does not fit.
class BrandPickerSheet extends StatelessWidget {
  const BrandPickerSheet({super.key, required this.scope});

  /// The app services.
  final AppScope scope;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final InkColors ink = InkColors.of(context);
    final MarkerBrand current = scope.settings.brand;
    final double maxListHeight = MediaQuery.sizeOf(context).height * 0.6;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: InkSpacing.sheetCloseClearance),
          child: Semantics(
            header: true,
            child: Text(
              l10n.settingsBrandTitle,
              style: AppTypography.section.copyWith(color: ink.fg),
            ),
          ),
        ),
        const SizedBox(height: InkSpacing.block),
        Flexible(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: maxListHeight),
            child: ListView(
              key: const ValueKey<String>('brand-list'),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: <Widget>[
                for (final MarkerBrand brand in MarkerBrand.values)
                  _BrandRow(
                    key: ValueKey<String>('brand-${brand.id}'),
                    label: brand.label,
                    selected: brand == current,
                    onTap: () async {
                      final NavigatorState navigator = Navigator.of(context);
                      await scope.settings.setBrand(brand);
                      await navigator.maybePop();
                    },
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _BrandRow extends StatelessWidget {
  const _BrandRow({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    return Semantics(
      inMutuallyExclusiveGroup: true,
      checked: selected,
      button: true,
      excludeSemantics: true,
      label: label,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: InkGeometry.target),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: InkSpacing.s8),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    label,
                    style: AppTypography.body.copyWith(color: ink.fg),
                  ),
                ),
                SizedBox(
                  width: 32,
                  child: selected
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: InkIcon(
                            InkIcons.check,
                            size: InkGeometry.mediumIcon,
                            color: ink.action,
                          ),
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
