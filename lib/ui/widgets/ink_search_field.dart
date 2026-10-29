import 'package:flutter/material.dart';

import '../icons/ink_icons.dart';
import '../theme/app_typography.dart';
import '../theme/tokens.dart';
import '../../l10n/l10n.dart';

/// The pill search field (spec §4 "Search field"): 48 high, padding 0 16,
/// `surface`, 1 px `strong` (`action` when focused), leading search icon 20
/// in `fg2`, gap 10, `body` input, `fg2` placeholder. A clear button appears
/// while there is text.
class InkSearchField extends StatefulWidget {
  const InkSearchField({
    super.key,
    this.controller,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.semanticLabel,
    this.focusNode,
    this.autofocus = false,
    this.textInputAction = TextInputAction.search,
  });

  final TextEditingController? controller;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  /// Called after the clear button empties the field.
  final VoidCallback? onClear;
  final String? semanticLabel;
  final FocusNode? focusNode;
  final bool autofocus;
  final TextInputAction textInputAction;

  @override
  State<InkSearchField> createState() => _InkSearchFieldState();
}

class _InkSearchFieldState extends State<InkSearchField> {
  TextEditingController? _own;

  TextEditingController get _controller =>
      widget.controller ?? (_own ??= TextEditingController());

  @override
  void dispose() {
    _own?.dispose();
    super.dispose();
  }

  void _clear() {
    _controller.clear();
    widget.onChanged?.call('');
    widget.onClear?.call();
  }

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    OutlineInputBorder border(Color color) => OutlineInputBorder(
      borderRadius: InkRadii.pillRadius,
      borderSide: BorderSide(color: color),
    );
    return Semantics(
      label: widget.semanticLabel,
      child: SizedBox(
        height: InkGeometry.fieldHeight,
        child: ValueListenableBuilder<TextEditingValue>(
          valueListenable: _controller,
          builder: (BuildContext context, TextEditingValue value, _) {
            return TextField(
              controller: _controller,
              focusNode: widget.focusNode,
              autofocus: widget.autofocus,
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
              textInputAction: widget.textInputAction,
              style: AppTypography.body.copyWith(color: ink.fg),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: widget.hintText,
                filled: true,
                fillColor: ink.surface,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 10),
                  child: InkIcon(
                    InkIcons.search,
                    size: InkGeometry.mediumIcon,
                    color: ink.fg2,
                  ),
                ),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 46,
                  minHeight: 20,
                ),
                suffixIcon: value.text.isEmpty
                    ? null
                    : IconButton(
                        tooltip: context.l10n.commonClearSearch,
                        onPressed: _clear,
                        icon: InkIcon(
                          InkIcons.x,
                          size: InkGeometry.mediumIcon,
                          color: ink.fg2,
                        ),
                      ),
                border: border(ink.strong),
                enabledBorder: border(ink.strong),
                focusedBorder: border(ink.action),
              ),
            );
          },
        ),
      ),
    );
  }
}
