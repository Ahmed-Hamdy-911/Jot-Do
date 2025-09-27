import 'package:flutter/material.dart';

import '../constants/colors/smart_app_color.dart';
import 'loading_animation.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({
    super.key,
    required this.child,
    required this.state,
  });
  final Widget child;
  final bool state;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        child,
        if (state)
          Container(
            height: size.height,
            width: size.width,
            color: SmartAppColor(context).white.withValues(alpha: 0.1),
            child: const Center(child: LoadingAnimation()),
          )
      ],
    );
  }
}
