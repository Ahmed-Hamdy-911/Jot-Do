import 'package:hive_flutter/hive_flutter.dart';

import '../../features/home/data/models/note_model.dart';
import '../constants/constant.dart';

class LocalStorageService {
  // note
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(NoteModelAdapter());
    await Hive.openBox<NoteModel>(AppConstants.notesStorage);
  }
}
