import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/cubits/settings/setting_cubit.dart';

class CustomSettingCard extends StatelessWidget {
  const CustomSettingCard({super.key, required this.child, this.cardColor});
  final Widget child;
  final Color? cardColor;
  @override
  Widget build(BuildContext context) {
    var darkMode =
        context.watch<SettingCubit>().state.themeMode == ThemeMode.dark;
    var color = darkMode ? AppColor.grey600 : AppColor.white70;
    return Card(
      color: cardColor ?? color,
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(vertical: 6.0),
        child: child,
      ),
    );
  }
}
