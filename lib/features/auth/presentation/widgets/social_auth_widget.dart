import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import '../../../../core/widgets/constants_spaces_widgets.dart';
import '../../../../generated/l10n.dart';

class SocialAuthWidget extends StatelessWidget {
  const SocialAuthWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width < 600
                ? MediaQuery.sizeOf(context).width * 0.7
                : MediaQuery.sizeOf(context).width * 0.5,
            height: 50,
            child: SignInButton(
              Buttons.GoogleDark,
              text: S.of(context).google,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              onPressed: () {},
            ),
          ),
          const SmallSpace(),
          Container(
            width: MediaQuery.sizeOf(context).width < 600
                ? MediaQuery.sizeOf(context).width * 0.7
                : MediaQuery.sizeOf(context).width * 0.5,
            height: 50,
            child: SignInButton(
              Buttons.Apple,
              text: S.of(context).apple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
