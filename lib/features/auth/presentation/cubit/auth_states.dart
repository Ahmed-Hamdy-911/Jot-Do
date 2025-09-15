abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class AuthTogglePasswordVisibility extends AuthStates {}

class AuthToggleConfirmPasswordVisibility extends AuthStates {}

class AuthRememberMeChanged extends AuthStates {
  final bool rememberMe;
  AuthRememberMeChanged(this.rememberMe);
}

class AuthLoadingState extends AuthStates {}

class AuthVerificationLoading extends AuthStates {}

class AuthSuccess extends AuthStates {}

class AuthFailure extends AuthStates {
  final String error;
  AuthFailure(this.error);
}

class LoginWithAlreadyUsedEmail extends AuthStates {
  final String? message;
  LoginWithAlreadyUsedEmail(this.message);
}

class AuthEmailVerificationSent extends AuthStates {
  final String? message;
  AuthEmailVerificationSent(this.message);
}

class AuthEmailVerificationNeeded extends AuthStates {
  final String? message;
  AuthEmailVerificationNeeded(this.message);
}

class GoVerificationState extends AuthStates {
  final String email;
  final String? message;
  GoVerificationState({required this.email, this.message});
}

class AuthEmailVerified extends AuthStates {}

class AuthLoggedOut extends AuthStates {}

class AuthLoadingGoogleSignIn extends AuthStates {}

class AuthGoogleSignInSuccess extends AuthStates {}

class AuthGoogleSignInFailure extends AuthStates {
  final String error;
  AuthGoogleSignInFailure(this.error);
}

class AuthGoogleSignInCanceled extends AuthStates {}

class AuthPasswordResetEmailSent extends AuthStates {
  final String? message;
  AuthPasswordResetEmailSent(this.message);
}
