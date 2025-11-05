import 'package:flutter/material.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../core/widgets/components/components.dart';

class AlertRecoveryWidget extends StatelessWidget {
  const AlertRecoveryWidget({
    super.key,
    this.title,
    required this.description,
    this.icon,
    required this.bgColor,
    this.iconColor,
    this.borderColor,
    this.textColor,
  });
  final String? title;
  final String description;
  final IconData? icon;
  final Color bgColor;
  final Color? iconColor;
  final Color? borderColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    return Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsetsDirectional.only(top: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppConstants.kRadius),
        border: Border.all(color: borderColor ?? bgColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon ?? Icons.warning_amber_sharp,
            color: iconColor ?? bgColor,
          ),
          AppComponents.mediumHorizontalSpace(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) ...[
                  Text(
                    title!,
                    style: AppConstants.customStyle(
                      color: textColor ?? iconColor!,
                      fontSize: AppConstants.scaledSp(15),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  AppComponents.smallVerticalSpace(),
                ],
                Text(
                  description,
                  style: AppConstants.bodySmallStyle(colors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
