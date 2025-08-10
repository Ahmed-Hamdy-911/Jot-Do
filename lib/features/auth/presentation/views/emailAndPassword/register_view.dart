import 'package:flutter/material.dart';
import 'package:jot_do/generated/l10n.dart';
import '../../../../../core/routing/app_routes.dart';
import '../../../../../core/widgets/constants_spaces_widgets.dart';
import '../../../../../core/widgets/custom_material_button.dart';
import '../../widgets/custom_email_field.dart';
import '../../widgets/custom_password_and_confirm_password.dart';
import '../../../../../core/widgets/custom_text_and_text_button.dart';
import '../../../../../core/widgets/custom_text_form.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                      child: Column(
                    children: [
                      Text(
                        S.of(context).create_account,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          height: 1.7,
                          fontSize: MediaQuery.sizeOf(context).width < 600
                              ? MediaQuery.sizeOf(context).width * 0.07
                              : MediaQuery.sizeOf(context).width * 0.05,
                        ),
                      ),
                      Text(
                        S.of(context).register_excited_text,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                          fontSize: MediaQuery.sizeOf(context).width < 600
                              ? MediaQuery.sizeOf(context).width * 0.04
                              : MediaQuery.sizeOf(context).width * 0.08,
                        ),
                      ),
                    ],
                  )),
                  const MediumSpace(),
                  Text(
                    S.of(context).name,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: MediaQuery.sizeOf(context).width < 600
                          ? MediaQuery.sizeOf(context).width * 0.04
                          : MediaQuery.sizeOf(context).width * 0.08,
                      // textColor: AppColor.kMainColor,
                    ),
                  ),
                  SmallSpace(),
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
                        return S
                            .of(context)
                            .error_name_contains_special_characters;
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
                  const LargeSpace(),
                  CustomMaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.verifyEmail,
                          arguments: "test@gmail.com");
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
          ),
        ),
      ),
    );
  }
}
