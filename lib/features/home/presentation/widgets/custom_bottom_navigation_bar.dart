import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import '../../../../generated/l10n.dart';
import 'bottom_app_bar_item.dart';

class CustomBottomNaviAppBar extends StatelessWidget {
  const CustomBottomNaviAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    return BottomAppBar(
      height: kBottomNavigationBarHeight,
      color: Colors.white,
      shape: CircularNotchedRectangle(),
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
          SizedBox(width: screenWidth * 0.03),
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
