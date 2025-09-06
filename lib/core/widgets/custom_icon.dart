import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/app_colors.dart';
import '../cubits/settings/setting_cubit.dart';

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
    var darkMode =
        context.watch<SettingCubit>().state.themeMode == ThemeMode.dark;
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
            color: darkMode
                ? AppColor.whiteColor.withValues(alpha: 0.3)
                : AppColor.whiteColor.withValues(alpha: withValuesAlpha),
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
