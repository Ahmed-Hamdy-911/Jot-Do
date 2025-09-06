import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/cubits/settings/setting_cubit.dart';
import '../../../../core/widgets/constants_spaces_widgets.dart';
import '../../../../generated/l10n.dart';

import '../../../../../core/widgets/custom_text_form.dart';

class CustomPasswordAndConfirmPasswordWidget extends StatefulWidget {
  const CustomPasswordAndConfirmPasswordWidget(
      {super.key,
      required this.passwordController,
      required this.confirmPasswordController});
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  @override
  State<CustomPasswordAndConfirmPasswordWidget> createState() =>
      _CustomPasswordAndConfirmPasswordWidgetState();
}

class _CustomPasswordAndConfirmPasswordWidgetState
    extends State<CustomPasswordAndConfirmPasswordWidget> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    var darkMode =
        context.watch<SettingCubit>().state.themeMode == ThemeMode.dark;
    var iconColor = darkMode ? AppColor.white70 : AppColor.greyColor;
    var textColor = darkMode ? AppColor.white70 : AppColor.blackColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).password,
          style: TextStyle(
            fontSize: screenWidth < 600 ? 16 : 18,
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SmallSpace(),
        CustomTextFormField(
          hintText: S.of(context).enter_password,
          controller: widget.passwordController,
          keyboardType: TextInputType.text,
          obscureText: false,
          suffixIcon: IconButton(
              onPressed: () {},
              icon: Icon(Icons.visibility_off_outlined, color: iconColor)),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return S.of(context).error_required_field;
            }
            if (value.length < 8) {
              return S.of(context).error_short_password;
            }

            return null;
          },
        ),
        const MediumSpace(),
        Text(
          S.of(context).confirm_password,
          style: TextStyle(
            fontSize: screenWidth < 600 ? 16 : 18,
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SmallSpace(),
        CustomTextFormField(
          hintText: S.of(context).enter_confirm_password,
          controller: widget.confirmPasswordController,
          keyboardType: TextInputType.text,
          obscureText: true,
          suffixIcon: IconButton(
              onPressed: () {},
              icon: Icon(Icons.visibility_off_outlined, color: iconColor)),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return S.of(context).error_required_field;
            }
            if (value != widget.passwordController.text) {
              return S.of(context).error_passwords_not_match;
            }
            return null;
          },
        ),
      ],
    );
  }
}
