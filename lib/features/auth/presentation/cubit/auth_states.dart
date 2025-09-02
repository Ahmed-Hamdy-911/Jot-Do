abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class AuthLoadingState extends AuthStates {}

class AuthSuccess extends AuthStates {
  final String message;
  AuthSuccess(this.message);
}

class AuthFailure extends AuthStates {
  final String error;
  AuthFailure(this.error);
}

class AuthEmailVerificationSent extends AuthStates {
  final String message;
  AuthEmailVerificationSent(this.message);
}

class AuthEmailVerified extends AuthStates {}
