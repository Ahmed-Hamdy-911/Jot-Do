import 'package:flutter/material.dart';

import '../constants/colors/smart_app_color.dart';

class AppComponents {
  /// Divider

  static Widget customDivider([double? height]) => Divider(
        height: height ?? 30,
      );

  static Widget customVerticalDivider([double? width, double? height]) =>
      SizedBox(
        height: height ?? 20,
        child: VerticalDivider(
          width: width ?? 30,
          thickness: 1.5,
        ),
      );

  /// ---------------- Vertical Spaces ----------------
  static Widget smallVerticalSpace([double? height]) => Builder(
        builder: (context) => SizedBox(
          height: height ?? MediaQuery.of(context).size.height * 0.01,
        ),
      );

  static Widget mediumVerticalSpace([double? height]) => Builder(
        builder: (context) => SizedBox(
          height: height ?? MediaQuery.of(context).size.height * 0.02,
        ),
      );

  static Widget largeVerticalSpace([double? height]) => Builder(
        builder: (context) => SizedBox(
          height: height ?? MediaQuery.of(context).size.height * 0.04,
        ),
      );

  /// ---------------- Horizontal Spaces ----------------
  static Widget smallHorizontalSpace([double? width]) => Builder(
        builder: (context) => SizedBox(
          width: width ?? MediaQuery.of(context).size.width * 0.01,
        ),
      );

  static Widget mediumHorizontalSpace([double? width]) => Builder(
        builder: (context) => SizedBox(
          width: width ?? MediaQuery.of(context).size.width * 0.02,
        ),
      );
  static Widget largeHorizontalSpace([double? width]) => Builder(
        builder: (context) => SizedBox(
          width: width ?? MediaQuery.of(context).size.width * 0.04,
        ),
      );

  static Widget customSwitchButton({
    required bool value,
    required SmartAppColor colors,
    void Function(bool)? onChanged,
  }) {
    return Transform.scale(
      scale: 0.8,
      child: Switch(
        value: value,
        thumbColor: WidgetStatePropertyAll(colors.textInverse),
        trackColor: WidgetStatePropertyAll(colors.reverseBackgroundColor),
        onChanged: onChanged,
      ),
    );
  }

  static Widget customCircleLoading({double? strokeWidth, Color? color}) {
    return SizedBox(
      height: 28,
      width: 28,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth ?? 2,
        color: color,
      ),
    );
  }

  static Widget customCheckbox({
    required bool value,
    required SmartAppColor colors,
    void Function(bool)? onChanged,
  }) {
    return Transform.scale(
        scale: 0.8,
        child: Checkbox(
          value: value,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          side: BorderSide(color: colors.primary),
          checkColor: colors.primary,
          activeColor: colors.green,
          onChanged: (_) => onChanged,
        ));
  }
}
