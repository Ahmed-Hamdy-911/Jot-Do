import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../generated/l10n.dart';

import '../constants/app_constants.dart';
import '../../features/settings/presentation/cubits/setting_cubit.dart';
import '../constants/colors/smart_app_color.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.validator,
    this.inputFormatters,
    this.keyboardType,
    this.suffixIcon,
    this.obscureText = false,
    this.hintText,
    this.labelText,
    this.controller,
    this.prefixIcon,
    this.customBorder,
    this.maxLines = 1,
    this.minLines,
    this.customHintStyle,
    this.enabledBorder,
    this.labelStyle,
    this.enabled = true,
    this.onTap,
    this.readOnly = false,
    this.initialValue,
    this.contentPadding,
    this.onFieldSubmitted,
    this.onTapOutside,
    this.maxLength,
    this.filled,
    this.fillColor,
    this.suffixWidget,
    this.helperText,
    this.onChanged,
    this.customInputStyle,
    this.focusNode,
    this.expands = false,
  });
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? suffixWidget;
  final bool obscureText;
  final InputBorder? customBorder;
  final InputBorder? enabledBorder;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final TextStyle? customInputStyle;
  final TextStyle? customHintStyle;
  final TextStyle? labelStyle;
  final bool? enabled;
  final Function()? onTap;
  final void Function(String)? onFieldSubmitted;
  final void Function(PointerDownEvent)? onTapOutside;
  final void Function(String)? onChanged;
  final bool readOnly;
  final bool expands;
  final String? initialValue;
  final EdgeInsetsGeometry? contentPadding;
  final bool? filled;
  final Color? fillColor;
  final String? helperText;
  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    var darkMode =
        context.watch<SettingCubit>().state.themeMode == ThemeMode.dark;
    var textColor = colors.textPrimary;
    var inputTextColor = enabled == false
        ? darkMode
            ? colors.white70
            : colors.grey
        : textColor;
    return TextFormField(
      validator: validator ??
          (value) {
            if (value == null || value.trim().isEmpty) {
              return S.of(context).error_required_field;
            }
            return null;
          },
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      minLines: minLines,
      initialValue: initialValue,
      style: customInputStyle ??
          TextStyle(
            fontSize: 16,
            color: inputTextColor,
          ),
      onTapOutside: onTapOutside ??
          (event) {
            FocusScope.of(context).requestFocus(FocusNode());
          },
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      scrollPadding: const EdgeInsets.all(16.0),
      inputFormatters: inputFormatters,
      enabled: enabled,
      expands: expands,
      readOnly: readOnly,
      maxLength: maxLength,
      cursorColor: colors.primary,
      decoration: InputDecoration(
        filled: filled,
        fillColor: fillColor,
        labelText: labelText,
        labelStyle: TextStyle(
          color: enabled == false
              ? darkMode
                  ? colors.white70
                  : colors.grey
              : darkMode
                  ? colors.white
                  : colors.grey,
        ),
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        hintText: hintText,
        hintStyle: customHintStyle ??
            TextStyle(
              fontSize: 14,
              color: darkMode ? colors.white70 : colors.grey,
            ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        suffix: suffixWidget,
        errorStyle: TextStyle(
          color: colors.red,
          fontSize: 12,
        ),
        helperText: helperText,
        helperMaxLines: 2,
        helperStyle: TextStyle(color: colors.grey),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.kRadius),
          borderSide: BorderSide(color: colors.red),
        ),
        focusedBorder: customBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.kRadius),
              borderSide: BorderSide(color: colors.primary),
            ),
        enabledBorder: customBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.kRadius),
              borderSide: BorderSide(color: colors.border),
            ),
        border: customBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.kRadius),
            ),
      ),
    );
  }
}
