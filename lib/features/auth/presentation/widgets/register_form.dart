import 'package:flutter/material.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_states.dart';
import 'auth_exited_text.dart';
import '../../../../generated/l10n.dart';
import '../../../../../core/widgets/constants_spaces_widgets.dart';
import '../../../../../core/widgets/custom_material_button.dart';
import '../../../../../core/widgets/custom_text_and_text_button.dart';
import '../../../../../core/widgets/custom_text_form.dart';
import 'custom_email_field.dart';
import 'custom_password_and_confirm_password.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    super.key,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    return AbsorbPointer(
      absorbing: context.watch<AuthCubit>().state is AuthLoadingState,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AuthExcitedText(
                title: S.of(context).create_account,
                subtitle: S.of(context).register_excited_text),
            const MediumSpace(),
            Text(
              S.of(context).name,
              style: TextStyle(
                fontSize:
                    screenWidth < 600 ? screenWidth * 0.04 : screenWidth * 0.02,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SmallSpace(),
            CustomTextFormField(
              hintText: S.of(context).enter_name,
              controller: _nameController,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return S.of(context).error_required_field;
                } else if (value.length < 3) {
                  return S.of(context).error_short_name;
                } else if (value.startsWith(RegExp(r'^[0-9]'))) {
                  return S.of(context).error_name_starts_with_number;
                } else if (value.contains(RegExp(r'^.*[@/$!%*?&]'))) {
                  return S.of(context).error_name_contains_special_characters;
                }
                return null;
              },
            ),
            const MediumSpace(),
            CustomEmailField(emailController: _emailController),
            const MediumSpace(),
            CustomPasswordAndConfirmPasswordWidget(
                passwordController: _passwordController,
                confirmPasswordController: _confirmPasswordController),
            const MediumSpace(),
            CustomMaterialButton(
              isLoading: context.watch<AuthCubit>().state is AuthLoadingState,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  context.read<AuthCubit>().register(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                }
              },
              text: S.of(context).register,
            ),
            const SmallSpace(),
            CustomTextAndTextButton(
              textTitle: S.of(context).already_have_account,
              textButtonTitle: S.of(context).login,
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
