import 'package:flutter/material.dart';
import 'package:jot_do/generated/l10n.dart';
import '../../../../../core/widgets/custom_material_button.dart';
import '../../widgets/custom_password_and_confirm_password.dart';

class ResetPasswordView extends StatelessWidget {
  ResetPasswordView({super.key});
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // leading: const CustomBackIcon(),
          ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Text(
              'New Password',
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: const Text(
                textAlign: TextAlign.center,
                "Your new password must be different from your old password.",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Form(
              key: _formKey,
              child: CustomPasswordAndConfirmPasswordWidget(
                passwordController: _passwordController,
                confirmPasswordController: _confirmPasswordController,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            CustomMaterialButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {}
              },
              text: S.of(context).reset_password,
            )
          ],
        ),
      ),
    );
  }
}
