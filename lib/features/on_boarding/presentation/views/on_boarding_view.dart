
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/colors/smart_app_color.dart';
import '../../../../core/cubits/connectivity/connection_cubit.dart';
import '../../../../core/cubits/connectivity/connection_state.dart';
import '../../../../core/models/message_type.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/components/app_logo.dart';
import '../../../../core/widgets/components/components.dart';
import '../../../../core/widgets/custom/custom_loading.dart';
import '../../../../core/widgets/components/custom_snackbar.dart';
import '../../../../generated/l10n.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../auth/presentation/cubit/auth_states.dart';
import 'widgets/auth_option.dart';
import 'widgets/on_boarding_builder.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = SmartAppColor(context);

    return Scaffold(
      backgroundColor: colors.backgroundScreen,
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthCubit, AuthStates>(
            listener: (context, state) {
              debugPrint("Listener triggered with state: //$state");
              if (state is AuthSuccess ||
                  state is AuthEmailVerified ||
                  state is AuthGoogleSignInSuccess ||
                  state is AuthContinueWithoutAccount) {
                // final appSession = AppSession.instance;
                // log('[TEST] appSession: $appSession');
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.home,
                  (route) => false,
                );
              } else if (state is GoVerificationState) {
                CustomSnackBar.showSnackBar(
                  state.message!,
                  context,
                  MessageType.warning,
                );
                Navigator.pushNamed(
                  context,
                  AppRoutes.verifyEmail,
                  arguments: state.email,
                );
              }
              if (state is AuthFailure) {
                CustomSnackBar.showSnackBar(
                  state.error,
                  context,
                  MessageType.error,
                );
              }
              if (state is AuthEmailVerificationSent) {
                CustomSnackBar.showSnackBar(
                  state.message!,
                  context,
                  MessageType.success,
                );
              }
              if (state is AuthEmailVerificationNeeded) {
                CustomSnackBar.showSnackBar(
                  state.message!,
                  context,
                  MessageType.warning,
                );
              }
              if (state is AuthGoogleSignInFailure) {
                CustomSnackBar.showSnackBar(
                  state.error,
                  context,
                  MessageType.error,
                );
              }
            },
          ),
          BlocListener<ConnectionCubit, ConnectionStates>(
            listener: (context, state) {
              if (state is ConnectionDisconnected) {
                CustomSnackBar.showSnackBar(
                  S.of(context).noInternet,
                  context,
                  MessageType.error,
                );
              } else if (state is ConnectionTimeOut) {
                CustomSnackBar.showSnackBar(
                  S.of(context).noInternet,
                  context,
                  MessageType.info,
                );
              } else if (state is ConnectionReconnected) {
                CustomSnackBar.showSnackBar(
                  S.of(context).connectedInternet,
                  context,
                  MessageType.success,
                );
              }
            },
          ),
        ],
        child: CustomLoading(
          state: context.watch<AuthCubit>().state is AuthLoadingGoogleSignIn,
          child: LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth >= 600) {
              return const Center(
                child: SingleChildScrollView(child: onBoardingBody(width: 600)),
              );
            }
            return const Center(
                child: SingleChildScrollView(
                    child: Padding(
              padding: EdgeInsets.all(12.0),
              child: onBoardingBody(),
            )));
          }),
        ),
      ),
    );
  }
}

class onBoardingBody extends StatelessWidget {
  const onBoardingBody({
    super.key,
    this.width,
  });
  final double? width;

  @override
  Widget build(BuildContext context) {
    final colors = SmartAppColor(context);
    final size = MediaQuery.of(context).size;

    return Container(
      constraints: BoxConstraints(maxWidth: size.height),
      width: width ?? size.width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: kToolbarHeight,
          ),
          const AppLogo(),
          AppComponents.mediumVerticalSpace(),
          Text(
            S.of(context).appDescription,
            style: AppConstants.bodyMediumStyle(colors.textSecondary),
          ),
          AppComponents.mediumVerticalSpace(),
          const OnBoardingBodyBodyBuilder(),
          AppComponents.mediumVerticalSpace(),
          const AuthOptions(),
          AppComponents.largeVerticalSpace(),
          Text(
            S.of(context).termsAgreement,
            style: AppConstants.captionStyle(colors.textSecondary),
          ),
          AppComponents.smallVerticalSpace(),
        ],
      ),
    );
  }
}
