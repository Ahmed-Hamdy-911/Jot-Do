import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/constants/constant.dart';
import 'core/routing/app_routes.dart';
import 'core/blocObserver/bloc_observer.dart';
import 'core/routing/app_router.dart';
import 'core/services/local_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  await LocalStorageService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jot&Do',
      debugShowCheckedModeBanner: false,
      theme: AppConstants.lightTheme,
      darkTheme: AppConstants.darkTheme,
      themeMode: ThemeMode.light,
      localeResolutionCallback: AppConstants.localeResolutionCallback,
      supportedLocales: AppConstants.supportedLocales,
      localizationsDelegates: AppConstants.localizationsDelegates,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
