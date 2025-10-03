import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../core/routing/app_routes.dart';
import '../../../../../core/widgets/components/components.dart';
import '../../../../../core/widgets/buttons/custom_button.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/widgets/custom/custom_card.dart';
import '../../../../../core/widgets/custom/custom_list_title.dart';

class SyncAndBackupSettingCard extends StatelessWidget {
  const SyncAndBackupSettingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    return CustomCard(
      title: S.of(context).sync_and_backup,
      child: Column(
        children: [
          CustomListTitle(
            title: S.of(context).autoSync,
            subTitleText: S.of(context).autoSyncDescription,
            leadingIcon: Icons.cloud_outlined,
            trailing: AppComponents.customSwitchButton(
              colors: colors,
              value: true,
              onChanged: (value) {},
            ),
          ),
          AppComponents.customDivider(30),
          CustomListTitle(
            title: S.of(context).autoBackup,
            subTitleText: S.of(context).autoBackupDescription,
            leadingIcon: Icons.backup_outlined,
            trailing: AppComponents.customSwitchButton(
              colors: colors,
              value: true,
              onChanged: (value) {},
            ),
          ),
          AppComponents.customDivider(30),
          CustomButton(
              text: S.of(context).backup_and_restore,
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.backupAndRestore);
              },
              borderColor: colors.border,
              widget: Icon(
                IconlyLight.download,
                color: colors.textPrimary,
                size: AppConstants.scaledSp(20),
              ),
              style: AppConstants.buttonPrimaryStyle(colors.textPrimary),
              bgColor: colors.backgroundMuted)
        ],
      ),
    );
  }
}
