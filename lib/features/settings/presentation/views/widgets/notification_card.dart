import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../core/widgets/components.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/widgets/custom_card.dart';
import '../../../../../core/widgets/custom_list_title.dart';

class NotificationSettingCard extends StatelessWidget {
  const NotificationSettingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    return CustomCard(
        title: S.of(context).notifications,
        child: Column(children: [
          CustomListTitle(
              title: S.of(context).push_notification,
              subTitleText: S.of(context).push_notification_description,
              leadingIcon: IconlyLight.notification,
              trailing: AppComponents.customSwitchButton(
                colors: colors,
                value: true,
                onChanged: (value) {},
              ))
        ]));
  }
}
