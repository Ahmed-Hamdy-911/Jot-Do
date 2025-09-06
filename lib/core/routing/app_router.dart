import 'package:flutter/material.dart';
import '../../features/auth/presentation/views/account/profile_view.dart';
import '../../features/home/data/models/note_model.dart';
import '../../features/home/presentation/views/note/add_note/add_note_view.dart';
import '../../features/home/presentation/views/note/note_details_view.dart';
import '../../features/home/presentation/views/note/update_note/update_note_view.dart';
import '../../features/home/presentation/views/task/add_task_view.dart';
import '../../features/splash/presentation/views/splash_view.dart';
import '../../features/auth/presentation/views/emailAndPassword/login_view.dart';
import '../../features/auth/presentation/views/emailAndPassword/register_view.dart';
import '../../features/auth/presentation/views/forgot_password/forgot_password_view.dart';
import '../../features/auth/presentation/views/verification/verification_email_view.dart';
import '../../features/home/presentation/views/home_view.dart';
import '../../features/on_boarding/presentation/views/on_boarding_view.dart';
import 'app_routes.dart';
import 'package:page_transition/page_transition.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashView());
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
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case AppRoutes.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case AppRoutes.verifyEmail:
        final email = settings.arguments as String;
        return PageTransition(
          type: PageTransitionType.fade,
          child: VerificationEmailView(email: email),
          settings: settings,
        );
      case AppRoutes.profile:
        return PageTransition(
          type: PageTransitionType.fade,
          child: const ProfileView(),
          settings: settings,
        );
      case AppRoutes.home:
        return PageTransition(
          type: PageTransitionType.fade,
          child: const HomeView(),
          settings: settings,
        );
      case AppRoutes.addNote:
        return MaterialPageRoute(builder: (_) => const AddNoteView());
      case AppRoutes.noteDetails:
        final note = settings.arguments as NoteModel;
        return MaterialPageRoute(
          builder: (_) => NoteDetailsView(noteModel: note),
        );
      case AppRoutes.updateNote:
        final note = settings.arguments as NoteModel;
        return MaterialPageRoute(
          builder: (_) => UpdateNoteView(noteModel: note),
        );
      case AppRoutes.addTask:
        return MaterialPageRoute(builder: (_) => const AddTaskView());
      default:
        return MaterialPageRoute(builder: (_) => const SplashView());
    }
  }
}
