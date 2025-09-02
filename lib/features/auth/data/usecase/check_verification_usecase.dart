import '../domain/auth_repository.dart';

class CheckVerificationUseCase {
  final AuthRepository _authRepository;

  CheckVerificationUseCase(this._authRepository);

  Future<bool> call() async {
    return await _authRepository.isEmailVerified();
  }
}
