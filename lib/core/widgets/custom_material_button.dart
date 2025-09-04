import 'package:flutter/material.dart';
import '../constants/colors/app_colors.dart';
import '../constants/constant.dart';

class CustomMaterialButton extends StatelessWidget {
  const CustomMaterialButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.color,
    this.minWidth,
    this.height,
    this.customBorderSide,
    this.isLoading = false,
  });

  final String text;
  final void Function()? onPressed;
  final Color? color;
  final bool? isLoading;
  final double? minWidth;
  final double? height;

  final BorderSide? customBorderSide;
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 600) {
          return Center(
            child: MaterialButton(
              onPressed: onPressed,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.kRadius),
                side: customBorderSide ?? BorderSide.none,
              ),
              height: 60,
              minWidth: screenWidth * 0.5,
              color: color ?? AppColor.colorScheme,
              child: isLoading == true
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : Text(
                      text,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
            ),
          );
        }
        return Center(
          child: MaterialButton(
            onPressed: onPressed,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.kRadius),
              side: customBorderSide ?? BorderSide.none,
            ),
            height: 55,
            minWidth: minWidth ?? screenWidth,
            color: color ?? AppColor.colorScheme,
            child: isLoading == true
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : Text(
                    text,
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
