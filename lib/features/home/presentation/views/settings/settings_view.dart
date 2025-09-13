import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import '../../../../../core/widgets/constants_spaces_widgets.dart';
import '../../../../../generated/l10n.dart';
import 'widgets/account_and_backup_card.dart';
import 'widgets/delete_all_data_card.dart';
import 'widgets/language_and_theme_card.dart';
import 'widgets/setting_card.dart';
import 'widgets/setting_item.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AccountAndBackupSettingsCard(),
              const SmallSpace(),
              const DeleteAllDataCard(),
              const SmallSpace(),
              const LanguageAndThemeCard(),
              const SmallSpace(),
              CustomSettingCard(
                child: CustomSettingItem(
                  title: S.of(context).notification_settings,
                  leadingIcon: IconlyBroken.notification,
                  onTap: () {},
                ),
              ),
              const SmallSpace(),
              CustomSettingCard(
                child: CustomSettingItem(
                  title: S.of(context).about_app,
                  leadingIcon: Icons.info_outline_rounded,
                  onTap: () {},
                ),
              ),
              const SmallSpace(),
            ],
          ),
        ),
      ),
    );
  }
}
