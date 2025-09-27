import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../core/widgets/app_logo.dart';
import '../../../../../core/widgets/components.dart';
import '../../../../../core/widgets/custom_loading.dart';
import '../../../../../core/widgets/custom_text_and_text_button.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/routing/app_routes.dart';
import '../../cubit/auth_cubit.dart';
import '../../cubit/auth_states.dart';
import '../../widgets/auth_exited_text.dart';
import '../../widgets/login_form.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    String title = S.of(context).welcome_back;
    String subtitle = S.of(context).login_call_to_action;
    return Scaffold(
      backgroundColor: SmartAppColor(context).backgroundScreen,
      appBar: AppBar(),
      body: CustomLoading(
        state: context.watch<AuthCubit>().state is AuthLoadingState,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                const AppLogo(),
                AuthExcitedText(
                  title: title,
                  subtitle: subtitle,
                ),
                LayoutBuilder(builder: (context, constraints) {
                  if (constraints.maxWidth >= 600) {
                    return ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 600),
                        child: const LoginForm());
                  } else {
                    return const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: LoginForm(),
                    );
                  }
                }),
                AppComponents.mediumVerticalSpace(),
                CustomTextAndTextButton(
                    textTitle: S.of(context).dont_have_account,
                    textButtonTitle: S.of(context).register,
                    fontSize: MediaQuery.sizeOf(context).width < 600 ? 15 : 17,
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.register);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
