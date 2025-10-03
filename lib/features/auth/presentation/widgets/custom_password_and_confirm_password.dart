import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/colors/smart_app_color.dart';
import '../../../../core/widgets/components/components.dart';
import '../../../../generated/l10n.dart';

import '../../../../core/widgets/custom_fields/custom_text_form.dart';
import '../cubit/auth_cubit.dart';
import 'toggle_password_visibility_icon.dart';

class CustomPasswordAndConfirmPasswordWidget extends StatefulWidget {
  const CustomPasswordAndConfirmPasswordWidget({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  State<CustomPasswordAndConfirmPasswordWidget> createState() =>
      _CustomPasswordAndConfirmPasswordWidgetState();
}

class _CustomPasswordAndConfirmPasswordWidgetState
    extends State<CustomPasswordAndConfirmPasswordWidget> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().resetPasswordVisibility();
  }

  @override
  void dispose() {
    widget.passwordController.dispose();
    widget.confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    var colors = SmartAppColor(context);
    var textColor = colors.grey;
    var fillColor = colors.fillColor;
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
        AppComponents.smallVerticalSpace(),
        CustomTextFormField(
          hintText: S.of(context).enter_password,
          controller: widget.passwordController,
          keyboardType: TextInputType.text,
          obscureText: !context.watch<AuthCubit>().isPasswordVisible,
          suffixIcon: const TogglePasswordVisibilityIcon(isConfirmField: false),
          filled: true,
          fillColor: fillColor,
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
        AppComponents.mediumVerticalSpace(),
        Text(
          S.of(context).confirm_password,
          style: TextStyle(
            fontSize: screenWidth < 600 ? 16 : 18,
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        AppComponents.smallVerticalSpace(),
        CustomTextFormField(
          hintText: S.of(context).enter_confirm_password,
          controller: widget.confirmPasswordController,
          keyboardType: TextInputType.text,
          obscureText: !context.watch<AuthCubit>().isConfirmPasswordVisible,
          suffixIcon: const TogglePasswordVisibilityIcon(isConfirmField: true),
          filled: true,
          fillColor: fillColor,
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
