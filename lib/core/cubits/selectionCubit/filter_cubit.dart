import 'package:bloc/bloc.dart';
import 'package:jot_do/core/cubits/selectionCubit/filter_state.dart';

class SelectionCubit extends Cubit<SelectionState> {
  SelectionCubit() : super(SelectionState(selectedIndex: 0));

  void switchSelection(int index) {
    emit(SelectionState(selectedIndex: index));
  }
}
