import 'package:flutter/material.dart';
import 'package:jot_do/features/splash/views/splash_view.dart';

import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashView());
      default:
        return MaterialPageRoute(builder: (_) => const SplashView());
    }
  }
}
