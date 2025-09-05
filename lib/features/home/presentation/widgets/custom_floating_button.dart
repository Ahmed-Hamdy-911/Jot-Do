import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../generated/l10n.dart';
import '../../../../core/constants/app_constants.dart';

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColor.mainLightColor.withValues(alpha: 0.8),
      foregroundColor: Colors.white,
      onPressed: () {
        final currentIndex = AppConstants.homeBodyIndex;
        if (currentIndex == 0) {
          Navigator.pushNamed(context, AppRoutes.addNote);
        } else {
          Navigator.pushNamed(context, AppRoutes.addTask);
        }
      },
      shape: const CircleBorder(),
      tooltip: S.of(context).add_note_or_task,
      child: const Icon(Icons.add),
    );
  }
}
