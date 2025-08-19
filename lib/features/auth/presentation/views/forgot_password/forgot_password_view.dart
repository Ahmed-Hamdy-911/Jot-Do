import 'package:flutter/material.dart';
import '../../../../../core/widgets/constants_spaces_widgets.dart';
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
      body: Padding(
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
                      const LargeSpace(),
                      Form(
                        key: _formKey,
                        child:
                            CustomEmailField(emailController: _emailController),
                      ),
                      const LargeSpace(),
                      CustomMaterialButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Handle password reset logic
                          }
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
                  title: S.of(context).reset_password,
                  subtitle: S.of(context).send_password_reset),
              const LargeSpace(),
              Form(
                key: _formKey,
                child: CustomEmailField(emailController: _emailController),
              ),
              const LargeSpace(),
              CustomMaterialButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
                },
                text: S.of(context).send,
              )
            ],
          );
        }),
      ),
    );
  }
}
