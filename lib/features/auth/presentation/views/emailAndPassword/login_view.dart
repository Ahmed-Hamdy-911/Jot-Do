import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/colors/app_colors.dart';
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
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        debugPrint("Listener triggered with state: $state");
        if (state is AuthSuccess ||
            state is AuthEmailVerified ||
            state is AuthGoogleSignInSuccess) {
          Navigator.pushReplacementNamed(context, AppRoutes.home);
        } else if (state is GoVerificationState) {
          Navigator.pushNamed(
            context,
            AppRoutes.verifyEmail,
            arguments: state.email,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message!)),
          );
        }
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
        if (state is AuthEmailVerificationSent) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message!)),
          );
        }
        if (state is AuthEmailVerificationNeeded) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message!)),
          );
        }
      },
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
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.home,
                          (route) => false,
                        );
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
