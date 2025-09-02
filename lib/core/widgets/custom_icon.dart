import 'package:flutter/material.dart';


class CustomIcon extends StatelessWidget {
  const CustomIcon({
    super.key,
    required this.noteColor,
    this.onTap,
    required this.icon,
    this.withValuesAlpha = 0.2,
  });

  final Color noteColor;
  final void Function()? onTap;
  final IconData icon;
  final double? withValuesAlpha;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        highlightColor: noteColor.withValues(alpha: 0.3),
        splashColor: noteColor.withValues(alpha: 0.3),
        child: Ink(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: withValuesAlpha),
          ),
          child: Icon(
            icon,
            size: 28,
            color: noteColor,
          ),
        ),
      ),
    );
  }
}
