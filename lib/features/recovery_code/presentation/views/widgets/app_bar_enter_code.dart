import 'package:flutter/material.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../core/widgets/custom/custom_blur_widget.dart';
import '../../../../../generated/l10n.dart';

class AppBarEnterCode extends StatelessWidget {
  const AppBarEnterCode({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    return CustomBlurWidget(
      child: AppBar(
        backgroundColor: colors.backgroundScreen.withValues(alpha: 0.1),
        title: Text(S.of(context).enterRecoveryCode),
        bottom: Tab(
          child: TabBar(
            controller: tabController,
            overlayColor: WidgetStatePropertyAll(
                colors.reverseBackgroundColor.withValues(alpha: 0.1)),
            dividerColor: colors.transparent,
            labelColor: colors.blue,
            labelStyle: AppConstants.bodyMediumStyle(colors.blue),
            unselectedLabelColor: colors.grey,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: colors.blue,
                  width: 3.0,
                ),
              ),
            ),
            tabs: [
              Tab(
                text: S.of(context).with_code,
              ),
              Tab(
                icon: Icon(
                  Icons.qr_code_scanner,
                  color: tabController.index == 1 ? colors.blue : colors.grey,
                  size: 35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
