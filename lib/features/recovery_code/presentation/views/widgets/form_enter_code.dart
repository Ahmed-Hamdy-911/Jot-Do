import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../core/widgets/buttons/custom_button.dart';
import '../../../../../core/widgets/components/components.dart';
import '../../../../../core/widgets/custom_fields/custom_text_form.dart';
import '../../../../../generated/l10n.dart';

class FormEnterCode extends StatefulWidget {
  const FormEnterCode({super.key});

  @override
  State<FormEnterCode> createState() => _FormEnterCodeState();
}

class _FormEnterCodeState extends State<FormEnterCode> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: 8,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: colors.border),
        color: colors.backgroundSecondary.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(AppConstants.kRadius),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).recoveryCode,
              style: AppConstants.bodyLargeStyle(colors.textPrimary),
            ),
            Text(
              S.of(context).recoveryCodeDescription,
              style: AppConstants.bodyMediumStyle(colors.textSecondary),
            ),
            AppComponents.smallVerticalSpace(),
            CustomTextFormField(
              controller: _codeController,
              hintText: "For example: ABCD-1234-EFGH-5678-IJKL",
              filled: true,
              fillColor: colors.reverseBackgroundColor.withValues(alpha: 0.1),
              contentPadding: const EdgeInsetsDirectional.symmetric(
                horizontal: 12,
                vertical: 16,
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(41),
              ],
              keyboardType: TextInputType.text,
              validator: (value) => null,
            ),
            AppComponents.mediumVerticalSpace(),
            CustomButton(
              text: S.of(context).restoreData,
              bgColor: colors.reverseBackgroundColor,
              style: AppConstants.buttonPrimaryStyle(colors.reverseTextColor),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
