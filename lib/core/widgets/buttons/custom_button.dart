import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_constants.dart';
import '../../constants/colors/smart_app_color.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.widget,
    required this.text,
    this.onPressed,
    required this.bgColor,
    this.borderColor,
    this.style,
  });
  final Widget? widget;
  final String text;
  final Color bgColor;
  final void Function()? onPressed;
  final Color? borderColor;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final colors = SmartAppColor(context);
    return OutlinedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(bgColor),
          overlayColor: WidgetStatePropertyAll(
              bgColor == colors.reverseBackgroundColor
                  ? colors.grey
                  : colors.border),
          minimumSize: WidgetStatePropertyAll(
            Size.fromHeight(AppConstants.kMaterialButtonHeight),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.kRadius),
            ),
          ),
          side: WidgetStatePropertyAll(
            BorderSide(
              color: borderColor ?? Colors.transparent,
            ),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget ?? const SizedBox.shrink(),
            SizedBox(
              width: 10.w,
            ),
            Text(
              text,
              style: style,
            ),
          ],
        ));
  }   
}
