import 'package:flutter/material.dart';
import 'package:jot_do/core/constants/constant.dart';
import 'package:jot_do/core/widgets/constants_spaces_widgets.dart';
import 'package:jot_do/generated/l10n.dart';
import '../../../../../core/widgets/custom_material_button.dart';

class VerificationEmailView extends StatefulWidget {
  const VerificationEmailView({
    super.key,
    required this.email,
  });
  final String email;

  @override
  State<VerificationEmailView> createState() => _VerificationEmailViewState();
}

class _VerificationEmailViewState extends State<VerificationEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

          // leading: const CustomBackIcon(),
          ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Lottie.asset('assets/animation/Animation - 1718041914581.json'),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    S.of(context).verify_email_title,
                    style: TextStyle(
                      fontSize: MediaQuery.sizeOf(context).width < 600
                          ? MediaQuery.sizeOf(context).width * 0.065
                          : MediaQuery.sizeOf(context).width * 0.06,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SmallSpace(),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                        text: S.of(context).verify_email_message,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: MediaQuery.sizeOf(context).width < 600
                              ? MediaQuery.sizeOf(context).width * 0.035
                              : MediaQuery.sizeOf(context).width * 0.07,
                        )),
                    TextSpan(
                      text: widget.email,
                      style: TextStyle(
                        color: Colors.blue,
                        height: 1.7,
                        fontSize: MediaQuery.sizeOf(context).width < 600
                            ? MediaQuery.sizeOf(context).width * 0.04
                            : MediaQuery.sizeOf(context).width * 0.05,
                      ),
                    ),
                  ]),
                ),
                const MediumSpace(),
                CustomMaterialButton(
                  onPressed: () {},
                  text: S.of(context).continue_text,
                ),
                const MediumSpace(),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        S.of(context).resend_code,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          height: 0.7,
                          fontSize: 16,
                          color: AppConstants.colorScheme,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
