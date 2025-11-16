import 'package:flutter/material.dart';

import '../../../../core/services/app_session.dart';
import '../../../home/presentation/views/home_view.dart';
import '../../../on_boarding/presentation/views/on_boarding_view.dart';
import '../../../recovery_code/presentation/views/recovery_code_view.dart';

class SplashRepo {
  final _appSession = AppSession.instance;

  Widget checkNextScreen() {
    final continueWithout = _appSession.continueWithoutAccount;
    final loggedIn = _appSession.isLoggedIn;
    final needRecovery = _appSession.shouldShowRecoveryView;

    if (!loggedIn && !continueWithout) return const OnBoardingView();
    if (loggedIn && needRecovery) return const RecoveryCodeView();
    return const HomeView();
  }
}
