import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import '../../../../core/constants/constant.dart';
import '../../../../core/widgets/constants_spaces_widgets.dart';
import '../../../../generated/l10n.dart';

class SocialAuthWidget extends StatelessWidget {
  const SocialAuthWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;

    return Center(
      child: Column(
        children: [
          Container(
            width: screenWidth < 600 ? screenWidth : screenWidth * 0.5,
            height: 55,
            child: SignInButton(
              Buttons.GoogleDark,
              width: screenWidth < 600 ? screenWidth * 0.55 : screenWidth * 0.5,
              text: S.of(context).google,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.kRadius),
              ),
              onPressed: () {},
            ),
          ),
          const SmallSpace(),
          Container(
            width: screenWidth < 600 ? screenWidth : screenWidth * 0.5,
            height: 55,
            child: SignInButton(
              Buttons.Apple,
              text: S.of(context).apple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.kRadius),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
