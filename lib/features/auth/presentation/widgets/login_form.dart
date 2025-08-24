import 'package:flutter/material.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/constants_spaces_widgets.dart';
import '../../../../core/widgets/custom_material_button.dart';
import '../../../../core/widgets/custom_text_form.dart';
import '../../../../generated/l10n.dart';
import 'custom_email_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomEmailField(emailController: emailController),
          const MediumSpace(),
          Text(
            S.of(context).password,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize:
                  screenWidth < 600 ? screenWidth * 0.04 : screenWidth * 0.02,
            ),
          ),
          const SmallSpace(),
          CustomTextFormField(
            hintText: S.of(context).enter_password,
            controller: passwordController,
            keyboardType: TextInputType.text,
            obscureText: false,
            suffixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.visibility_off_outlined,
                    color: Color(0xffADB5BD))),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S.of(context).error_required_field;
              }
              if (value.length < 8) {
                return S.of(context).error_short_password;
              }
              return null;
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: false,
                    checkColor: Colors.white,
                    side: const BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    onChanged: (value) {},
                  ),
                  Text(
                    S.of(context).remember_me,
                    style: TextStyle(
                      color: AppColor.colorScheme,
                      fontSize: screenWidth < 600
                          ? screenWidth * 0.035
                          : screenWidth * 0.012,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.forgotPassword,
                  );
                },
                child: Text(
                  S.of(context).forgot_password,
                  style: TextStyle(
                    color: Colors.red.shade900,
                    fontSize: screenWidth < 600
                        ? screenWidth * 0.035
                        : screenWidth * 0.012,
                  ),
                ),
              ),
            ],
          ),
          const SmallSpace(),
          CustomMaterialButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {}
            },
            text: S.of(context).login,
          ),
        ],
      ),
    );
  }
}
