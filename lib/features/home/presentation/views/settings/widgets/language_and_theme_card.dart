import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/cubits/settings/setting_cubit.dart';
import '../../../../../../core/widgets/constants_spaces_widgets.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../data/models/language_model.dart';
import 'setting_card.dart';
import 'setting_item.dart';

class LanguageAndThemeCard extends StatelessWidget {
  const LanguageAndThemeCard({super.key});

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

    var darkMode =
        context.watch<SettingCubit>().state.themeMode == ThemeMode.dark;
    var color = darkMode ? AppColor.grey600 : AppColor.whiteColor;
    return CustomSettingCard(
      child: Column(
        children: [
          CustomSettingItem(
            title: S.of(context).language,
            leadingIcon: Icons.language,
            trailing: DropdownButton<LanguageModel>(
              dropdownColor: color,
              underline: const SizedBox(),
              value: context.watch<SettingCubit>().state.locale ==
                      const Locale(
                        "en",
                      )
                  ? languages[0]
                  : languages[1],
              items: languages.map((element) {
                return DropdownMenuItem(
                  value: element,
                  child: Text(
                      "${element.flag} ${getLocalizedLanguageName(context, element.key)}"),
                );
              }).toList(),
              onChanged: (value) {
                context
                    .read<SettingCubit>()
                    .toggleLanguage(Locale(value!.locale));
              },
            ),
          ),
          const MediumSpace(),
          CustomSettingItem(
            title: S.of(context).theme,
            subTitleText: darkMode ? S.of(context).dark : S.of(context).light,
            leadingIcon: Icons.brightness_6_outlined,
            trailing: Switch(
              value: darkMode,
              onChanged: (value) {
                context.read<SettingCubit>().toggleTheme();
              },
            ),
          ),
        ],
      ),
    );
  }
}
