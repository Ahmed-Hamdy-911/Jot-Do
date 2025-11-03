// import 'package:bloc/bloc.dart';

// import '../../services/encryption_services.dart';
// import 'encryption_state.dart';

// class EncryptionCubit extends Cubit<EncryptionState> {
//   EncryptionCubit(
//     this.encryptService,
//   ) : super(EncryptionInitial());
//   final EncryptionService encryptService;
//   void encrypt({required String plainText}) {
//     emit(EncryptionLoading());
//     try {
//       emit(EncryptionInProgress());
//       final encryptedText = encryptService.encryptText(plainText);
//       // emit(EncryptionSuccess(encryptedText));
//     } on Exception catch (e) {
//       emit(EncryptionFailure(e.toString()));
//     }
//   }

//   Future<void> decrypt(
//       {required String encryptedText, required String ivText}) async {
//     emit(EncryptionLoading());
//     try {
//       emit(DecryptionInProgress());
//       final decryptedText =
//           await encryptService.decryptText(encryptedText, ivText, '');
//       emit(DecryptionSuccess(decryptedText));
//     } on Exception catch (e) {
//       emit(DecryptionFailure(e.toString()));
//     }
//   }
// }
