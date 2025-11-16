import '../../../../core/services/app_session.dart';

class CacheAuthRepo {
  static final appSession = AppSession.instance;
  static void continueWithoutAccount() {
    appSession.setContinueWithoutAccount(true);
  }

  static void reLogin() {
    appSession.setContinueWithoutAccount(false);
  }
}
