import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/cubits/settings/setting_cubit.dart';
import '../../../../core/helper/cache_helper.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/constants_spaces_widgets.dart';
import '../../../../core/widgets/custom_material_button.dart';
import '../../../../core/widgets/custom_text_form.dart';
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
    var darkMode =
        context.watch<SettingCubit>().state.themeMode == ThemeMode.dark;
    var textColor = darkMode ? AppColor.white70 : AppColor.blackColor;

    return AbsorbPointer(
      absorbing: context.watch<AuthCubit>().state is AuthLoadingState,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomEmailField(emailController: emailController),
            const MediumSpace(),
            Text(
              S.of(context).password,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w500,
                fontSize: screenWidth < 600 ? 16 : 18,
              ),
            ),
            const SmallSpace(),
            CustomTextFormField(
              hintText: S.of(context).enter_password,
              controller: passwordController,
              keyboardType: TextInputType.text,
              obscureText: !context.watch<AuthCubit>().isPasswordVisible,
              suffixIcon:
                  const TogglePasswordVisibilityIcon(isConfirmField: false),
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
                          checkColor: AppColor.whiteColor,
                          side: const BorderSide(color: AppColor.greyColor),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          onChanged: (value) {
                            cubit.toggleRememberMe(value ?? false);
                          },
                        );
                      },
                    ),
                    Text(
                      S.of(context).remember_me,
                      style: TextStyle(
                        color: AppColor.mainLightColor,
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
                      color:
                          darkMode ? AppColor.redLightColor : AppColor.redColor,
                      fontSize: screenWidth < 600 ? 15 : 17,
                    ),
                  ),
                ),
              ],
            ),
            const SmallSpace(),
            CustomMaterialButton(
              isLoading: context.watch<AuthCubit>().state is AuthLoadingState,
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
    );
  }
}
