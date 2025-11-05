import 'package:flutter/material.dart';

import '../../../../../core/widgets/components/components.dart';
import 'action_buttons_widget.dart';
import 'backup_label_widget.dart';
import 'warning_recovery_widget.dart';
import 'your_recovery_code_widget.dart';

class RecoveryCodeBody extends StatelessWidget {
  const RecoveryCodeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12.0).copyWith(top: 0),
      children: [
        AppComponents.appBarPadding(context),
        AppComponents.mediumVerticalSpace(),
        const WarningRecoveryCodeWidget(),
        AppComponents.mediumVerticalSpace(),
        const RecoveryCodeWidget(),
        AppComponents.mediumVerticalSpace(),
        const BackupLabelWidget(),
        AppComponents.mediumVerticalSpace(),
        const ActionButtons(),
      ],
    );
  }
}
