import 'package:bloc/bloc.dart';

class BottomNaviCubit extends Cubit<int> {
  BottomNaviCubit() : super(0);

  int currentIndex = 0;
  void changeBottomPage(int index) {
    currentIndex = index;
    emit(index);
  }
}
