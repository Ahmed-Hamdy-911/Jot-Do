import 'package:flutter/material.dart';
import '../../../../core/constants/constant.dart';
import '../../../../generated/l10n.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.tabController});
  final TabController tabController;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      bottom: TabBar(
        dividerColor: Colors.white70,
        indicatorSize: TabBarIndicatorSize.label,
        controller: tabController,
        unselectedLabelColor: Colors.grey[800],
        labelColor: AppConstants.colorScheme,
        indicatorColor: AppConstants.colorScheme.shade800,
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
