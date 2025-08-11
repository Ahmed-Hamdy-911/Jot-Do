import 'package:flutter/material.dart';
import 'package:jot_do/generated/l10n.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/constants_spaces_widgets.dart';
import '../../../../core/widgets/custom_text_and_text_button.dart';
import 'social_auth_widget.dart';

class LoginExtrasWidget extends StatelessWidget {
  const LoginExtrasWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        const CustomOrWithWidget(),
        const SmallSpace(),
        const SocialAuthWidget(),
        const MediumSpace(),
        CustomTextAndTextButton(
            textTitle: S.of(context).dont_have_account,
            textButtonTitle: S.of(context).register,
            fontSize:
                screenWidth < 600 ? screenWidth * 0.035 : screenWidth * 0.015,
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.register);
            }),
      ],
    );
  }
}

class CustomOrWithWidget extends StatelessWidget {
  const CustomOrWithWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.grey.shade300,
            endIndent: 20,
            indent: 10,
          ),
        ),
        Text(
          S.of(context).or_continue_with,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade600,
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey.shade300,
            indent: 20,
            endIndent: 10,
          ),
        ),
      ],
    );
  }
}
