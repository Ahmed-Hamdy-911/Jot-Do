import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../core/widgets/buttons/custom_button.dart';
import '../../../../../core/widgets/components/components.dart';
import '../../../../../generated/l10n.dart';
import '../../cubits/recovery_code/recovery_code_cubit.dart';
import '../../cubits/recovery_code/recovery_code_state.dart';

class AlertDiscardRecoveryCode extends StatelessWidget {
  const AlertDiscardRecoveryCode({super.key});

  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    var screenSize = MediaQuery.of(context).size;
    return Center(
      child: Container(
        width: screenSize.width >= 600 ? 600 : screenSize.width * 0.95,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: colors.border),
          color: colors.backgroundScreen,
          borderRadius: BorderRadius.circular(AppConstants.kRadius),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close,
                    color: colors.reverseBackgroundColor,
                  ),
                ),
              ],
            ),
            Text(
              S.of(context).recovery_code_confirm_discard_title,
              textAlign: TextAlign.center,
              style: AppConstants.customStyle(
                color: colors.textPrimary,
                fontSize: AppConstants.bodyLarge,
                fontWeight: AppConstants.fontBold,
              ),
            ),
            AppComponents.mediumVerticalSpace(),
            Text(
              S.of(context).recovery_code_confirm_discard_text,
              textAlign: TextAlign.center,
              style: AppConstants.bodyMediumStyle(colors.textSecondary),
            ),
            AppComponents.largeVerticalSpace(),
            BlocBuilder<RecoveryCodeCubit, RecoveryCodeState>(
              builder: (context, state) {
                if (state is RecoveryCodeCreated) {
                  return CustomButton(
                    text: S.of(context).recovery_button_skip,
                    bgColor: colors.red,
                    style: AppConstants.bodyLargeStyle(colors.white),
                    onPressed: () async {
                      Navigator.pop(context);
                      await context
                          .read<RecoveryCodeCubit>()
                          .skipSavingRecovery(code: state.recoveryCode);
                    },
                  );
                }
                return Container();
              },
            ),
            AppComponents.mediumVerticalSpace(),
            CustomButton(
              text: S.of(context).cancel,
              bgColor: colors.backgroundScreen,
              borderColor: colors.border,
              style: AppConstants.bodyMediumStyle(colors.textPrimary),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
