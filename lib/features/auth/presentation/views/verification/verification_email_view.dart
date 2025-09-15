import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/cubits/countdown_timer/countdown_timer_cubit.dart';
import '../../../../../core/cubits/countdown_timer/countdown_timer_state.dart';
import '../../../../../core/widgets/constants_spaces_widgets.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../core/widgets/custom_material_button.dart';
import '../../cubit/auth_cubit.dart';
import '../../cubit/auth_states.dart';

class VerificationEmailView extends StatelessWidget {
  const VerificationEmailView({
    super.key,
    required this.email,
  });
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
        ),
      ),
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

class VerificationBody extends StatefulWidget {
  const VerificationBody({
    super.key,
    required this.email,
  });

  final String email;

  @override
  State<VerificationBody> createState() => _VerificationBodyState();
}

class _VerificationBodyState extends State<VerificationBody> {
  @override
  void initState() {
    context.read<CountdownTimerCubit>().startTimer(fromSeconds: 120);
    super.initState();
  }

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
                    color: AppColor.colorScheme,
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
                    text: widget.email,
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
                onPressed: () async {
                  await context.read<AuthCubit>().checkEmailVerification();
                },
                isLoading:
                    context.watch<AuthCubit>().state is AuthVerificationLoading,
                text: S.of(context).continue_text,
              ),
              const MediumSpace(),
              BlocBuilder<CountdownTimerCubit, CountdownTimerState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      state.isCompleted
                          ? TextButton(
                              onPressed: () async {
                                await context
                                    .read<AuthCubit>()
                                    .resendVerificationEmail();
                                context
                                    .read<CountdownTimerCubit>()
                                    .startTimer(fromSeconds: 120);
                              },
                              child: Text(
                                S.of(context).resend_code,
                                style: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  height: 0.7,
                                  fontSize: 16,
                                  color: AppColor.colorScheme,
                                ),
                              ),
                            )
                          : RichText(
                              text: TextSpan(
                              text: S.of(context).resend_code,
                              style: const TextStyle(
                                height: 0.7,
                                fontSize: 16,
                                color: AppColor.colorScheme,
                              ),
                              children: [
                                TextSpan(
                                  text: state.secondLeft.toString(),
                                  style: const TextStyle(
                                    height: 0.7,
                                    fontSize: 16,
                                    color: AppColor.colorScheme,
                                  ),
                                ),
                              ],
                            )),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
