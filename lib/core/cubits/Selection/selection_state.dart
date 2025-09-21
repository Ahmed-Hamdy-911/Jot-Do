class SelectionState<T> {
  final bool isSelectionMode;
  final List<T> selectedItems;

  SelectionState({
    this.isSelectionMode = false,
    this.selectedItems = const [],
  });

  SelectionState<T> copyWith({
    bool? isSelectionMode,
    List<T>? selectedItems,
  }) {
    return SelectionState<T>(
      isSelectionMode: isSelectionMode ?? this.isSelectionMode,
      selectedItems: selectedItems ?? this.selectedItems,
    );
  }
}
