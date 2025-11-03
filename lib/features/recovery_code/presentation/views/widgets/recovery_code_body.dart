import 'package:flutter/material.dart';

import '../../../../../core/widgets/components/components.dart';
import 'action_buttons_widget.dart';
import 'backup_label_widget.dart';
import 'recovery_instruction_widget.dart';
import 'warning_recovery_code_widget.dart';
import 'your_recovery_code_widget.dart';

class RecoveryCodeBody extends StatelessWidget {
  const RecoveryCodeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: [
        AppComponents.appBarPadding(context),
        const RecoveryInstructionWidget(),
        AppComponents.mediumVerticalSpace(),
        const WaringRecoveryCodeWidget(),
        AppComponents.largeVerticalSpace(),
        const RecoveryCodeWidget(),
        AppComponents.largeVerticalSpace(),
        const BackupLabelWidget(),
        AppComponents.largeVerticalSpace(),
        const ActionButtons(),
      ],
    );
  }
}
