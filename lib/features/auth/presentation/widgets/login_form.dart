import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/colors/smart_app_color.dart';
import '../../../../core/helper/cache_helper.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/buttons/custom_material_button.dart';
import '../../../../core/widgets/components/components.dart';
import '../../../../core/widgets/custom_fields/custom_text_form.dart';
import '../../../../generated/l10n.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_states.dart';
import 'custom_email_field.dart';
import 'toggle_password_visibility_icon.dart';

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
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  Future<void> _loadSavedCredentials() async {
    final cubit = context.read<AuthCubit>();
    final savedEmail = CacheHelper.getData(key: 'userEmail');
    final savedPassword = CacheHelper.getData(key: 'userPassword');
    final savedRemember = CacheHelper.getData(key: 'rememberMe') ?? false;

    if (savedEmail != null) emailController.text = savedEmail;
    if (savedPassword != null) passwordController.text = savedPassword;

    cubit.rememberMe = savedRemember;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    final colors = SmartAppColor(context);
    return AbsorbPointer(
      absorbing: context.watch<AuthCubit>().state is AuthLoadingState,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: SmartAppColor(context).border),
          borderRadius: BorderRadius.circular(AppConstants.kRadius),
        ),
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomEmailField(emailController: emailController),
              AppComponents.mediumVerticalSpace(),
              Text(
                S.of(context).password,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w500,
                  fontSize: screenWidth < 600 ? 16 : 18,
                ),
              ),
              AppComponents.smallVerticalSpace(),
              CustomTextFormField(
                hintText: S.of(context).enter_password,
                controller: passwordController,
                keyboardType: TextInputType.text,
                obscureText: !context.watch<AuthCubit>().isPasswordVisible,
                suffixIcon:
                    const TogglePasswordVisibilityIcon(isConfirmField: false),
                filled: true,
                fillColor: colors.fillColor,
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
                      BlocBuilder<AuthCubit, AuthStates>(
                        builder: (context, state) {
                          final cubit = context.read<AuthCubit>();
                          return Checkbox(
                            value: cubit.rememberMe,
                            checkColor: colors.primary,
                            side: BorderSide(color: colors.black),
                            activeColor: colors.backgroundMuted,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  AppConstants.kCheckBoxRadius),
                            ),
                            onChanged: (value) {
                              cubit.toggleRememberMe(value!);
                            },
                          );
                        },
                      ),
                      Text(
                        S.of(context).remember_me,
                        style: TextStyle(
                          color: colors.primary,
                          fontSize: screenWidth < 600 ? 15 : 17,
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
                        color: colors.red,
                        fontSize: screenWidth < 600 ? 15 : 17,
                      ),
                    ),
                  ),
                ],
              ),
              AppComponents.smallVerticalSpace(),
              CustomMaterialButton(
                color: colors.reverseBackgroundColor,
                textColor: colors.textInverse,
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    final cubit = context.read<AuthCubit>();
                    cubit.login(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                  }
                },
                text: S.of(context).login,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
