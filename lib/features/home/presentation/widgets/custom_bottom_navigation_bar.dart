import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../generated/l10n.dart';
import 'bottom_app_bar_item.dart';

class CustomBottomNaviAppBar extends StatelessWidget {
  const CustomBottomNaviAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    return BottomAppBar(
      height: kBottomNavigationBarHeight,
      shape: const CircularNotchedRectangle(),
      color: AppColor.mainLightColor.withValues(alpha: 0.9),
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          BottomAppBarItem(
            pageIndex: 0,
            iconSelected: IconlyBold.home,
            iconUnSelected: IconlyLight.home,
            title: S.of(context).home,
          ),
          SizedBox(width: screenWidth * 0.16),
          BottomAppBarItem(
            pageIndex: 1,
            iconSelected: IconlyBold.setting,
            iconUnSelected: IconlyLight.setting,
            title: S.of(context).settings,
          ),
        ],
      ),
    );
  }
}
