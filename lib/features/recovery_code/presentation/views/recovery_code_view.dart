import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/colors/smart_app_color.dart';
import '../../../../core/models/message_type.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/services/app_session.dart';
import '../../../../core/widgets/buttons/custom_material_button.dart';
import '../../../../core/widgets/components/components.dart';
import '../../../../core/widgets/components/custom_snackbar.dart';
import '../../../../core/widgets/custom/custom_blur_widget.dart';
import '../../../../generated/l10n.dart';
import '../cubits/recovery_code/recovery_code_cubit.dart';
import '../cubits/recovery_code/recovery_code_state.dart';
import 'enter_code_view.dart';
import 'widgets/recovery_code_body.dart';

class RecoveryCodeView extends StatelessWidget {
  const RecoveryCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecoveryCodeCubit()..performStartupFlow(),
      child: const RecoveryCodeBuilder(),
    );
  }
}

class RecoveryCodeBuilder extends StatelessWidget {
  const RecoveryCodeBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecoveryCodeCubit, RecoveryCodeState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        final appSession = AppSession.instance;
        final isNoUser = appSession.continueWithoutAccount;
        if (isNoUser) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.home,
            (route) => false,
          );
        } else if (state is RecoveryEntrySkipped ||
            state is RecoveryCodeSkipped) {
          Navigator.pushNamed(context, AppRoutes.home);
        } else if (state is RecoveryCodeSaved ||
            state is CheckingRecoveryCodeSuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.home, (route) => false);
        } else if (state is CheckingRecoveryCodeError) {
          CustomSnackBar.showSnackBar(
            state.error,
            context,
            MessageType.error,
          );
        }
      },
      builder: (context, state) {
        if (state is RecoveryCodeCreated || state is NeedToSaveRecoveryCode) {
          return const RecoveryCode();
        } else if (state is NeedToEnterRecoveryCode) {
          return const EnterCodeView();
        } else if (state is CheckingRecoveryCodeError) {
          return const InvalidRecoveryCodeWidget();
        }
        return const CustomRecoveryLoading();
      },
    );
  }
}

class InvalidRecoveryCodeWidget extends StatelessWidget {
  const InvalidRecoveryCodeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: SmartAppColor(context).red),
            color: SmartAppColor(context).backgroundScreen,
            borderRadius: BorderRadius.circular(AppConstants.kRadius),
          ),
          padding: const EdgeInsets.all(8.0),
          child: CustomMaterialButton(
            onPressed: () {
              context.read<RecoveryCodeCubit>().performStartupFlow();
            },
            color: SmartAppColor(context).backgroundMuted,
            widget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).invalidRecoveryCode,
                  style:
                      AppConstants.bodyMediumStyle(SmartAppColor(context).red),
                ),
                AppComponents.largeHorizontalSpace(),
                TextButton.icon(
                  onPressed: () =>
                      context.read<RecoveryCodeCubit>().performStartupFlow(),
                  label: Text(
                    S.of(context).retry,
                    style: AppConstants.bodyMediumStyle(
                        SmartAppColor(context).red),
                  ),
                  icon: Icon(
                    Icons.refresh,
                    color: SmartAppColor(context).red,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RecoveryCode extends StatelessWidget {
  const RecoveryCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomBlurWidget(
            child: AppBar(
              backgroundColor: colors.backgroundScreen.withValues(alpha: 0.2),
              title: Text(
                S.of(context).recovery_code_title,
              ),
            ),
          ),
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth >= 600) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: const RecoveryCodeBody(),
              ),
            );
          } else {
            return const RecoveryCodeBody();
          }
        }));
  }
}

class CustomRecoveryLoading extends StatelessWidget {
  const CustomRecoveryLoading({super.key});

  @override
  Widget build(BuildContext context) {
    var colors = SmartAppColor(context);
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: colors.border),
            color: SmartAppColor(context).backgroundScreen,
            borderRadius: BorderRadius.circular(AppConstants.kRadius),
            boxShadow: [
              BoxShadow(
                color: colors.grey,
                blurRadius: 10,
              ),
            ],
          ),
          child: Row(
            children: [
              AppComponents.customCircleLoading(context),
              AppComponents.largeHorizontalSpace(),
              Expanded(
                child: Text(
                  S.of(context).app_performing_some_operations,
                  style: AppConstants.bodyMediumStyle(colors.textPrimary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
