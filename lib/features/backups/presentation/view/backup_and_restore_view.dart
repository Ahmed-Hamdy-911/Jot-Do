import 'package:flutter/material.dart';
import '../../../../core/widgets/components.dart';
import '../../../../generated/l10n.dart';
import 'widgets/about_backups_widget.dart';
import 'widgets/backup_status_widget.dart';
import 'widgets/local_backup_widget.dart';

class BackupAndRestoreView extends StatelessWidget {
  const BackupAndRestoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).backup_and_restore),
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
            AppComponents.smallVerticalSpace(),
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
