import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/constants/app_constants.dart';
import '../../../../../../core/cubits/backup/backup_cubit.dart';
import '../../../../../../core/widgets/components.dart';
import '../../../../../../core/widgets/constants_spaces_widgets.dart';
import '../../../../../../core/widgets/custom_snackbar.dart';
import '../../../../../../generated/l10n.dart';

class NoteSyncWarning extends StatelessWidget {
  const NoteSyncWarning({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        customDivider(),
        const SmallSpace(),
        Container(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 12,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              AppConstants.kRadius,
            ),
            border: Border.all(color: AppColor.grey300, width: 1),
            color: AppColor.grey800,
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(
              Icons.warning_amber_rounded,
              color: AppColor.yellowDarkColor,
            ),
            const SizedBox(width: 8),
            Text(
              S.of(context).note_not_synced,
              style: const TextStyle(
                color: AppColor.yellowDarkColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                overlayColor: AppColor.greyColor,
                padding: const EdgeInsetsDirectional.only(start: 8),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                S.of(context).syncNow,
                style: TextStyle(
                  color: AppColor.grey300,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              onPressed: () {
                _handleSyncNow(context);
              },
            ),
          ]),
          // RichText(
          //   textDirection:
          //       context.read<SettingCubit>().state.locale ==
          //               const Locale('ar')
          //           ? TextDirection.rtl
          //           : TextDirection.ltr,
          //   text: TextSpan(
          //     locale: context.read<SettingCubit>().state.locale,
          //     children: [
          //       const WidgetSpan(
          //         child: Icon(
          //           Icons.warning_amber_rounded,
          //           color: AppColor.yellowDarkColor,
          //         ),
          //       ),
          //       const WidgetSpan(
          //         child: SizedBox(width: 8),
          //       ),
          //       TextSpan(
          //         text: S.of(context).note_not_synced,
          //         style: const TextStyle(
          //           color: AppColor.yellowDarkColor,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //       WidgetSpan(
          //         child: TextButton(
          //           style: TextButton.styleFrom(
          //             minimumSize: Size.zero,
          //             overlayColor: AppColor.greyColor,
          //             padding: const EdgeInsetsDirectional.only(
          //                 start: 8),
          //             tapTargetSize:
          //                 MaterialTapTargetSize.shrinkWrap,
          //           ),
          //           onPressed: () {
          //             if (AppConstants
          //                 .appService.isAutoBackupAndSync) {
          //             } else {
          //               CustomSnackBar.showToastification(
          //                 context,
          //                 children: [
          //                   TextButton(
          //                     onPressed: () {},
          //                     style: TextButton.styleFrom(
          //                       minimumSize: Size.zero,
          //                       overlayColor: AppColor.greyColor,
          //                       padding:
          //                           const EdgeInsetsDirectional
          //                               .only(start: 8),
          //                       tapTargetSize:
          //                           MaterialTapTargetSize
          //                               .shrinkWrap,
          //                     ),
          //                     child: Text(
          //                       S.of(context).retry,
          //                       style: TextStyle(
          //                         fontWeight: FontWeight.bold,
          //                         color: AppColor.grey600,
          //                       ),
          //                     ),
          //                   )
          //                 ],
          //                 message:
          //                     S.of(context).backup_synced_failed,
          //                 type: ToastificationType.error,
          //               );
          //             }
          //           },
          //           child: Text(
          //             S.of(context).syncNow,
          //             style: TextStyle(
          //               color: AppColor.grey300,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ),
      ],
    );
  }

  void _handleSyncNow(context) {
    if (AppConstants.appService.isOnline &&
        AppConstants.appService.isAutoBackupAndSync) {
      CustomSnackBar.showToastification(context,
          message: S.of(context).backup_synced_successfully,
          type: ToastificationType.success);
    } else {
      _showRetryToast(context);
    }
  }

  void _showRetryToast(context) {
    CustomSnackBar.showToastification(
      context,
      children: [
        WidgetSpan(
          child: TextButton(
            onPressed: () {
              toastification.dismissAll();
              if (!AppConstants.appService.isOnline) {
                _showNoInternetToast(context);
              } else if (!AppConstants.appService.isAutoBackupAndSync) {
                _showToastAutoBackupAndSyncDisabled(context);
              } else {
                //
              }
            },
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              overlayColor: AppColor.greyColor,
              padding: const EdgeInsetsDirectional.only(start: 8),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              S.of(context).retry,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColor.grey600,
              ),
            ),
          ),
        )
      ],
      message: S.of(context).backup_synced_failed,
      type: ToastificationType.error,
    );
  }

  void _showNoInternetToast(context) {
    CustomSnackBar.showToastification(context,
        message: S.of(context).noInternet, type: ToastificationType.error);
  }

  void _showToastAutoBackupAndSyncDisabled(context) {
    CustomSnackBar.showToastification(context,
        message: S.of(context).checkAutoBackupAndSync,
        type: ToastificationType.error,
        children: [
          WidgetSpan(
            child: TextButton(
              onPressed: () {
                BlocProvider.of<BackupCubit>(context).toggleAutoBackup(true);
                toastification.dismissAll();
              },
              child: Text(
                S.of(context).enable_now,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColor.grey600,
                ),
              ),
            ),
          ),
        ]);
  }
}
