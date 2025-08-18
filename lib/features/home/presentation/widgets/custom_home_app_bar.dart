import 'package:flutter/material.dart';
import '../../../../core/constants/constant.dart';
import '../../../../generated/l10n.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key, required this.tabController});
  final TabController tabController;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppConstants.mainLightColor.withValues(alpha: 0.9),
      bottom: TabBar(
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.label,
        controller: tabController,
        unselectedLabelColor: AppConstants.mainDarkColor.withValues(alpha: 0.9),
        labelColor: Colors.white,
        indicatorColor: AppConstants.colorScheme.shade800,
        labelStyle: TextStyle(fontSize: 16),
        tabs: [
          Tab(
            text: S.of(context).your_notes,
          ),
          Tab(
            text: S.of(context).your_tasks,
          ),
        ],
      ),
    );
  }
}
