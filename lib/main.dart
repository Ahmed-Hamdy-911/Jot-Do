import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/constants/app_constants.dart';
import 'core/constants/app_themes.dart';
import 'core/cubits/backup/backup_cubit.dart';
import 'core/cubits/connectivity/connection_cubit.dart';
import 'features/settings/presentation/cubits/setting_cubit.dart';
import 'features/settings/presentation/cubits/setting_state.dart';
import 'core/routing/app_routes.dart';
import 'core/cubits/bloc_observer.dart';
import 'core/routing/app_router.dart';

import 'core/services/local_storage_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/auth/data/repository/auth_repo_impl.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  assert(() {
    Bloc.observer = MyBlocObserver();
    return true;
  }());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await LocalStorageService.init();
  // log('[Init] shouldShowRecoveryView=${AppSession.instance.shouldShowRecoveryView}');
  // log('[Init] isLoggedIn=${AppSession.instance.isLoggedIn}');
  // log('[Test] ${await AppSession.instance.pendingRecoveryCode}');
  // log('[Init] isSameUser=${AppSession.instance.isSameUser}');
  // final keyManager = KeyManager();
  // await keyManager.performStartupChecks();
  // log('[Init] performStartupChecks=${await keyManager.performStartupChecks()}');
  // final appSession = AppSession.instance;
  // log("[Init] shouldShowRecoveryViewFromAppSession=${appSession.shouldShowRecoveryView}");
  // AppSession.instance.clearAll();
  // await KeyManager().performStartupChecks();
  // KeyManager().clearAllKeysAndMetadata();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => SettingCubit(),
      ),
      BlocProvider(
        create: (context) => AuthCubit(
          AuthRepoImpl(),
        ),
      ),
      BlocProvider(
        create: (context) => ConnectionCubit(),
      ),
      BlocProvider(
        create: (context) => BackupCubit(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) {
        return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return MaterialApp(
                title: 'Jot&Do',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.getLightTheme(context),
                darkTheme: AppTheme.getDarkTheme(context),
                themeMode: state.themeMode,
                locale: state.locale,
                localeResolutionCallback: AppConstants.localeResolutionCallback,
                supportedLocales: AppConstants.supportedLocales,
                localizationsDelegates: AppConstants.localizationsDelegates,
                initialRoute: AppRoutes.splash,
                onGenerateRoute: AppRouter.onGenerateRoute,
              );
            });
      },
    );
  }
}
