import 'package:flutter/material.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../core/widgets/components/components.dart';
import '../../../../../generated/l10n.dart';

class WaringRecoveryCodeWidget extends StatelessWidget {
  const WaringRecoveryCodeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: colors.warning.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(AppConstants.kRadius),
        border: Border.all(color: colors.warning.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: colors.warning,
          ),
          AppComponents.mediumHorizontalSpace(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).recovery_code_warning_title,
                  textAlign: TextAlign.start,
                  style: AppConstants.customStyle(
                    color: colors.orange,
                    fontSize: AppConstants.bodyLarge,
                    fontWeight: AppConstants.fontBold,
                    height: 1.3,
                  ),
                ),
                AppComponents.smallVerticalSpace(),
                Text(
                  S.of(context).recovery_code_warning_text +
                      '\n' +
                      S.of(context).recovery_code_warning_short,
                  textAlign: TextAlign.start,
                  style: AppConstants.bodyMediumStyle(colors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
