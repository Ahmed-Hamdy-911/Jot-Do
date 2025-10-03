import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../core/widgets/components/components.dart';
import '../../../../../core/widgets/buttons/custom_button.dart';
import '../../../../../core/widgets/custom/custom_card.dart';
import '../../../../../core/widgets/custom/custom_list_title.dart';
import '../../../../../generated/l10n.dart';

class LocalBackupWidget extends StatelessWidget {
  const LocalBackupWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomCard(
          title: S.of(context).localBackup,
          child: const ExportDataWidget(),
        ),
        AppComponents.mediumVerticalSpace(),
        const ImportDataWidget(),
      ],
    );
  }
}

class ExportDataWidget extends StatelessWidget {
  const ExportDataWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    return Column(children: [
      CustomListTitle(
        title: S.of(context).exportData,
        subTitleText: S.of(context).exportDescription,
        leadingIcon: Icons.file_copy_outlined,
        noTrailing: true,
      ),
      AppComponents.mediumVerticalSpace(),
      CustomButton(
        text: S.of(context).exportData + S.of(context).json,
        bgColor: colors.backgroundMuted,
        style: AppConstants.buttonSecondaryStyle(colors.textPrimary),
        widget: Icon(
          IconlyLight.download,
          color: colors.textPrimary,
        ),
        onPressed: () {},
      )
    ]);
  }
}

class ImportDataWidget extends StatelessWidget {
  const ImportDataWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    return CustomCard(
      child: Column(
        children: [
          CustomListTitle(
            title: S.of(context).importData,
            subTitleText: S.of(context).importDescription,
            leadingIcon: Icons.upload_file_outlined,
            noTrailing: true,
          ),
          AppComponents.mediumVerticalSpace(),
          CustomButton(
            text: S.of(context).importData + S.of(context).json,
            bgColor: colors.backgroundMuted,
            style: AppConstants.buttonSecondaryStyle(colors.textPrimary),
            widget: Icon(
              IconlyLight.upload,
              color: colors.textPrimary,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
