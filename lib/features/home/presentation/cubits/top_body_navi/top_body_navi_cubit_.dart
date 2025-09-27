import 'package:bloc/bloc.dart';

class TopBodyNaviCubit extends Cubit<int> {
  TopBodyNaviCubit() : super(0);

  int currentIndex = 0;
  void changeBody(int index) {
    currentIndex = index;
    emit(index);
  }
}
