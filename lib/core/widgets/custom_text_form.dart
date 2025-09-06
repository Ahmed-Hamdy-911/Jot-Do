import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../generated/l10n.dart';

import '../constants/app_colors.dart';
import '../constants/app_constants.dart';

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
  final String? initialValue;
  final EdgeInsetsGeometry? contentPadding;
  final bool? filled;
  final Color? fillColor;
  final String? helperText;
  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
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
          const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
      onTapOutside: onTapOutside ??
          (event) {
            FocusScope.of(context).requestFocus(FocusNode());
          },
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      scrollPadding: const EdgeInsets.all(20.0),
      inputFormatters: inputFormatters,
      enabled: enabled,
      readOnly: readOnly,
      maxLength: maxLength,
      cursorColor: AppColor.colorScheme,
      decoration: InputDecoration(
        filled: filled,
        fillColor: fillColor,
        labelText: labelText,
        labelStyle: labelStyle,
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        hintText: hintText,
        hintStyle: customHintStyle ??
            TextStyle(
              fontSize: 14,
              color: Colors.grey[800],
            ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        suffix: suffixWidget,
        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: 12,
        ),
        helperText: helperText,
        helperMaxLines: 2,
        helperStyle:
            Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 14),
        focusedBorder: customBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.kRadius),
              borderSide: const BorderSide(color: AppColor.colorScheme),
            ),
        enabledBorder: customBorder ??
            OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.kRadius),
                borderSide: BorderSide(color: Colors.grey[300]!)),
        border: customBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppConstants.kRadius),
            ),
      ),
    );
  }
}
