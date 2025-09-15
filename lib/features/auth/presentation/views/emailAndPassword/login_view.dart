import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/cubits/connectivity/connection_cubit.dart';
import '../../../../../core/cubits/connectivity/connection_state.dart';
import '../../../../../core/models/message_type.dart';
import '../../../../../core/widgets/custom_snackbar.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/routing/app_routes.dart';
import '../../../../../core/widgets/constants_spaces_widgets.dart';
import '../../../../on_boarding/presentation/widgets/custom_skip_button.dart';
import '../../../data/repository/cache_auth_repo.dart';
import '../../cubit/auth_cubit.dart';
import '../../cubit/auth_states.dart';
import '../../widgets/auth_exited_text.dart';
import '../../widgets/login_form.dart';
import '../../widgets/login_extras_widgets.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    String title = S.of(context).welcome_back;
    String subtitle = S.of(context).login_call_to_action;
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthCubit, AuthStates>(
          listener: (context, state) {
            debugPrint("Listener triggered with state: //$state");
            if (state is AuthSuccess ||
                state is AuthEmailVerified ||
                state is AuthGoogleSignInSuccess) {
              Navigator.pushReplacementNamed(context, AppRoutes.home);
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
          listenWhen: (previous, current) => previous != current,
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
      child: AbsorbPointer(
        absorbing: context.watch<AuthCubit>().state is AuthLoadingState ||
            context.watch<AuthCubit>().state is AuthLoadingGoogleSignIn,
        child: Scaffold(
          body: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: CustomSkipButton(
                      onPressed: () {
                        CacheAuthRepo.skipAuthentication();
                        Navigator.pushReplacementNamed(context, AppRoutes.home);
                      },
                    ),
                  ),
                  LayoutBuilder(builder: (context, constraints) {
                    if (constraints.maxWidth >= 600) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            AuthExcitedText(
                              title: title,
                              subtitle: subtitle,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: LoginForm(),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  child: VerticalDivider(
                                    color: AppColor.colorScheme.shade100,
                                    indent: 30,
                                    endIndent: 20,
                                    thickness: 2,
                                    width: 50,
                                  ),
                                ),
                                const Expanded(
                                  flex: 1,
                                  child: LoginExtrasWidget(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AuthExcitedText(
                              title: title,
                              subtitle: subtitle,
                            ),
                            const LoginForm(),
                            const MediumSpace(),
                            const LoginExtrasWidget(),
                          ],
                        ),
                      );
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
