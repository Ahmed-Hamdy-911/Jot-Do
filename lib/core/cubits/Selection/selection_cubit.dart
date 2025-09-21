import 'package:flutter_bloc/flutter_bloc.dart';

import 'selection_state.dart';

class SelectionCubit<T> extends Cubit<SelectionState<T>> {
  SelectionCubit() : super(SelectionState<T>());

  void enterSelectionMode(T item) {
    emit(state.copyWith(
      isSelectionMode: true,
      selectedItems: [item],
    ));
  }

  void toggleSelection(T item) {
    final updated = List<T>.from(state.selectedItems);
    if (updated.contains(item)) {
      updated.remove(item);
    } else {
      updated.add(item);
    }
    if (updated.isEmpty) {
      emit(SelectionState<T>());
    } else {
      emit(state.copyWith(
        isSelectionMode: true,
        selectedItems: updated,
      ));
    }
  }

  void clearSelection() {
    emit(SelectionState<T>());
  }
}
