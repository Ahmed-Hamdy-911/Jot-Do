import 'package:flutter/material.dart';

import '../constants/colors/smart_app_color.dart';

class AppComponents {
  /// Divider

  static Widget customDivider([double? height]) => Divider(
        height: height ?? 30,
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
}
