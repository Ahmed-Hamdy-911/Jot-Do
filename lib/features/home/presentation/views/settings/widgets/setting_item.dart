import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/cubits/settings/setting_cubit.dart';

class CustomSettingItem extends StatelessWidget {
  const CustomSettingItem({
    super.key,
    required this.title,
    this.subTitleText,
    required this.leadingIcon,
    this.trailing,
    this.onTap,
    this.noTrailing = false,
    this.subTitleWidget,
    this.contentPadding,
    this.enabled = true,
  });
  final String title;
  final String? subTitleText;
  final IconData leadingIcon;
  final Widget? trailing;
  final Widget? subTitleWidget;
  final bool? noTrailing;
  final EdgeInsetsGeometry? contentPadding;
  final void Function()? onTap;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    var darkMode =
        context.watch<SettingCubit>().state.themeMode == ThemeMode.dark;
    var titleCol = darkMode ? AppColor.whiteColor : AppColor.blackColor;
    var subTitleColor = darkMode ? AppColor.white70 : AppColor.grey600;
    var iconColor = darkMode ? AppColor.white70 : AppColor.blackColor;
    return ListTile(
      leading: Icon(leadingIcon, color: iconColor),
      enabled: enabled,
      contentPadding: contentPadding,
      title: Text(title, style: TextStyle(color: titleCol, fontSize: 15)),
      subtitle: subTitleWidget != null
          ? subTitleWidget
          : subTitleText == null
              ? null
              : Text(subTitleText!,
                  style: TextStyle(color: subTitleColor, fontSize: 13)),
      trailing: noTrailing == true
          ? null
          : trailing == null
              ? Icon(Icons.arrow_forward_ios_sharp, color: iconColor)
              : trailing,
      onTap: onTap,
    );
  }
}
