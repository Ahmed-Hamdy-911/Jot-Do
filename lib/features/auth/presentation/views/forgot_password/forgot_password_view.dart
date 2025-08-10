import 'package:flutter/material.dart';
import 'package:jot_do/core/widgets/constants_spaces_widgets.dart';
import 'package:jot_do/generated/l10n.dart';
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
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    S.of(context).reset_password,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.sizeOf(context).width < 600
                          ? MediaQuery.sizeOf(context).width * 0.06
                          : MediaQuery.sizeOf(context).width * 0.05,
                      color: Colors.black,
                    ),
                  ),
                  const SmallSpace(),
                  Text(
                    S.of(context).send_password_reset,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
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
        ),
      ),
    );
  }
}
