import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../constants/app_assets.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({
    super.key,
    this.height,
  });
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? null,
      child: Lottie.asset(AppAssets.loadingAnimation),
    );
  }
}
