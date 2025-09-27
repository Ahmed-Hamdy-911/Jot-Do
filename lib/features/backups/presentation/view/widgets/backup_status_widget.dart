import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../core/services/format_service.dart';
import '../../../../../core/widgets/components.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_card.dart';
import '../../../../../core/widgets/custom_list_title.dart';
import '../../../../../generated/l10n.dart';



class BackupStatusWidget extends StatelessWidget {
  const BackupStatusWidget({
    super.key,
    this.lengthUnSyncedData = 0,
    required this.dateTime,
  });
  final int? lengthUnSyncedData;
  final String dateTime;

  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    final formatDateTime = FormatService.formatDateTime(dateTime);
    return CustomCard(
      child: Column(
        children: [
          CustomListTitle(
            title: S.of(context).backupStatus,
            subTitleText:
                "${lengthUnSyncedData} ${S.of(context).dataReadyForBackup}",
            leadingIcon: Icons.cloud_outlined,
            trailing: const SizedBox.shrink(),
          ),
          AppComponents.mediumVerticalSpace(),
          Row(
            children: [
              Icon(
                Icons.cloud_done_outlined,
                color: colors.green,
                size: AppConstants.scaledSp(18),
              ),
              AppComponents.mediumHorizontalSpace(),
              Text(
                S.of(context).lastBackup + ": " + formatDateTime,
                style: AppConstants.bodyMediumStyle(colors.textPrimary),
              ),
            ],
          ),
          AppComponents.largeVerticalSpace(),
          CustomButton(
            text: S.of(context).createBackup,
            widget: Icon(
              IconlyLight.download,
              color: colors.reverseTextColor,
            ),
            bgColor: colors.reverseBackgroundColor,
            style: AppConstants.buttonSecondaryStyle(colors.reverseTextColor),
            onPressed: () {},
          ),
          AppComponents.smallVerticalSpace(),
          CustomButton(
            text: S.of(context).restoreFromBackup,
            widget: Icon(
              IconlyLight.upload,
              color: colors.textPrimary,
            ),
            bgColor: colors.backgroundMuted,
            borderColor: colors.border,
            style: AppConstants.buttonSecondaryStyle(colors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
