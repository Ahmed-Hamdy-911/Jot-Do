import '../domain/auth_repository.dart';

class RegisterUserUseCase {
  final AuthRepository _authRepository;

  RegisterUserUseCase(this._authRepository);

  Future<void> call({required String email, required String password}) async {
    await _authRepository.register(email: email, password: password);
    await _authRepository.sendEmailVerification();
  }
}
