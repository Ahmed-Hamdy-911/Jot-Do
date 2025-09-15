import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/cubits/settings/setting_cubit.dart';
import '../../../../core/models/message_type.dart';
import '../../../../core/widgets/constants_spaces_widgets.dart';
import '../../../../core/widgets/custom_snackbar.dart';
import '../../../../generated/l10n.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_states.dart';

class SocialAuthWidget extends StatelessWidget {
  const SocialAuthWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var darkMode =
        context.watch<SettingCubit>().state.themeMode == ThemeMode.dark;
    var googleBGColor = darkMode ? AppColor.blueDarkColor : AppColor.blueColor;
    return Center(
      child: Column(
        children: [
          SocialCard(
            widget: Image.asset(AppAssets.googleLogo, height: 35),
            text: S.of(context).google,
            color: googleBGColor,
            textColor: AppColor.whiteColor,
            onPressed: () async {
              await context.read<AuthCubit>().signInWithGoogle();
            },
            isLoading:
                context.watch<AuthCubit>().state is AuthLoadingGoogleSignIn,
          ),
          const SmallSpace(),
          SocialCard(
            widget: const Icon(Icons.apple_rounded,
                size: 35, color: AppColor.blackColor),
            text: S.of(context).apple,
            onPressed: () {
              CustomSnackBar.showSnackBar(
                  S.of(context).comingSoon, context, MessageType.info);
            },
            isLoading: false,
          ),
        ],
      ),
    );
  }
}

class SocialCard extends StatelessWidget {
  const SocialCard({
    super.key,
    required this.widget,
    required this.text,
    required this.isLoading,
    this.onPressed,
    this.color,
    this.textColor = AppColor.blackColor,
  });
  final Widget widget;
  final String text;
  final void Function()? onPressed;
  final Color? color;
  final Color textColor;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    var darkMode =
        context.watch<SettingCubit>().state.themeMode == ThemeMode.dark;
    var backgroundColor = darkMode ? AppColor.grey600 : AppColor.whiteColor;
    var textColor = darkMode ? AppColor.white70 : AppColor.blackColor;

    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.kRadius)),
      color: color ?? backgroundColor,
      minWidth: screenWidth < 600 ? screenWidth : screenWidth * 0.6,
      height: AppConstants.kMaterialButtonHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              widget,
              const SizedBox(width: 10),
              Text(text,
                  style: TextStyle(
                    fontSize: screenWidth < 600 ? 15 : 17,
                    color: textColor,
                  )),
            ],
          ),
          if (isLoading)
            const CircularProgressIndicator(color: AppColor.whiteColor)
        ],
      ),
    );
  }
}
