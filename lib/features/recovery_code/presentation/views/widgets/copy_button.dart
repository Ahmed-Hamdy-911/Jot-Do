import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';
import 'backup_option_item.dart';

class CopyButton extends StatelessWidget {
  const CopyButton({super.key, this.bgColor});
final Color? bgColor;
  @override
  Widget build(BuildContext context) {
    return BackupOptionItem(
      title: S.of(context).recovery_code_copy_button,
      bgColor: bgColor,
      icon: Icons.copy,
      onPressed: () {},
    );
  }
}
