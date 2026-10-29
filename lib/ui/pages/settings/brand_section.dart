import 'package:flutter/material.dart';

import '../../../app_scope.dart';
import '../../../core/models.dart';
import '../../../data/data.dart';
import '../../widgets/ink_segmented.dart';
import 'settings_widgets.dart';
import '../../../l10n/l10n.dart';

/// The brand of the collection.
///
/// Renders the rows of the "Collection" card; the page owns the group.
class BrandSection extends StatelessWidget {
  const BrandSection({super.key, required this.scope, required this.state});

  /// The app services.
  final AppScope scope;

  /// The current settings snapshot.
  final AppSettingsState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SettingsControlRow(
          label: context.l10n.settingsBrandTitle,
          control: InkSegmented<MarkerBrand>(
            semanticLabel: context.l10n.settingsBrandTitle,
            segments: <InkSegment<MarkerBrand>>[
              InkSegment<MarkerBrand>(
                value: MarkerBrand.ohuhuOahu,
                label: MarkerBrand.ohuhuOahu.label,
              ),
              InkSegment<MarkerBrand>(
                value: MarkerBrand.decoTime,
                label: MarkerBrand.decoTime.label,
              ),
            ],
            selected: state.brand,
            onChanged: (MarkerBrand brand) => scope.settings.setBrand(brand),
          ),
        ),
        SettingsCaption(context.l10n.settingsBrandDecoTimeHint),
      ],
    );
  }
}
