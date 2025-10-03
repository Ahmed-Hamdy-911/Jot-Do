import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../core/helper/cache_helper.dart';
import '../../../../../core/models/message_type.dart';
import '../../../../../core/routing/app_routes.dart';
import '../../../../../core/widgets/components/components.dart';
import '../../../../../core/widgets/buttons/custom_button.dart';
import '../../../../../core/widgets/components/custom_snackbar.dart';
import '../../../../../generated/l10n.dart';
import '../../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../../auth/presentation/cubit/auth_states.dart';
import '../../../../../core/widgets/custom/custom_card.dart';
import '../../../../../core/widgets/custom/custom_list_title.dart';

class AccountSettingCard extends StatelessWidget {
  const AccountSettingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn =
        CacheHelper.getData(key: AppConstants.isLoggedIn) ?? false;
    var colors = SmartAppColor(context);
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is AuthLoggedOut) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.splash,
            (route) => false,
          );
        } else if (state is AuthReLogin) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.onBoarding,
            (route) => false,
          );
        } else if (state is AuthFailure) {
          CustomSnackBar.showSnackBar(
            state.error,
            context,
            MessageType.error,
          );
        }
      },
      builder: (context, state) {
        return CustomCard(
          child: Column(
            children: [
              CustomListTitle(
                title: S.of(context).profile,
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
              AppComponents.mediumVerticalSpace(),
              CustomButton(
                  text: isLoggedIn ? S.of(context).logout : S.of(context).login,
                  onPressed: () async {
                    if (isLoggedIn) {
                      showDialog(
                        context: context,
                        builder: (context) => const LogOutDialog(),
                      );
                      // await context.read<AuthCubit>().logout();
                    } else {
                      context.read<AuthCubit>().reLogin();
                    }
                  },
                  borderColor: colors.border,
                  widget: state is AuthLoadingState
                      ? AppComponents.customCircleLoading(color: colors.primary)
                      : Icon(
                          isLoggedIn ? IconlyLight.logout : IconlyLight.login,
                          color: colors.textPrimary,
                          size: AppConstants.scaledSp(20),
                        ),
                  style: AppConstants.buttonPrimaryStyle(colors.textPrimary),
                  bgColor: colors.backgroundMuted)
            ],
          ),
        );
      },
    );
  }
}

class LogOutDialog extends StatelessWidget {
  const LogOutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    var screenSize = MediaQuery.of(context).size;
    return Center(
        child: Material(
            color: Colors.transparent,
            child: Container(
              width: screenSize.width >= 600 ? 600 : screenSize.width,
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(color: colors.border),
                color: colors.backgroundScreen,
                borderRadius: BorderRadius.circular(AppConstants.kRadius),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(S.of(context).logout,
                      style: AppConstants.bodyLargeStyle(colors.textPrimary)),
                  AppComponents.mediumVerticalSpace(),
                  Text(
                    S.of(context).signOutConfirmation,
                    textAlign: TextAlign.center,
                    style: AppConstants.bodySmallStyle(colors.textSecondary),
                  ),
                  AppComponents.mediumVerticalSpace(),
                  Column(
                    children: [
                      CustomButton(
                        text: S.of(context).logout,
                        style:
                            AppConstants.buttonPrimaryStyle(colors.textInverse),
                        bgColor: colors.reverseBackgroundColor,
                        onPressed: () {
                          context.read<AuthCubit>().logout();
                          Navigator.pop(context);
                        },
                      ),
                      AppComponents.smallVerticalSpace(),
                      CustomButton(
                        text: S.of(context).cancel,
                        style: AppConstants.buttonSecondaryStyle(
                            colors.textPrimary),
                        bgColor: colors.backgroundMuted,
                        borderColor: colors.border,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  )
                ],
              ),
            )));
  }
}
