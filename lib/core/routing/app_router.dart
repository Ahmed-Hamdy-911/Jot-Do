import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import '../../features/auth/presentation/views/profile/profile_view.dart';
import '../../features/backups/presentation/view/backup_and_restore_view.dart';
import '../../features/note/data/models/note_model.dart';
import '../../features/note/presentation/view/add_note/add_note_view.dart';
import '../../features/note/presentation/view/update_note/update_note_view.dart';
// import '../../features/recovery_code/presentation/view/recovery_code_view.dart';
import '../../features/recovery_code/presentation/views/recovery_code_view.dart';
import '../../features/task/presentation/view/add_task_view.dart';
import '../../features/settings/presentation/views/settings_view.dart';
import '../../features/splash/presentation/views/splash_view.dart';
import '../../features/auth/presentation/views/emailAndPassword/login_view.dart';
import '../../features/auth/presentation/views/emailAndPassword/register_view.dart';
import '../../features/auth/presentation/views/forgot_password/forgot_password_view.dart';
import '../../features/auth/presentation/views/verification/verification_email_view.dart';
import '../../features/home/presentation/views/home_view.dart';
import '../../features/on_boarding/presentation/views/on_boarding_view.dart';
import '../cubits/countdown_timer/countdown_timer_cubit.dart';
import '../services/countdown_timer_service.dart';
import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return PageTransition(
          type: PageTransitionType.fade,
          child: const SplashView(),
          settings: settings,
        );
      case AppRoutes.onBoarding:
        return PageTransition(
          type: PageTransitionType.fade,
          child: const OnBoardingView(),
          settings: settings,
        );
      case AppRoutes.login:
        return PageTransition(
          type: PageTransitionType.fade,
          child: const LoginView(),
          settings: settings,
        );
      case AppRoutes.register:
        return PageTransition(
          type: PageTransitionType.fade,
          child: const RegisterView(),
          settings: settings,
        );
      case AppRoutes.forgotPassword:
        return PageTransition(
          type: PageTransitionType.fade,
          child: const ForgotPasswordView(),
          settings: settings,
        );
      case AppRoutes.verifyEmail:
        final email = settings.arguments as String;
        return PageTransition(
          type: PageTransitionType.fade,
          child: BlocProvider(
            create: (_) => CountdownTimerCubit(CountdownTimerService()),
            child: VerificationEmailView(email: email),
          ),
          settings: settings,
        );
      case AppRoutes.profile:
        return PageTransition(
          type: PageTransitionType.fade,
          child: const ProfileView(),
          settings: settings,
        );
      case AppRoutes.recoveryCode:
        return PageTransition(
          type: PageTransitionType.fade,
          child: const RecoveryCodeView(),
          settings: settings,
        );
      case AppRoutes.home:
        return PageTransition(
          type: PageTransitionType.fade,
          child: const HomeView(),
          settings: settings,
        );
      case AppRoutes.settings:
        return PageTransition(
          type: PageTransitionType.fade,
          child: const SettingsView(),
          settings: settings,
        );
      case AppRoutes.addNote:
        return PageTransition(
          type: PageTransitionType.fade,
          child: const AddNoteView(),
          settings: settings,
        );
      case AppRoutes.updateNote:
        final note = settings.arguments as NoteModel;
        return PageTransition(
          type: PageTransitionType.fade,
          child: UpdateNoteView(noteModel: note),
          settings: settings,
        );
      case AppRoutes.addTask:
        return PageTransition(
          type: PageTransitionType.fade,
          child: const AddTaskView(),
          settings: settings,
        );
      case AppRoutes.backupAndRestore:
        return PageTransition(
          type: PageTransitionType.fade,
          child: const BackupAndRestoreView(),
          settings: settings,
        );
      default:
        return PageTransition(
          type: PageTransitionType.fade,
          child: const SplashView(),
          settings: settings,
        );
    }
  }
}
