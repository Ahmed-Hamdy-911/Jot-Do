import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../core/widgets/components/components.dart';

class OnBoardingItem extends StatelessWidget {
  const OnBoardingItem(
      {super.key,
      required this.icon,
      required this.title,
      required this.subTitle});
  final IconData icon;
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    final colors = SmartAppColor(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: colors.backgroundSecondary,
          radius: 20.r,
          child: Icon(
            icon,
            color: colors.primary,
            size: 20.r,
          ),
        ),
        AppComponents.mediumHorizontalSpace(),
        Expanded(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppConstants.bodyLargeStyle(colors.textPrimary),
                ),
                AppComponents.smallVerticalSpace(),
                Text(
                  subTitle,
                  style: AppConstants.bodyMediumStyle(colors.textSecondary),
                ),
              ]),
        )
      ],
    );
  }
}
