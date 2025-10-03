import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';
import '../../constants/colors/smart_app_color.dart';

class CustomListTitle extends StatelessWidget {
  const CustomListTitle({
    super.key,
    required this.title,
    this.subTitleText,
    this.leadingIcon,
    this.trailing,
    this.onTap,
    this.noTrailing = false,
    this.subTitleWidget,
    this.contentPadding,
    this.enabled = true,
    this.leading,
  });
  final String title;
  final String? subTitleText;
  final IconData? leadingIcon;
  final Widget? trailing;
  final Widget? subTitleWidget;
  final bool? noTrailing;
  final EdgeInsetsGeometry? contentPadding;
  final void Function()? onTap;
  final bool enabled;
  final Widget? leading;
  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    var titleCol = colors.textPrimary;
    var subTitleColor = colors.textSecondary;
    var iconColor = colors.textPrimary;
    return ListTile(
      leading: leading ?? Icon(leadingIcon, color: iconColor),
      enabled: enabled,
      contentPadding:
          contentPadding ?? const EdgeInsetsDirectional.only(end: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.kRadius),
      ),
      title: Text(title, style: AppConstants.settingItemsStyle(titleCol)),
      subtitle: subTitleWidget != null
          ? subTitleWidget
          : subTitleText == null
              ? null
              : Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(subTitleText!,
                      style: AppConstants.bodySmallStyle(subTitleColor)),
                ),
      trailing: noTrailing == true
          ? null
          : trailing == null
              ? Icon(Icons.arrow_forward_ios_sharp, color: iconColor)
              : trailing,
      onTap: onTap,
    );
  }
}
