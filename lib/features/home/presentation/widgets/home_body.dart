import 'package:flutter/material.dart';
import '../../../../core/constants/constant.dart';


class HomeBody extends StatelessWidget {
  const HomeBody({super.key, required this.tabController});
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TabBarView(
        controller: tabController,
        children: AppConstants.homeBodyList,
      ),
    );
  }
}
