import 'package:flutter/material.dart';

import '../theme/tokens.dart';

/// The design G switch (spec §4 "Switch"): 52×32 track in a 44 hit area.
///
/// Off: 2 px `strong` border, `bg` fill, 16 `strong` thumb on the left.
/// On: `action` fill, no border, 24 `onAction` thumb on the right.
class InkSwitch extends StatelessWidget {
  const InkSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.semanticLabel,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final InkColors ink = InkColors.of(context);
    final Duration duration = InkMotion.accessible(
      context,
      InkMotion.crossFade,
    );
    final double thumb = value ? 24 : 16;
    return Semantics(
      toggled: value,
      enabled: onChanged != null,
      label: semanticLabel,
      child: InkResponse(
        onTap: onChanged == null ? null : () => onChanged!(!value),
        radius: 26,
        child: SizedBox(
          width: 60,
          height: InkGeometry.target,
          child: Center(
            child: AnimatedContainer(
              duration: duration,
              width: 52,
              height: 32,
              decoration: ShapeDecoration(
                color: value ? ink.action : ink.bg,
                shape: StadiumBorder(
                  side: value
                      ? BorderSide.none
                      : BorderSide(
                          color: ink.strong,
                          width: InkGeometry.switchBorder,
                        ),
                ),
              ),
              child: AnimatedAlign(
                duration: duration,
                curve: InkMotion.crossFadeCurve,
                alignment: value
                    ? const Alignment(0.71, 0)
                    : const Alignment(-0.56, 0),
                child: AnimatedContainer(
                  duration: duration,
                  width: thumb,
                  height: thumb,
                  decoration: ShapeDecoration(
                    color: value ? ink.onAction : ink.strong,
                    shape: const CircleBorder(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
