import 'package:hive/hive.dart';

part 'note_type_model.g.dart';

@HiveType(typeId: 1)
enum NoteType {
  @HiveField(0)
  text,

  @HiveField(1)
  voice,

  @HiveField(2)
  image,

  @HiveField(3)
  drawing,
}
