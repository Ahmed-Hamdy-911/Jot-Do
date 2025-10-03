import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/colors/smart_app_color.dart';
import '../../../../../core/widgets/buttons/custom_material_button.dart';
import '../../../../../core/widgets/components/components.dart';
import '../../../../../core/widgets/custom/custom_loading.dart';
import '../../cubit/auth_cubit.dart';
import '../../cubit/auth_states.dart';
import '../../widgets/auth_exited_text.dart';
import '../../../../../generated/l10n.dart';

import '../../widgets/custom_email_field.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is AuthPasswordResetEmailSent) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message!)),
            );
            Navigator.pop(context);
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          var value = state is AuthLoadingState;
          if (state is AuthLoadingState) {
            return CustomLoading(child: const SizedBox.expand(), state: value);
          }

          return Column(
            children: [
              AppComponents.smallVerticalSpace(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: LayoutBuilder(builder: (context, constraints) {
                  if (constraints.maxWidth >= 600) {
                    return Center(
                      child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 600),
                          child: const ForgotPasswordForm()),
                    );
                  }
                  return const ForgotPasswordForm();
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  void forgotPasswordMethod(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().forgotPassword(
            email: _emailController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: SmartAppColor(context).border),
        borderRadius: BorderRadius.circular(AppConstants.kRadius),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AuthExcitedText(
              title: S.of(context).forgot_password,
              subtitle: S.of(context).send_password_reset),
          Form(
            key: _formKey,
            child: CustomEmailField(emailController: _emailController),
          ),
          AppComponents.largeVerticalSpace(),
          CustomMaterialButton(
            onPressed: () {
              forgotPasswordMethod(context);
            },
            text: S.of(context).send,
          )
        ],
      ),
    );
  }
}
