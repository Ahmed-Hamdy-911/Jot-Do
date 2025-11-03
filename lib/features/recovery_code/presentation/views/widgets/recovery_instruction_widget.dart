import 'package:flutter/material.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../core/widgets/components/components.dart';
import '../../../../../generated/l10n.dart';

class RecoveryInstructionWidget extends StatelessWidget {
  const RecoveryInstructionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    return Column(
      children: [
        Text(
          S.of(context).recovery_code_subtitle,
          style: AppConstants.customStyle(
              color: colors.textPrimary,
              fontSize: AppConstants.headlineMedium,
              fontWeight: AppConstants.fontSemiBold),
        ),
        AppComponents.mediumVerticalSpace(),
        Text(
          S.of(context).recovery_code_instruction,
          style: AppConstants.bodyMediumStyle(colors.grey),
        ),
      ],
    );
  }
}
