import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/cubits/settings/setting_cubit.dart';
import '../../../../../core/helper/cache_helper.dart';
import '../../../../../core/routing/app_routes.dart';
import '../../../../../core/widgets/constants_spaces_widgets.dart';
import '../../../../../generated/l10n.dart';
import '../../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../../auth/presentation/cubit/auth_states.dart';
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

    bool isLoggedIn = CacheHelper.getData(key: "isLoggedIn") ?? false;

    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is AuthLoggedOut) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.splash,
            (route) => false,
          );
        }
      },
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSettingCard(
                child: Column(
                  children: [
                    CustomSettingItem(
                      title: S.of(context).account,
                      leadingIcon: IconlyLight.profile,
                      onTap: () {
                        if (isLoggedIn) {
                          Navigator.pushNamed(context, AppRoutes.profile);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              closeIconColor: Colors.red,
                              showCloseIcon: true,
                              content: Text(S.of(context).please_login_first),
                            ),
                          );
                        }
                      },
                    ),
                    CustomSettingItem(
                      title: S.of(context).backup_sync,
                      leadingIcon: Icons.backup_outlined,
                      trailing: const Icon(Icons.restore),
                      onTap: () {},
                    ),
                    CustomSettingItem(
                      title: isLoggedIn
                          ? S.of(context).logout
                          : S.of(context).login,
                      leadingIcon:
                          isLoggedIn ? IconlyLight.logout : IconlyLight.login,
                      onTap: () async {
                        if (isLoggedIn) {
                          await context.read<AuthCubit>().logout();
                        } else {
                          CacheHelper.saveData(
                              key: "skipAuthentication", value: false);
                          Navigator.pushNamed(context, AppRoutes.login);
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SmallSpace(),
              CustomSettingCard(
                child: Column(
                  children: [
                    CustomSettingItem(
                      title: S.of(context).language,
                      leadingIcon: Icons.language,
                      trailing: DropdownButton<LanguageModel>(
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
                      subTitle: S.of(context).light,
                      leadingIcon: Icons.brightness_6_outlined,
                      trailing: Switch(
                        value: context.watch<SettingCubit>().state.themeMode ==
                            ThemeMode.dark,
                        onChanged: (value) {
                          context.read<SettingCubit>().toggleTheme();
                        },
                      ),
                    ),
                  ],
                ),
              ),
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
      leading: Icon(leadingIcon),
      title: Text(title),
      subtitle: subTitle != null ? Text(subTitle!) : null,
      trailing: trailing == null
          ? const Icon(Icons.arrow_forward_ios_sharp)
          : trailing,
      onTap: onTap,
    );
  }
}

class CustomSettingCard extends StatelessWidget {
  const CustomSettingCard({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.white70,
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(vertical: 6.0),
        child: child,
      ),
    );
  }
}
