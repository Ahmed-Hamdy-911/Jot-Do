import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/constants/colors/smart_app_color.dart';
import '../../../../core/widgets/components.dart';
import '../../../../core/widgets/custom_blur_widget.dart';
import '../../../../generated/l10n.dart';
import 'widgets/account_card.dart';
import 'widgets/delete_all_data_card.dart';
import 'widgets/appearance_card.dart';
import 'widgets/notification_card.dart';
import 'widgets/sync_and_backup_card.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomBlurWidget(
          child: AppBar(
            title: Text(S.of(context).settings),
            backgroundColor:
                SmartAppColor(context).backgroundScreen.withValues(alpha: 0.2),
            elevation: 0,
          ),
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth >= 600) {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: const SettingBody(),
            ),
          );
        } else {
          return const SettingBody();
        }
      }),
    );
  }
}

class SettingBody extends StatelessWidget {
  const SettingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppComponents.appBarPadding(context),
            const AccountSettingCard(),
            AppComponents.mediumVerticalSpace(),
            const AppearanceSettingCard(),
            AppComponents.mediumVerticalSpace(),
            const SyncAndBackupSettingCard(),
            AppComponents.mediumVerticalSpace(),
            const DeleteAllDataCard(),
            AppComponents.mediumVerticalSpace(),
            const NotificationSettingCard(),
            AppComponents.largeVerticalSpace(),
          ],
        ),
      ),
    );
  }
}
