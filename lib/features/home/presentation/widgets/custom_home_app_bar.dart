import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/cubits/settings/setting_cubit.dart';
import '../../../../generated/l10n.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key, required this.tabController});
  final TabController tabController;
  @override
  Widget build(BuildContext context) {
    var isDarkMode =
        context.watch<SettingCubit>().state.themeMode == ThemeMode.dark;
    return AppBar(
      elevation: 0,
      backgroundColor: AppColor.mainLightColor,
      bottom: TabBar(
        dividerColor: AppColor.transparentColor,
        indicatorSize: TabBarIndicatorSize.label,
        controller: tabController,
        unselectedLabelColor: AppColor.white70,
        labelColor: isDarkMode ? AppColor.white70 : AppColor.whiteColor,
        indicatorColor: isDarkMode ? AppColor.white70 : AppColor.whiteColor,
        labelStyle: const TextStyle(fontSize: 15),
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
