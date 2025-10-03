import 'package:flutter/material.dart';
import '../../../../core/constants/colors/smart_app_color.dart';
import '../../../../core/widgets/components/components.dart';
import '../../../../core/widgets/custom/custom_blur_widget.dart';
import '../../../../generated/l10n.dart';
import 'widgets/about_backups_widget.dart';
import 'widgets/backup_status_widget.dart';
import 'widgets/local_backup_widget.dart';

class BackupAndRestoreView extends StatelessWidget {
  const BackupAndRestoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomBlurWidget(
          child: AppBar(
            title: Text(S.of(context).backup_and_restore),
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
                child: const BackupAndRestoreBody()),
          );
        } else {
          return const BackupAndRestoreBody();
        }
      }),
    );
  }
}

class BackupAndRestoreBody extends StatelessWidget {
  const BackupAndRestoreBody({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppComponents.appBarPadding(context),
            BackupStatusWidget(
              lengthUnSyncedData: 0,
              dateTime: DateTime.now().toIso8601String(),
            ),
            AppComponents.mediumVerticalSpace(),
            const LocalBackupWidget(),
            AppComponents.mediumVerticalSpace(),
            const AboutBackupsWidget(),
            AppComponents.mediumVerticalSpace(),
          ],
        ),
      ),
    );
  }
}
