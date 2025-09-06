import 'package:flutter/material.dart';

class AppColor {
  // light Colors
  static Color mainLightColor = const Color(0xff7e66ee).withValues(alpha: 0.9);
  static const colorScheme = Colors.purple;
  static const whiteColor = Colors.white;
  static const white70 = Colors.white70;
  static const scaffoldBGLightColor = whiteColor;

  // dark Colors
  static Color mainDarkColor = const Color(0xff2c0735);
  static const scaffoldBGDarkColor = Color(0xff212529);
  static const blackColor = Colors.black;

  // const Colors

  //transparent
  static const transparentColor = Colors.transparent;

  //grey
  static const greyColor = Colors.grey;
  static Color grey800 = Colors.grey.shade800;
  static Color grey600 = Colors.grey.shade600;
  static Color grey300 = Colors.grey.shade300;

  // red
  static const redColor = Colors.red;
  static const redLightColor = Color(0xffff4d4d);
  static const redDarkColor = Color(0xffb00020);

  // blue
  static const blueColor = Colors.blue;
  static const blueLightColor = Color(0xff4fc3f7);
  static Color blueDarkColor = Colors.blue.shade800;

  // splash
  static List<Color> splashColorsList = const [
    Color(0xffa724ec),
    Color(0xff9d33ef),
    Color(0xff8c4af4),
    Color(0xff8059f8),
  ];

// on boarding
  static List<Color> onBoardingColorsList = const [
    Color(0xffa724ec),
    Colors.white,
  ];
  // notes
  static final List<Color> noteColors = const [
    Color(0xff26C281),
    Color(0xff2CC7C9),
    Color(0xff25A4F2),
    Color(0xff5C6BC0),
    Color(0xffA76CE6),
    Color(0xffB2AA8E),
    Color(0xffE07BD2),
    Color(0xffF28EA0),
    Color(0xffDA5A48),
    Color(0xffF89B4C),
    Color(0xffF7DC3A),
    Color(0xffC8E6C9),
    Color(0xff676F54),
    Color(0xffFA9839),
    Color(0xffF9E23B),
    Color(0xff4DD0FC),
    Color(0xff4EF2C0),
    Color(0xffA0F51C),
  ];
}
