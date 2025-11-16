import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../core/widgets/buttons/custom_button.dart';
import '../../../../../core/widgets/components/components.dart';
import '../../../../../generated/l10n.dart';
import '../../cubits/recovery_code/recovery_code_cubit.dart';
import 'alert_discard_recovery_code_widget.dart';

class ActionButtons extends StatefulWidget {
  const ActionButtons({
    super.key,
  });

  @override
  State<ActionButtons> createState() => _ActionButtonsState();
}

class _ActionButtonsState extends State<ActionButtons> {
  bool _isSaved = false;
  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    return Column(
      children: [
        Ink(
          decoration: BoxDecoration(
            border: Border.all(color: colors.border),
            borderRadius: BorderRadius.circular(AppConstants.kRadius),
          ),
          child: CheckboxListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.kRadius),
            ),
            value: _isSaved,
            onChanged: (value) {
              setState(() {
                _isSaved = value!;
              });
            },
            fillColor: _isSaved
                ? WidgetStatePropertyAll(colors.blue)
                : WidgetStatePropertyAll(colors.grey.withValues(alpha: 0.3)),
            checkboxShape: const CircleBorder(),
            side: _isSaved ? BorderSide.none : BorderSide(color: colors.border),
            checkColor: colors.white,
            splashRadius: AppConstants.kRadius,
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(
              S.of(context).radio_recovery_code_title,
              style: AppConstants.customStyle(
                  color: colors.textPrimary,
                  fontSize: AppConstants.bodyMedium,
                  fontWeight: AppConstants.fontBold),
            ),
          ),
        ),
        AppComponents.mediumVerticalSpace(),
        Column(
          children: [
            CustomButton(
              text: S.of(context).recovery_button_save_it,
              bgColor:
                  _isSaved ? colors.blue : colors.blue.withValues(alpha: 0.5),
              style: AppConstants.buttonPrimaryStyle(colors.white),
              onPressed: _isSaved
                  ? () {
                      context.read<RecoveryCodeCubit>().acknowledgeSaved();
                    }
                  : null,
            ),
            AppComponents.smallVerticalSpace(),
            CustomButton(
              text: S.of(context).recovery_button_remind_me_later,
              bgColor: colors.backgroundScreen,
              style: AppConstants.buttonPrimaryStyle(colors.textPrimary),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (dialogContext) => BlocProvider.value(
                    value: context.read<RecoveryCodeCubit>(),
                    child: const AlertDiscardRecoveryCode(),
                  ),
                );
              },
            ),
          ],
        )
      ],
    );
  }
}
