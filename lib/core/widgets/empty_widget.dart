import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'constants_spaces_widgets.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset("assets/animations/empty.json"),
        const MediumSpace(),
        Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ));
  }
}
