import 'package:flutter/material.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../core/widgets/components/components.dart';
import '../../../../../generated/l10n.dart';

class SomeOtherInstructions extends StatelessWidget {
  const SomeOtherInstructions({super.key});

  @override
  Widget build(BuildContext context) {
    List instructions = [
      S.of(context).recoveryTip1,
      S.of(context).recoveryTip2,
      S.of(context).recoveryTip3
    ];
    var colors = SmartAppColor(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).cantFindRecoveryCode,
          style: AppConstants.customStyle(
              color: SmartAppColor(context).blue,
              fontSize: AppConstants.bodyLarge,
              fontWeight: AppConstants.fontSemiBold),
        ),
        AppComponents.smallVerticalSpace(),
        ...List.generate(
          instructions.length,
          (index) => Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 6,
                    backgroundColor: colors.blue,
                  ),
                  AppComponents.largeHorizontalSpace(),
                  Text(
                    instructions[index],
                    style: AppConstants.bodyMediumStyle(colors.textPrimary),
                  ),
                ],
              ),
              if (index != instructions.length - 1)
                AppComponents.smallVerticalSpace(),
            ],
          ),
        )
      ],
    );
  }
}
