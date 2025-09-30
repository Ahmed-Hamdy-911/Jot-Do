import 'package:flutter_bloc/flutter_bloc.dart';

import 'selection_state.dart';

class SelectionCubit<T> extends Cubit<SelectionState<T>> {
  SelectionCubit() : super(SelectionState<T>());

  void setAllItems(List<T> items) {
    emit(state.copyWith(allItems: List.from(items)));
  }

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
      emit(SelectionState<T>(allItems: state.allItems));
    } else {
      emit(state.copyWith(
        isSelectionMode: true,
        selectedItems: updated,
      ));
    }
  }

  void selectAll() {
    emit(state.copyWith(
      isSelectionMode: true,
      selectedItems: List.from(state.allItems),
    ));
  }

  void clearSelection() {
    emit(SelectionState<T>(allItems: state.allItems));
  }
}
