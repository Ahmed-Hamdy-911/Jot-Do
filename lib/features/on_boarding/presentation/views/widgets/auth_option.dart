import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../core/routing/app_routes.dart';
import '../../../../../core/widgets/components/components.dart';
import '../../../../../core/widgets/buttons/custom_button.dart';
import '../../../../../generated/l10n.dart';
import '../../../../auth/presentation/cubit/auth_cubit.dart';

class AuthOptions extends StatelessWidget {
  const AuthOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = SmartAppColor(context);
    return Column(
      children: [
        AppComponents.largeVerticalSpace(),
        CustomButton(
          text: S.of(context).continueWithGoogle,
          bgColor: colors.fillColor,
          borderColor: colors.border,
          style: AppConstants.buttonPrimaryStyle(colors.textPrimary),
          widget: Image.asset(AppAssets.googleLogo, height: 25),
          onPressed: () async {
            await context.read<AuthCubit>().signInWithGoogle();
          },
        ),
        AppComponents.mediumVerticalSpace(),
        CustomButton(
          text: S.of(context).signInWithEmail,
          bgColor: colors.reverseBackgroundColor,
          borderColor: colors.border,
          style: AppConstants.buttonPrimaryStyle(colors.reverseTextColor),
          widget: Icon(
            Icons.email_outlined,
            color: colors.reverseTextColor,
            size: AppConstants.scaledSp(25),
          ),
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.login);
          },
        ),
        AppComponents.mediumVerticalSpace(),
        CustomButton(
          text: S.of(context).continueWithoutAccount,
          bgColor: colors.backgroundScreen,
          style: AppConstants.buttonPrimaryStyle(colors.textSecondary),
          onPressed: () {
            context.read<AuthCubit>().continueWithoutAccount();
          },
        ),
        AppComponents.largeVerticalSpace(),
      ],
    );
  }
}
