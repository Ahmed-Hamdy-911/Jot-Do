import 'package:flutter/material.dart';
import 'package:jot_do/features/splash/presentation/views/splash_view.dart';
import '../../features/auth/presentation/views/login_view.dart';
import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      default:
        return MaterialPageRoute(builder: (_) => const SplashView());
    }
  }
}
