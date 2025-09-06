import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CustomTextAndTextButton extends StatelessWidget {
  const CustomTextAndTextButton({
    super.key,
    required this.textTitle,
    required this.textButtonTitle,
    required this.onPressed,
    this.decoration,
    this.fontWeight,
    this.fontSize,
  });
  final String textTitle;
  final String textButtonTitle;
  final void Function()? onPressed;
  final TextDecoration? decoration;
  final FontWeight? fontWeight;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          textTitle,
          style: TextStyle(
            fontSize: MediaQuery.sizeOf(context).width < 600
                ? MediaQuery.sizeOf(context).width * 0.035
                : MediaQuery.sizeOf(context).width * 0.015,
            color: AppColor.mainLightColor,
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            textButtonTitle,
            style: TextStyle(
              decoration: decoration ?? TextDecoration.none,
              fontSize: fontSize ?? 15,
              fontWeight: fontWeight,
              color: AppColor.colorScheme,
            ),
          ),
        )
      ],
    );
  }
}
