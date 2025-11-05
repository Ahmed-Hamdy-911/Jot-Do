import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../core/services/app_session.dart';
import '../../../../../core/widgets/components/components.dart';
import '../../../../../generated/l10n.dart';
import 'backup_option_item.dart';
import 'copy_button.dart';
import 'show_recovery_code_qr_widget.dart';

class RecoveryCodeWidget extends StatelessWidget {
  const RecoveryCodeWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    final recoveryCode = AppSession.instance.pendingRecoveryCode ??
        'AbCd12-EfGh34-IjKl56-MnOp78-QrSt90-UvWx';
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
        color: colors.backgroundSecondary,
        borderRadius: BorderRadius.circular(AppConstants.kRadius),
      ),
      child: Column(
        children: [
          Text(
            S.of(context).recovery_code_generated_label,
            style: AppConstants.bodyMediumStyle(
                colors.textPrimary.withValues(alpha: 0.7)),
            textAlign: TextAlign.center,
          ),
          AppComponents.smallVerticalSpace(),
          SelectableText(
            recoveryCode,
            selectionColor:
                colors.reverseBackgroundColor.withValues(alpha: 0.1),
            style: AppConstants.customStyle(
                color: colors.textPrimary,
                fontSize: AppConstants.displayLarge,
                fontWeight: AppConstants.fontExtraBold),
            textAlign: TextAlign.center,
          ),
          AppComponents.largeVerticalSpace(),
          const KeyBackupOption(),
          AppComponents.largeVerticalSpace(),
        ],
      ),
    );
  }
}

class KeyBackupOption extends StatelessWidget {
  const KeyBackupOption({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      alignment: WrapAlignment.center,
      children: [
        const CopyButton(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: BackupOptionItem(
                title: S.of(context).recovery_code_save_file_button,
                icon: Icons.save,
                onPressed: () {
                  // Save recovery code action
                },
              ),
            ),
            AppComponents.mediumHorizontalSpace(),
            Expanded(
              child: BackupOptionItem(
                title: S.of(context).recovery_code_show_qr_button,
                icon: Icons.qr_code_2_outlined,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => const ShowRecoveryWithQRWidget());
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
