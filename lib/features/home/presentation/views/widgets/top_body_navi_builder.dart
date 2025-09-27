import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../generated/l10n.dart';
import 'top_body_item.dart';

class TopBodyNavigation extends StatelessWidget {
  const TopBodyNavigation({
    super.key,
    required this.pageController,
  });
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    var screenSize = MediaQuery.sizeOf(context);
    return Ink(
      height: 50,
      width: screenSize.width,
      decoration: BoxDecoration(
        color: colors.backgroundSecondary,
        borderRadius: BorderRadius.circular(AppConstants.kRadius),
      ),
      child: Row(
        children: [
          TopBodyItem(
            pageController: pageController,
            selectedIndex: 0,
            title: S.of(context).your_notes,
            icon: IconlyLight.document,
          ),
          TopBodyItem(
            pageController: pageController,
            selectedIndex: 1,
            title: S.of(context).your_tasks,
            icon: Icons.check_box_outlined,
            isEndItem: true,
          ),
        ],
      ),
    );
  }
}
