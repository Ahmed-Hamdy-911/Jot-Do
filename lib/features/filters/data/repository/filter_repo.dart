import 'package:hive/hive.dart';

import '../../../../core/constants/app_constants.dart';
import '../models/filter_model.dart';

class FilterRepository {
  final _box = Hive.box<FilterModel>(AppConstants.filtersStorage);

  Future<void> addFilter(FilterModel filter) async {
    await _box.put(filter.id, filter);
  }

  Future<List<FilterModel>> getFilters() async {
    return _box.values.toList();
  }

  Future<void> deleteFilter(String id) async {
    await _box.delete(id);
  }
}
