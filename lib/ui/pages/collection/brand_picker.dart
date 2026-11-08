import 'package:flutter/material.dart';

import '../../../app_scope.dart';
import '../../../core/models.dart';
import '../../../l10n/l10n.dart';
import '../../theme/app_typography.dart';
import '../../theme/tokens.dart';
import '../../widgets/brand_list.dart';
import '../../widgets/ink_sheet.dart';
import 'owned_brands.dart';

/// Opens the brand picker in an [InkSheet]; choosing a brand applies it at
/// once and closes the sheet.
///
/// What the user owns of each brand is read before the sheet opens, so the
/// "Your brands" group is there from the first frame and no row moves.
///
/// A second tap while the counts load (or the sheet is open) does nothing, so
/// the sheet never opens twice.
Future<void> showBrandPicker(
  BuildContext context, {
  required AppScope scope,
}) async {
  final NavigatorState navigator = Navigator.of(context);
  if (_brandPickerOpen[navigator] ?? false) return;
  _brandPickerOpen[navigator] = true;
  try {
    final Map<MarkerBrand, OwnedBrandCount> owned = await loadOwnedBrands(
      scope,
    );
    if (!context.mounted) return;
    await showInkSheet<void>(
      context: context,
      builder: (BuildContext context) =>
          BrandPickerSheet(scope: scope, owned: owned),
    );
  } finally {
    _brandPickerOpen[navigator] = false;
  }
}

/// Whether [showBrandPicker] is loading or showing the sheet, per navigator.
final Expando<bool> _brandPickerOpen = Expando<bool>('brandPickerOpen');

/// Share of the screen height the search field and the brand rows take. The
/// sheet is this tall whatever the search leaves, so filtering never makes it
/// jump; it only gets shorter when the screen (or the keyboard) leaves less.
const double brandPickerHeightFactor = 0.7;

/// Every [MarkerBrand], found by name: a search field, the brands the user
/// owns, the popular brands and the rest (see [BrandList]), the current one
/// ticked. The brand list can keep growing, so it lives behind the picker,
/// never inline.
class BrandPickerSheet extends StatelessWidget {
  const BrandPickerSheet({
    super.key,
    required this.scope,
    this.owned = const <MarkerBrand, OwnedBrandCount>{},
  });

  /// The app services.
  final AppScope scope;

  /// What the user owns, per brand (see `loadOwnedBrands`).
  final Map<MarkerBrand, OwnedBrandCount> owned;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final InkColors ink = InkColors.of(context);
    final MarkerBrand current = scope.settings.brand;
    final double listHeight =
        MediaQuery.sizeOf(context).height * brandPickerHeightFactor;
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
        // A fixed height: the rows scroll inside it, the search field stays.
        Flexible(
          child: SizedBox(
            height: listHeight,
            child: BrandList(
              scrollable: true,
              listKey: const ValueKey<String>('brand-list'),
              selected: current,
              owned: owned,
              rowKey: (MarkerBrand brand) =>
                  ValueKey<String>('brand-${brand.id}'),
              onSelected: (MarkerBrand brand) async {
                final NavigatorState navigator = Navigator.of(context);
                await scope.settings.setBrand(brand);
                await navigator.maybePop();
              },
            ),
          ),
        ),
      ],
    );
  }
}
