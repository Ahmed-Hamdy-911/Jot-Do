import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:jot_do/core/constants/constant.dart';
import '../../../../generated/l10n.dart';
import 'bottom_app_bar_item.dart';

class CustomBottomNaviAppBar extends StatelessWidget {
  const CustomBottomNaviAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    return BottomAppBar(
      height: kBottomNavigationBarHeight,
      shape: CircularNotchedRectangle(),
      color: AppConstants.mainLightColor.withOpacity(0.9),
      elevation: 0,
      padding: EdgeInsets.symmetric(horizontal: 12),
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
