import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import '../../../../../core/constants/constant.dart';
import '../../../../../core/widgets/constants_spaces_widgets.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/models/language_model.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final languages = [
      LanguageModel(flag: "🇺🇸", key: "english", locale: "en"),
      LanguageModel(flag: "🇪🇬", key: "arabic", locale: "ar"),
    ];
    String getLocalizedLanguageName(BuildContext context, String key) {
      switch (key) {
        case "english":
          return S.of(context).english;
        case "arabic":
          return S.of(context).arabic;
        default:
          return key;
      }
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: kToolbarHeight,
          ),
          CustomSettingItem(
            title: S.of(context).backup_sync,
            leadingIcon: Icons.backup_outlined,
            trailing: const Icon(Icons.restore),
            onTap: () {},
          ),
          const MediumSpace(),
          CustomSettingItem(
            title: S.of(context).language,
            leadingIcon: Icons.language,
            trailing: DropdownButton<LanguageModel>(
              value: languages[0],
              items: languages.map((element) {
                return DropdownMenuItem(
                  value: element,
                  child: Text(
                      "${element.flag} ${getLocalizedLanguageName(context, element.key)}"),
                );
              }).toList(),
              onChanged: (value) {},
            ),
            onTap: () {},
          ),
          const MediumSpace(),
          CustomSettingItem(
            title: S.of(context).theme,
            subTitle: S.of(context).light,
            leadingIcon: Icons.brightness_6_outlined,
            trailing: Switch(
              value: false,
              onChanged: (value) {},
            ),
          ),
          const MediumSpace(),
          CustomSettingItem(
            title: S.of(context).notification_settings,
            leadingIcon: IconlyBroken.notification,
            onTap: () {},
          ),
          const MediumSpace(),
          CustomSettingItem(
            title: S.of(context).about_app,
            leadingIcon: Icons.info_outline_rounded,
            onTap: () {},
          ),
          const MediumSpace(),
        ],
      ),
    );
  }
}

class CustomSettingItem extends StatelessWidget {
  const CustomSettingItem({
    super.key,
    required this.title,
    this.subTitle,
    required this.leadingIcon,
    this.trailing,
    this.onTap,
  });
  final String title;
  final String? subTitle;
  final IconData leadingIcon;
  final Widget? trailing;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(AppConstants.kRadius),
          side: const BorderSide(
            width: 1,
            color: Colors.black54,
          )),
      leading: Icon(leadingIcon),
      title: Text(title),
      subtitle: subTitle != null ? Text(subTitle!) : null,
      trailing:
          trailing == null ? const Icon(Icons.arrow_forward_ios_sharp) : trailing,
      onTap: onTap,
    );
  }
}
