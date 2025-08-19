import 'package:bloc/bloc.dart';
import 'selection_state.dart';

class SelectionCubit extends Cubit<SelectionState> {
  SelectionCubit()
      : super(const SelectionState(
          selectedIndex: 0,
        ));
  int currentIndex = 0;
  void switchSelection(int index) {
    currentIndex = index;
    emit(SelectionState(selectedIndex: index));
  }

  void resetSelection() {
    emit(const SelectionState(selectedIndex: 0));
  }

  @override
  Future<void> close() {
    resetSelection();
    return super.close();
  }
}
