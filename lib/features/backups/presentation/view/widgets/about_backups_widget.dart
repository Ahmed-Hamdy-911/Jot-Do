import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../core/widgets/components.dart';
import '../../../../../core/widgets/custom_card.dart';
import '../../../../../generated/l10n.dart';

class AboutBackupsWidget extends StatelessWidget {
  const AboutBackupsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);

    return CustomCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          S.of(context).aboutBackups,
          style: AppConstants.bodyLargeStyle(colors.textPrimary),
        ),
        AppComponents.mediumVerticalSpace(),
        CustomAboutBackupItem(
          text: S.of(context).backupFeature1,
        ),
        CustomAboutBackupItem(
          text: S.of(context).backupFeature2,
        ),
        CustomAboutBackupItem(
          text: S.of(context).backupFeature3,
        ),
        CustomAboutBackupItem(
          text: S.of(context).backupFeature4,
        ),
      ]),
    );
  }
}

class CustomAboutBackupItem extends StatelessWidget {
  const CustomAboutBackupItem({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              IconlyLight.info_circle,
              size: AppConstants.scaledSp(20),
              color: colors.textSecondary,
            ),
            AppComponents.mediumHorizontalSpace(),
            Expanded(
              child: Text(
                text,
                style: AppConstants.bodySmallStyle(colors.textSecondary),
              ),
            ),
          ],
        ),
        AppComponents.mediumVerticalSpace(),
      ],
    );
  }
}
