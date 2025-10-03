import 'dart:ui';

import 'package:flutter/material.dart';

import '../../constants/colors/smart_app_color.dart';

class CustomBlurWidget extends StatelessWidget {
  const CustomBlurWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  colors.backgroundScreen.withValues(alpha: 0.01),
                  colors.backgroundScreen.withValues(alpha: 0.3),
                  colors.backgroundScreen.withValues(alpha: 0.6),
                  colors.backgroundScreen,
                ],
              ),
            ),
            child: child),
      ),
    );
  }
}
