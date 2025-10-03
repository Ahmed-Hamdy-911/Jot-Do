import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/colors/smart_app_color.dart';
import '../../../../core/widgets/components/components.dart';

class AuthExcitedText extends StatelessWidget {
  const AuthExcitedText({
    super.key,
    required this.title,
    required this.subtitle,
  });
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    final colors = SmartAppColor(context);
    return Center(
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppConstants.headlineMediumStyle(colors.textPrimary),
          ),
          Text(
            subtitle,
            style: AppConstants.bodyMediumStyle(colors.textSecondary),
          ),
          AppComponents.mediumVerticalSpace(),
        ],
      ),
    );
  }
}
