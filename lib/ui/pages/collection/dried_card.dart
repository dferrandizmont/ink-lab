import 'package:flutter/material.dart';

import '../../../app_scope.dart';
import '../../../core/models.dart';
import '../../../core/natural_sort.dart';
import '../../../l10n/l10n.dart';
import '../../icons/ink_icons.dart';
import '../../theme/tokens.dart';
import '../../widgets/ink_button.dart';
import '../../widgets/ink_disclosure.dart';
import 'marker_status_row.dart';

/// The dried-out markers of the active brand in My collection: how many, what
/// it means, and a list (closed until opened) to mark each one usable again.
///
/// The count is the header of a folded [InkDisclosure] and the explanation is
/// its summary (spec §2.6).
class DriedCard extends StatefulWidget {
  const DriedCard({
    super.key,
    required this.brand,
    required this.catalog,
    required this.nameDisplayMode,
  });

  final MarkerBrand brand;

  /// The colours of [brand].
  final List<MarkerColor> catalog;

  final NameDisplayMode nameDisplayMode;

  @override
  State<DriedCard> createState() => _DriedCardState();
}

class _DriedCardState extends State<DriedCard> {
  AppScope? _scope;
  Stream<Set<String>>? _changes;
  bool _open = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final AppScope scope = AppScope.of(context);
    if (!identical(scope, _scope)) {
      _scope = scope;
      _changes = scope.dried.changes;
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppScope scope = _scope!;
    final InkColors ink = InkColors.of(context);
    return StreamBuilder<Set<String>>(
      stream: _changes,
      initialData: scope.dried.ids,
      builder: (BuildContext context, AsyncSnapshot<Set<String>> snapshot) {
        final List<String> ids = scope.dried.idsOf(widget.brand).toList()
          ..sort(
            (String a, String b) => naturalCodeComparator(
              a.substring(a.indexOf(':') + 1),
              b.substring(b.indexOf(':') + 1),
            ),
          );
        return InkDisclosure(
          key: const ValueKey<String>('dried-disclosure'),
          title: context.l10n.driedCount(ids.length),
          subtitle: ids.isEmpty
              ? context.l10n.driedEmpty
              : context.l10n.driedHint,
          expanded: _open,
          onToggle: () => setState(() => _open = !_open),
          child: ids.isEmpty
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.fromLTRB(
                    InkSpacing.cardH,
                    0,
                    InkSpacing.cardH,
                    InkSpacing.cardV,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      for (final String id in ids) ...<Widget>[
                        MarkerStatusRow(
                          key: ValueKey<String>('dried-row-$id'),
                          colorId: id,
                          color: findMarker(widget.catalog, id),
                          nameDisplayMode: widget.nameDisplayMode,
                          trailing: InkIconButton(
                            key: ValueKey<String>('dried-unmark-$id'),
                            icon: InkIcons.rotateCcw,
                            tooltip: context.l10n.driedUnmark,
                            onPressed: () => scope.dried.remove(id),
                          ),
                        ),
                        Divider(
                          height: InkGeometry.border,
                          thickness: InkGeometry.border,
                          color: ink.line,
                        ),
                      ],
                    ],
                  ),
                ),
        );
      },
    );
  }
}
