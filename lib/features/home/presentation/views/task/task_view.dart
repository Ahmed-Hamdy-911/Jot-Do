import 'package:flutter/material.dart';
import '../../../../../generated/l10n.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(S.of(context).your_tasks),
    );
  }
}
