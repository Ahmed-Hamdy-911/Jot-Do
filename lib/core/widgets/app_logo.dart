import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../constants/app_assets.dart';
import '../constants/app_constants.dart';
import '../constants/colors/smart_app_color.dart';
import 'components.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = SmartAppColor(context);
    return Center(
      child: Column(
        children: [
          Image.asset(AppAssets.appIcon, height: 85, width: 85),
          AppComponents.smallVerticalSpace(),
          Text(
            S.of(context).appName,
            style: AppConstants.mediumAppNameStyle(colors.textPrimary),
          ),
        ],
      ),
    );
  }
}
