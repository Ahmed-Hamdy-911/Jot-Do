import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../../../../../../core/constants/app_constants.dart';
import '../../../../../../core/helper/cache_helper.dart';
import '../../../../../../core/models/message_type.dart';
import '../../../../../../core/routing/app_routes.dart';
import '../../../../../../core/widgets/custom_snackbar.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../../../auth/presentation/cubit/auth_states.dart';
import 'setting_card.dart';
import 'setting_item.dart';

class AccountAndBackupSettingsCard extends StatelessWidget {
  const AccountAndBackupSettingsCard({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn =
        CacheHelper.getData(key: AppConstants.isLoggedIn) ?? false;

    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is AuthLoggedOut) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.splash,
            (route) => false,
          );
        }
        if (state is AuthFailure) {
          CustomSnackBar.showSnackBar(
            state.error,
            context,
            MessageType.error,
          );
        }
      },
      child: CustomSettingCard(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSettingItem(
                  title: S.of(context).profile,
                  leadingIcon: IconlyLight.profile,
                  onTap: () {
                    if (isLoggedIn) {
                      Navigator.pushNamed(context, AppRoutes.profile);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          closeIconColor: Colors.red,
                          showCloseIcon: true,
                          content: Text(S.of(context).please_login_first),
                        ),
                      );
                    }
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSettingItem(
                      title: S.of(context).backup_sync,
                      enabled: isLoggedIn,
                      leadingIcon: Icons.backup_outlined,
                      trailing: const Icon(Icons.restore),
                      subTitleText: isLoggedIn
                          ? S.of(context).automatically
                          : S.of(context).not_yet,
                      onTap: () {
                        // context.read<BackupCubit>().syncNotes();
                      },
                    ),
                  ],
                ),
                CustomSettingItem(
                  title: S.of(context).automatically_backup_sync,
                  leadingIcon: Icons.auto_mode_outlined,
                  trailing: Switch(
                    value: false,
                    onChanged: (value) {
                      if (isLoggedIn) {
                        // context.read<BackupCubit>().toggleAutoBackup(value);
                      }
                    },
                  ),
                  subTitleText:
                      isLoggedIn ? S.of(context).enable : S.of(context).disable,
                ),
              ],
            ),
            CustomSettingItem(
              title: isLoggedIn ? S.of(context).logout : S.of(context).login,
              leadingIcon: isLoggedIn ? IconlyLight.logout : IconlyLight.login,
              trailing: context.watch<AuthCubit>().state is AuthLoadingState
                  ? const SizedBox(
                      height: 28,
                      width: 28,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : null,
              onTap: () async {
                if (isLoggedIn) {
                  await context.read<AuthCubit>().logout();
                } else {
                  CacheHelper.saveData(
                      key: AppConstants.skipAuthentication, value: false);
                  Navigator.pushNamed(context, AppRoutes.login);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
