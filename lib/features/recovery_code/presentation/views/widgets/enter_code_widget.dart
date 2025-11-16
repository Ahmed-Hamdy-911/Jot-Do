import 'package:flutter/material.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../core/routing/app_routes.dart';
import '../../../../../core/widgets/buttons/custom_button.dart';
import '../../../../../core/widgets/components/components.dart';
import '../../../../../generated/l10n.dart';
import 'alert_recovery_widget.dart';
import 'form_enter_code.dart';
import 'some_other_instruction_widget.dart';

class EnterCodeWidget extends StatelessWidget {
  const EnterCodeWidget();

  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    return ListView(
      padding: const EdgeInsets.all(12.0).copyWith(top: 0),
      children: [
        AppComponents.appBarPadding(context),
        AlertRecoveryWidget(
          title: S.of(context).recovery_info_title,
          description: S.of(context).recovery_lost_description,
          bgColor: colors.red.withValues(alpha: 0.1),
          iconColor: colors.red,
          borderColor: colors.red,
          textColor: colors.red,
        ),
        AlertRecoveryWidget(
          description: S.of(context).recoveryCodeLength,
          icon: Icons.check_circle_outline_outlined,
          bgColor: colors.backgroundSecondary,
          iconColor: colors.reverseBackgroundColor,
          textColor: colors.reverseBackgroundColor,
        ),
        AppComponents.mediumVerticalSpace(),
        const FormEnterCode(),
        AppComponents.largeVerticalSpace(),
        const SomeOtherInstructions(),
        AppComponents.mediumVerticalSpace(),
        CustomButton(
          text: S.of(context).recovery_code_remind_me_later,
          style: AppConstants.buttonPrimaryStyle(colors.white),
          bgColor: colors.red,
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.home,
              (route) => false,
            );
          },
        )
      ],
    );
  }
}
