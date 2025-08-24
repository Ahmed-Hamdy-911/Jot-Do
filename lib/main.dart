import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/constants/constant.dart';
import 'core/constants/theme/app_themes.dart';
import 'core/cubits/Settings/setting_cubit.dart';
import 'core/cubits/Settings/setting_state.dart';
import 'core/routing/app_routes.dart';
import 'core/cubits/bloc_observer.dart';
import 'core/routing/app_router.dart';
import 'core/services/local_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  await LocalStorageService.init();

  runApp(BlocProvider(
    create: (context) => SettingCubit(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Jot&Do',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: state.themeMode,
          locale: state.locale,
          localeResolutionCallback: AppConstants.localeResolutionCallback,
          supportedLocales: AppConstants.supportedLocales,
          localizationsDelegates: AppConstants.localizationsDelegates,
          initialRoute: AppRoutes.splash,
          onGenerateRoute: AppRouter.onGenerateRoute,
        );
      },
    );
  }
}
