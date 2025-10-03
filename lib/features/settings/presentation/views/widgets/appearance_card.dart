import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../core/widgets/components/components.dart';
import '../../cubits/setting_cubit.dart';
import '../../../../../generated/l10n.dart';
import '../../../data/models/language_model.dart';
import '../../../../../core/widgets/custom/custom_card.dart';
import '../../../../../core/widgets/custom/custom_list_title.dart';

class AppearanceSettingCard extends StatelessWidget {
  const AppearanceSettingCard({super.key});

  @override
  Widget build(BuildContext context) {
    var languages = AppConstants.languages;
    var colors = SmartAppColor(context);
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

    return CustomCard(
      title: S.of(context).appearance,
      child: Column(
        children: [
          CustomListTitle(
            title: S.of(context).theme,
            subTitleText: darkMode ? S.of(context).dark : S.of(context).light,
            leadingIcon: darkMode
                ? Icons.brightness_2_outlined
                : Icons.brightness_5_outlined,
            trailing: AppComponents.customSwitchButton(
              colors: colors,
              value: darkMode,
              onChanged: (value) {
                context.read<SettingCubit>().toggleTheme();
              },
            ),
          ),
          AppComponents.customDivider(30),
          CustomListTitle(
            title: S.of(context).language,
            leadingIcon: Icons.language,
            trailing: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstants.kRadius - 6),
                border: Border.all(color: colors.border),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DropdownButton<LanguageModel>(
                dropdownColor: colors.backgroundScreen,
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
          ),
        ],
      ),
    );
  }
}
