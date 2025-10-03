import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../constants/app_assets.dart';
import '../../constants/app_constants.dart';
import '../../constants/colors/smart_app_color.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Lottie.asset(AppAssets.emptyAnimation)),
                Text(
                  text,
                  style: AppConstants.bodyLargeStyle(
                      SmartAppColor(context).textPrimary),
                )
              ]);
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Lottie.asset("assets/animations/empty.json")),
              Text(
                text,
                style: AppConstants.bodyLargeStyle(
                    SmartAppColor(context).textPrimary),
              ),
            ],
          );
        }
      },
    );
  }
}
