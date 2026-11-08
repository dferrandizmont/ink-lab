import 'package:flutter/material.dart';

import '../../../core/color_vision.dart';
import 'palette_vision.dart';

/// The colour vision preview (spec §2.2) inside a sheet: it holds the picked
/// vision while the sheet is open and reports every change, so the page draws
/// the palette on screen simulated as it is chosen.
class PaletteVisionSheet extends StatefulWidget {
  const PaletteVisionSheet({
    super.key,
    required this.initial,
    required this.hexes,
    required this.codes,
    required this.onChanged,
    this.initialValues = false,
    this.onValuesChanged,
  });

  /// The vision the page is previewing when the sheet opens.
  final ColorVisionType? initial;

  /// Whether the page is previewing the value (greyscale) view.
  final bool initialValues;

  /// Turns the value view on or off. Choosing a vision turns it off.
  final ValueChanged<bool>? onValuesChanged;

  /// The true colours of the palette on screen.
  final List<String> hexes;

  /// The marker codes of [hexes], to name the pairs.
  final List<String> codes;

  final ValueChanged<ColorVisionType?> onChanged;

  @override
  State<PaletteVisionSheet> createState() => _VisionSheetState();
}

class _VisionSheetState extends State<PaletteVisionSheet> {
  ColorVisionType? _vision;
  bool _values = false;

  @override
  void initState() {
    super.initState();
    _vision = widget.initial;
    _values = widget.initialValues;
  }

  @override
  Widget build(BuildContext context) {
    return PaletteVisionControl(
      key: const ValueKey<String>('palette-vision'),
      selected: _vision,
      onChanged: (ColorVisionType? type) {
        setState(() {
          _vision = type;
          _values = false;
        });
        widget.onChanged(type);
      },
      values: _values,
      onValuesChanged: widget.onValuesChanged == null
          ? null
          : (bool on) {
              setState(() {
                _values = on;
                if (on) _vision = null;
              });
              widget.onValuesChanged!(on);
            },
      colors: widget.hexes,
      labels: widget.codes,
    );
  }
}
