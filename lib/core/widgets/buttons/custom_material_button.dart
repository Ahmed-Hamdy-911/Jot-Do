import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';
import '../../constants/colors/smart_app_color.dart';

class CustomMaterialButton extends StatelessWidget {
  const CustomMaterialButton({
    super.key,
    required this.onPressed,
    this.text,
    this.color,
    this.textColor,
    this.minWidth,
    this.height,
    this.customBorderSide,
    this.isLoading = false,
    this.radius,
    this.widget,
  });

  final String? text;
  final void Function()? onPressed;
  final Color? color;
  final Color? textColor;
  final bool? isLoading;
  final double? minWidth;
  final double? height;
  final double? radius;
  final Widget? widget;

  final BorderSide? customBorderSide;
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    var colors = SmartAppColor(context);
    var splashColor = colors.grey.withValues(alpha: 0.3);
    return Center(
      child: MaterialButton(
        onPressed: onPressed,
        splashColor: splashColor,
        hoverColor: colors.transparent,
        highlightColor: splashColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? AppConstants.kRadius),
          side: customBorderSide ?? BorderSide.none,
        ),
        height: height ?? AppConstants.kMaterialButtonHeight,
        minWidth: minWidth ?? screenWidth,
        color: color ?? colors.buttonPrimary,
        child: widget ??
            Text(
              text ?? '',
              style: AppConstants.buttonPrimaryStyle(
                textColor ?? colors.buttonTextPrimary,
              ),
            ),
      ),
    );
  }
}
