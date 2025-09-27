import 'package:flutter/material.dart';
import '../../../../core/widgets/components.dart';
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
      appBar: AppBar(
        title: Text(S.of(context).settings),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth >= 600) {
          return Center(
            child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: const SettingBody()),
          );
        } else {
          return const SettingBody();
        }
      }),
    );
  }
}

class SettingBody extends StatelessWidget {
  const SettingBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
