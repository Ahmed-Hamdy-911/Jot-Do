import 'package:flutter/material.dart';
import 'package:jot_do/core/routing/app_routes.dart';
import 'package:jot_do/generated/l10n.dart';
import 'package:jot_do/core/constants/constant.dart';

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppConstants.mainLightColor.withOpacity(0.8),
      foregroundColor: Colors.white,
      onPressed: () {
        final currentIndex = AppConstants.homeBodyIndex;
        if (currentIndex == 0) {
          Navigator.pushNamed(context, AppRoutes.addNote);
        } else {
          Navigator.pushNamed(context, AppRoutes.addTask);
        }
      },
      shape: CircleBorder(),
      tooltip: S.of(context).add_note_or_task,
      child: Icon(Icons.add),
    );
  }
}
