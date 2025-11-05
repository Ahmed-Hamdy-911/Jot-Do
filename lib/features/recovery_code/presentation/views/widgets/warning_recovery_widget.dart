import 'package:flutter/material.dart';

import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../generated/l10n.dart';
import 'alert_recovery_widget.dart';

class WarningRecoveryCodeWidget extends StatelessWidget {
  const WarningRecoveryCodeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    return AlertRecoveryWidget(
      title: S.of(context).recovery_code_warning_title,
      description: S.of(context).recovery_code_instruction +
                      '\n' +
                      S.of(context).recovery_code_warning_text +
                      '\n' +
                      S.of(context).recovery_info_description,
                      bgColor: colors.warning.withValues(alpha: 0.1),
                      iconColor: colors.warning,
                      borderColor: colors.warning,
    );
  }
}

