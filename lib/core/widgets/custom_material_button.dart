import 'package:flutter/material.dart';
import 'package:jot_do/core/constants/constant.dart';

class CustomMaterialButton extends StatelessWidget {
  const CustomMaterialButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.color,
    this.minWidth,
    this.height,
    this.radius = 50,
    this.customBorderSide,
    this.isLoading = false,
  });

  final String text;
  final void Function()? onPressed;
  final Color? color;
  final bool? isLoading;
  final double? minWidth;
  final double? height;
  final double? radius;
  final BorderSide? customBorderSide;
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    var screenHeight = MediaQuery.sizeOf(context).height;
    return Center(
      child: MaterialButton(
        onPressed: onPressed,
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: customBorderSide ?? BorderSide.none,
        ),
        height: screenWidth < 600 ? screenHeight * 0.06 : screenHeight * 0.08,
        minWidth: minWidth ?? screenWidth,
        color: color ?? AppConstants.colorScheme,
        // textColor: Colors.white,
        child: isLoading == true
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : Text(
                text,
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
