import 'package:flutter/material.dart';
import 'package:jot_do/core/constants/colors/constant.dart';
import 'package:jot_do/core/routing/app_router.dart';
import 'package:jot_do/core/routing/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jot&Do',
      debugShowCheckedModeBanner: false,
      theme: AppConstant.lightTheme,
      darkTheme: AppConstant.darkTheme,
      themeMode: ThemeMode.system,
      localeResolutionCallback: AppConstant.localeResolutionCallback,
      supportedLocales: AppConstant.supportedLocales,
      localizationsDelegates: AppConstant.localizationsDelegates,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
