import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/cubits/settings/setting_cubit.dart';
import '../cubit/auth_cubit.dart';

class TogglePasswordVisibilityIcon extends StatelessWidget {
  final bool isConfirmField;
  const TogglePasswordVisibilityIcon({super.key, required this.isConfirmField});

  @override
  Widget build(BuildContext context) {
    var darkMode =
        context.watch<SettingCubit>().state.themeMode == ThemeMode.dark;
    var iconColor = darkMode ? AppColor.white70 : AppColor.greyColor;

    final cubit = context.watch<AuthCubit>();
    final isVisible = isConfirmField
        ? cubit.isConfirmPasswordVisible
        : cubit.isPasswordVisible;

    return IconButton(
      onPressed: () {
        if (isConfirmField) {
          context.read<AuthCubit>().toggleConfirmPasswordVisibility();
        } else {
          context.read<AuthCubit>().togglePasswordVisibility();
        }
      },
      icon: Icon(
        isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
        color: iconColor,
      ),
    );
  }
}
