import 'package:flutter/material.dart';
import 'package:jot_do/features/splash/presentation/views/splash_view.dart';
import '../../features/auth/presentation/views/emailAndPassword/login_view.dart';
import '../../features/auth/presentation/views/emailAndPassword/register_view.dart';
import '../../features/auth/presentation/views/forgot_password/forgot_password_view.dart';
import '../../features/auth/presentation/views/verification/verification_email_view.dart';
import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case AppRoutes.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case AppRoutes.verifyEmail:
        final email = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => VerificationEmailView(email: email));
      default:
        return MaterialPageRoute(builder: (_) => const SplashView());
    }
  }
}
