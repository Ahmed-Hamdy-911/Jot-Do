import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/constants_spaces_widgets.dart';
import '../../cubit/auth_cubit.dart';
import '../../cubit/auth_states.dart';
import '../../widgets/auth_exited_text.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/widgets/custom_material_button.dart';

import '../../widgets/custom_email_field.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
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
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: LayoutBuilder(builder: (context, constraints) {
              if (constraints.maxWidth >= 600) {
                return Center(
                  child: SingleChildScrollView(
                    child: SizedBox(
                      width: constraints.maxWidth * 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AuthExcitedText(
                            title: S.of(context).reset_password,
                            subtitle: S.of(context).send_password_reset,
                          ),
                          Form(
                            key: _formKey,
                            child: CustomEmailField(
                                emailController: _emailController),
                          ),
                          const MediumSpace(),
                          CustomMaterialButton(
                            isLoading: state is AuthLoadingState,
                            onPressed: () {
                              forgotPasswordMethod(context);
                            },
                            text: S.of(context).send,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AuthExcitedText(
                      title: S.of(context).forgot_password,
                      subtitle: S.of(context).send_password_reset),
                  Form(
                    key: _formKey,
                    child: CustomEmailField(emailController: _emailController),
                  ),
                  const MediumSpace(),
                  CustomMaterialButton(
                    isLoading: state is AuthLoadingState,
                    onPressed: () {
                      forgotPasswordMethod(context);
                    },
                    text: S.of(context).send,
                  )
                ],
              );
            }),
          );
        },
      ),
    );
  }

  void forgotPasswordMethod(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().forgotPassword(
            email: _emailController.text,
          );
    }
  }
}
