import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String content;
  @HiveField(3)
  final String createdAt;
  @HiveField(4)
  int color;
  @HiveField(5)
  final bool isHighlight;
  @HiveField(6)
  final bool isPinned;
  @HiveField(7)
  final bool isFavorite;

  NoteModel({
    String? id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.color,
    this.isHighlight = false,
    this.isPinned = false,
    this.isFavorite = false,
  }) : id = id ?? const Uuid().v4();

  /// Convert NoteModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'created_at': createdAt,
      'color': color,
      'is_highlight': isHighlight,
      'is_pinned': isPinned,
      'is_favorite': isFavorite,
    };
  }

  /// Create NoteModel from JSON
  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      createdAt: json['created_at'],
      color: json['color'],
      isHighlight: json['is_highlight'] ?? false,
      isPinned: json['is_pinned'] ?? false,
      isFavorite: json['is_favorite'] ?? false,
    );
  }
}
