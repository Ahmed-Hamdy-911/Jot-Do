import 'package:hive_flutter/hive_flutter.dart';

import '../../features/filters/data/models/filter_model.dart';
import '../../features/note/data/models/note_model.dart';
import '../../features/note/data/models/note_type_model.dart';
import '../constants/app_constants.dart';

class LocalStorageService {
  // note
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(NoteModelAdapter());
    Hive.registerAdapter(FilterModelAdapter());
    Hive.registerAdapter(NoteTypeAdapter());
    await Hive.openBox<NoteModel>(AppConstants.notesStorage);
    await Hive.openBox(AppConstants.settingsStorage);
    await Hive.openBox<FilterModel>(AppConstants.filtersStorage);
  }
}
