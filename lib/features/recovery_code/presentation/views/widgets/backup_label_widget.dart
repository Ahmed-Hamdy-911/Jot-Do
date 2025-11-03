import 'package:flutter/material.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../core/widgets/components/components.dart';
import '../../../../../generated/l10n.dart';

class BackupLabelWidget extends StatelessWidget {
  const BackupLabelWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    final List<Map<String, dynamic>> data = [
      {
        'icon': Icons.key_outlined,
        'text': S.of(context).recovery_code_backup_password_manager,
      },
      {
        'icon': Icons.groups_outlined,
        'text': S.of(context).recovery_code_backup_trusted_person,
      },
      {
        'icon': Icons.cloud_off_outlined,
        'text': S.of(context).recovery_code_backup_cloud_note,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          S.of(context).recovery_code_backups_label,
          style: AppConstants.customStyle(
              color: colors.textPrimary,
              fontSize: AppConstants.bodyMedium,
              fontWeight: AppConstants.fontSemiBold),
        ),
        AppComponents.mediumVerticalSpace(),
        Column(
          children: List.generate(
            data.length,
            (index) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      data[index]['icon'],
                      color: colors.blue,
                    ),
                    AppComponents.largeHorizontalSpace(),
                    Expanded(
                      child: Text(
                        data[index]['text'],
                        style: AppConstants.bodyMediumStyle(colors.textPrimary),
                      ),
                    ),
                  ],
                ),
                if (index != data.length - 1)
                  AppComponents.smallVerticalSpace(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
