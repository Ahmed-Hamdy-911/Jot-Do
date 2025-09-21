import 'package:flutter_bloc/flutter_bloc.dart';

import 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit()
      : super(const FilterState(
          selectedIndex: 0,
        ));

  int currentIndex = 0;

  void switchSelection(int index) {
    currentIndex = index;
    emit(FilterState(selectedIndex: index));
  }

  void resetSelection() {
    emit(const FilterState(selectedIndex: 0));
  }

  @override
  Future<void> close() {
    resetSelection();
    return super.close();
  }
}
