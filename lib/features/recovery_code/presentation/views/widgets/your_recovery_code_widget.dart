import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../core/models/message_type.dart';
import '../../../../../core/services/app_session.dart';
import '../../../../../core/widgets/components/components.dart';
import '../../../../../core/widgets/components/custom_snackbar.dart';
import '../../../../../generated/l10n.dart';
import '../../cubits/save_code/save_recovery_file_cubit.dart';
import '../../cubits/save_code/save_recovery_file_state.dart';
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
    final recoveryCode = AppSession.instance.pendingRecoveryCode!;
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
              child: BlocProvider(
                create: (context) => SaveRecoveryFileCubit(),
                child: const SaveRecoveryInFileWidget(),
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

class SaveRecoveryInFileWidget extends StatelessWidget {
  const SaveRecoveryInFileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SaveRecoveryFileCubit, SaveRecoveryFileState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state is SaveRecoveryFileSuccess) {
          CustomSnackBar.showSnackBar(
            S.of(context).recoveryCodeSaved,
            context,
            MessageType.success,
          );
        } else if (state is SaveRecoveryFileError) {
          CustomSnackBar.showSnackBar(
            state.message,
            context,
            MessageType.error,
          );
        } else if (state is SaveRecoveryFilePermissionDenied) {
          CustomSnackBar.showToastification(S.of(context).permission_denied,
              message: S.of(context).permission_denied_text,
              children: [
                WidgetSpan(
                    child: TextButton.icon(
                  onPressed: () => openAppSettings(),
                  label: Text(S.of(context).settings),
                  icon: const Icon(Icons.settings),
                ))
              ]);
        }
      },
      builder: (context, state) {
        final recoveryCode = AppSession.instance.pendingRecoveryCode!;
        if (state is SaveRecoveryFileLoading) {
          return Center(child: AppComponents.customCircleLoading(context));
        }
        return BackupOptionItem(
          title: S.of(context).recovery_code_save_file_button,
          icon: Icons.save,
          onPressed: () {
            context
                .read<SaveRecoveryFileCubit>()
                .saveRecoveryCodeToFile(recoveryCode: recoveryCode);
          },
        );
      },
    );
  }
}
