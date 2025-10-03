import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';
import '../../constants/colors/smart_app_color.dart';
import '../components/components.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.child, this.title});
  final Widget child;
  final String? title;
  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    var color = colors.backgroundScreen;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title!,
            style: AppConstants.bodyMediumStyle(colors.textPrimary),
          ),
        if (title != null) AppComponents.mediumVerticalSpace(),
        Ink(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(AppConstants.kRadius),
            border: Border.all(color: colors.grey.withValues(alpha: 0.3)),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.all(12),
            child: child,
          ),
        ),
      ],
    );
  }
}
