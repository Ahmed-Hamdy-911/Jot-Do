import 'package:equatable/equatable.dart';
import '../../../data/models/filter_model.dart';

class FilterState extends Equatable {
  final List<FilterModel> filters;
  final String? selectedFilterId;

  const FilterState({
    this.filters = const [],
    this.selectedFilterId = 'all',
  });

  FilterState copyWith({
    List<FilterModel>? filters,
    String? selectedFilterId,
  }) {
    return FilterState(
      filters: filters ?? this.filters,
      selectedFilterId: selectedFilterId ?? this.selectedFilterId,
    );
  }

  @override
  List<Object?> get props => [filters, selectedFilterId];
}
