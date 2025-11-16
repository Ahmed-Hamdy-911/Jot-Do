import 'package:flutter/material.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../core/widgets/buttons/custom_button.dart';
import '../../../../../core/widgets/components/components.dart';

class BackupOptionItem extends StatelessWidget {
  const BackupOptionItem(
      {super.key,
      required this.title,
      required this.icon,
      required this.onPressed,
      this.bgColor});
  final String title;
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    return CustomButton(
      bgColor: bgColor ?? colors.backgroundScreen,
      borderColor: colors.transparent,
      onPressed: onPressed,
      text: '',
      widget: Row(
        children: [
          Icon(
            icon,
            color: colors.textPrimary,
          ),
          AppComponents.mediumHorizontalSpace(),
          Text(
            title,
            style: AppConstants.bodyMediumStyle(colors.textPrimary),
          ),
        ],
      ),
    );
  }
}
