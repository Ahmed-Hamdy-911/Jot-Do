import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/filter_model.dart';
import '../../../data/repository/filter_repo.dart';
import 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  final FilterRepository _repo;

  FilterCubit(this._repo) : super(const FilterState());

  Future<void> loadFilters() async {
    final filters = await _repo.getFilters();
    emit(state.copyWith(filters: filters));
  }

  Future<void> addFilter(FilterModel filter) async {
    await _repo.addFilter(filter);
    final filters = await _repo.getFilters();
    emit(state.copyWith(filters: filters));
  }

  Future<void> deleteFilter(String id) async {
    await _repo.deleteFilter(id);
    final filters = await _repo.getFilters();
    emit(state.copyWith(filters: filters));
  }

  void selectFilter(String? id) {
    emit(state.copyWith(selectedFilterId: id));
  }

  void resetSelectedFilter() {
    emit(state.copyWith(selectedFilterId: null));
  }
}
