import 'package:flutter/material.dart';
import 'package:jot_do/core/constants/constant.dart';
import 'package:jot_do/core/widgets/constants_spaces_widgets.dart';
import 'package:jot_do/generated/l10n.dart';
import '../../../../../core/widgets/custom_material_button.dart';

class VerificationEmailView extends StatelessWidget {
  const VerificationEmailView({
    super.key,
    required this.email,
  });
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth >= 600) {
          return Center(
            child: SizedBox(
              width: constraints.maxWidth * 0.6,
              child: VerificationBody(email: email),
            ),
          );
        }
        return VerificationBody(email: email);
      }),
    );
  }
}

class VerificationBody extends StatelessWidget {
  const VerificationBody({
    super.key,
    required this.email,
  });

  final String email;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                        : MediaQuery.sizeOf(context).width * 0.04,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.colorScheme,
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
                            : MediaQuery.sizeOf(context).width * 0.015,
                      )),
                  TextSpan(
                    text: email,
                    style: TextStyle(
                      color: Colors.blue,
                      height: 1.7,
                      fontSize: MediaQuery.sizeOf(context).width < 600
                          ? MediaQuery.sizeOf(context).width * 0.04
                          : MediaQuery.sizeOf(context).width * 0.017,
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
    );
  }
}
