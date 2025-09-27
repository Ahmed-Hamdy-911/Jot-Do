import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../../core/widgets/components.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/models/on_boarding_model.dart';
import 'on_boarding_item.dart';

class OnBoardingBodyBodyBuilder extends StatelessWidget {
  const OnBoardingBodyBodyBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final List<OnBoardingModel> _pages = [
      OnBoardingModel(
        title: S.of(context).worksOffline,
        description: S.of(context).offlineDescription,
        icon: IconlyLight.document,
      ),
      OnBoardingModel(
        title: S.of(context).autoSyncBackup,
        description: S.of(context).syncDescription,
        icon: Icons.cloud_outlined,
      ),
      OnBoardingModel(
        title: S.of(context).securePrivate,
        description: S.of(context).securityDescription,
        icon: Icons.privacy_tip_outlined,
      ),
    ];
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => OnBoardingItem(
            icon: _pages[index].icon,
            title: _pages[index].title,
            subTitle: _pages[index].description,
          ),
          separatorBuilder: (context, index) =>
              AppComponents.mediumVerticalSpace(),
          itemCount: _pages.length,
        ),
      ],
    );
  }
}
