import 'package:flutter/material.dart';
import '../../../../../core/constants/colors/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/routing/app_routes.dart';
import '../../../../../core/widgets/constants_spaces_widgets.dart';
import '../../../../on_boarding/presentation/widgets/custom_skip_button.dart';
import '../../../data/repository/cache_auth_repo.dart';
import '../../widgets/auth_exited_text.dart';
import '../../widgets/login_form.dart';
import '../../widgets/login_extras_widgets.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    String title = S.of(context).welcome_back;
    String subtitle = S.of(context).login_call_to_action;
    return Scaffold(
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
                              height: MediaQuery.of(context).size.height * 0.5,
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
    );
  }
}
