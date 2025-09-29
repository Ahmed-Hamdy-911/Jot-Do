import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'filter_model.g.dart';

@HiveType(typeId: 2)
class FilterModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  int color;

  @HiveField(3)
  String createdAt;

  FilterModel.empty()
      : this(id: '', name: '', color: 0x00000000, createdAt: '');

  FilterModel({
    String? id,
    required this.name,
    required this.color,
    String? createdAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now().toIso8601String();

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'color': color, 'created_at': createdAt};
  }

  factory FilterModel.fromJson(Map<String, dynamic> json) {
    return FilterModel(
      id: json['id'],
      name: json['name'],
      color: json['color'],
      createdAt: json['created_at'],
    );
  }
}
