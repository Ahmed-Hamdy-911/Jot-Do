import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';
import 'your_recovery_code_widget.dart';

class CopyButton extends StatelessWidget {
  const CopyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BackupOptionItem(
      title: S.of(context).recovery_code_copy_button,
      icon: Icons.copy,
      onPressed: () {},
    );
  }
}
