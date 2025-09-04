import '../domain/auth_repository.dart';

class ForgotPasswordUseCase {
  final AuthRepository authRepository;

  ForgotPasswordUseCase(this.authRepository);

  Future<void> call({required String email}) async {
    await authRepository.sendPasswordResetEmail(email: email);
  }
}
