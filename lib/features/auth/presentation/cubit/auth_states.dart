abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class AuthLoadingState extends AuthStates {}

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

class AuthEmailVerified extends AuthStates {}
