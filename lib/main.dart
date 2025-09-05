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
import 'package:firebase_core/firebase_core.dart';
import 'features/auth/data/repository/auth_repo_impl.dart';
import 'features/auth/data/usecase/check_auth_usecase.dart';
import 'features/auth/data/usecase/check_verification_usecase.dart';
import 'features/auth/data/usecase/forgot_password_usecase.dart';
import 'features/auth/data/usecase/login_user_usecase.dart';
import 'features/auth/data/usecase/register_user_usecase.dart';
import 'features/auth/data/usecase/social_user_usecase.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  assert(() {
    Bloc.observer = MyBlocObserver();
    return true;
  }());
  await LocalStorageService.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final authRepoImpl = AuthRepoImpl();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => SettingCubit(),
      ),
      BlocProvider(
        create: (context) => AuthCubit(
          RegisterUserUseCase(authRepoImpl),
          LoginUserUseCase(authRepoImpl),
          CheckVerificationUseCase(authRepoImpl),
          CheckAuthUseCase(authRepoImpl),
          ForgotPasswordUseCase(authRepoImpl),
          SocialUserUseCase(authRepoImpl),
        ),
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
