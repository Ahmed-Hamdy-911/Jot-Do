import 'package:flutter/material.dart';

import '../../../../core/constants/colors/smart_app_color.dart';
import '../../../../core/widgets/custom/custom_blur_widget.dart';
import '../../../../generated/l10n.dart';
import 'widgets/recovery_code_body.dart';

class RecoveryCodeView extends StatelessWidget {
  const RecoveryCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const RecoveryCode();
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
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
