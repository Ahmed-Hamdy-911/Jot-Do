import 'package:flutter/material.dart';
import 'package:jot_do/core/constants/constant.dart';
import 'package:jot_do/generated/l10n.dart';
import '../../../../../core/routing/app_routes.dart';
import '../../../../../core/widgets/constants_spaces_widgets.dart';
import '../../../../on_boarding/presentation/widgets/custom_skip_button.dart';
import '../../widgets/auth_exited_text.dart';
import '../../widgets/form_login.dart';
import '../../widgets/login_extras_widgets.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    String title = S.of(context).login_welcome;
    String subtitle = S.of(context).login_call_to_action;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          CustomSkipButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.home);
            },
          ),
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth >= 600) {
          return Center(
            child: SingleChildScrollView(
              child: Padding(
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
                        Expanded(
                          flex: 1,
                          child: FormLogin(
                              formKey: formKey,
                              emailController: emailController,
                              passwordController: passwordController),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: VerticalDivider(
                            color: AppConstants.colorScheme.shade100,
                            indent: 30,
                            endIndent: 20,
                            thickness: 2,
                            width: 50,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: LoginExtrasWidget(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AuthExcitedText(
                      title: title,
                      subtitle: subtitle,
                    ),
                    FormLogin(
                        formKey: formKey,
                        emailController: emailController,
                        passwordController: passwordController),
                    const MediumSpace(),
                    LoginExtrasWidget(),
                  ],
                ),
              ),
            ),
          );
        }
      }),
    );
  }
}
