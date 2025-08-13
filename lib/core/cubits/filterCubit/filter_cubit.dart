import 'package:bloc/bloc.dart';
import 'package:jot_do/core/cubits/filterCubit/filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterState(filterIdex: 0));

  void switchSegment(int index) {
    emit(FilterState(filterIdex: index));
  }
}
