import 'package:flutter/material.dart';
import '../../../../core/widgets/components/empty_widget.dart';
import '../../../../generated/l10n.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyWidget(text: S.of(context).no_tasks_yet);
  }
}
