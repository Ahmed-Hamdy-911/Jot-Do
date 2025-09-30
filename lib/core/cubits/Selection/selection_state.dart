class SelectionState<T> {
  final bool isSelectionMode;
  final List<T> selectedItems;
  final List<T> allItems;

  SelectionState({
    this.isSelectionMode = false,
    this.selectedItems = const [],
    this.allItems = const [],
  });
  bool get allSelected =>
      allItems.isNotEmpty && selectedItems.length == allItems.length;
  SelectionState<T> copyWith({
    bool? isSelectionMode,
    List<T>? selectedItems,
    List<T>? allItems,
  }) {
    return SelectionState<T>(
      isSelectionMode: isSelectionMode ?? this.isSelectionMode,
      selectedItems: selectedItems ?? this.selectedItems,
      allItems: allItems ?? this.allItems,
    );
  }
}
