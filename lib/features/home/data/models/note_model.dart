import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String content;
  @HiveField(3)
  String createdAt;
  @HiveField(4)
  int? color;
  @HiveField(5)
  bool isArchived;
  @HiveField(6)
  bool isPinned;
  @HiveField(7)
  bool isFavorite;
  @HiveField(8)
  String? lastUpdatedAt;
  @HiveField(9)
  String? deletedAt;
  @HiveField(10)
  bool? isSynced;

  NoteModel({
    String? id,
    required this.title,
    required this.content,
    required this.createdAt,
     this.color,
    this.isArchived = false,
    this.isPinned = false,
    this.isFavorite = false,
    this.lastUpdatedAt,
    this.deletedAt,
    this.isSynced = true,
  }) : this.id = id ?? const Uuid().v4();

  /// Convert NoteModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'created_at': createdAt,
      'color': color,
      'is_archived': isArchived,
      'is_pinned': isPinned,
      'is_favorite': isFavorite,
      'last_updated_at': lastUpdatedAt,
      'is_synced': isSynced,
      'deleted_at': deletedAt
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
      isArchived: json['is_archived'] ?? false,
      isPinned: json['is_pinned'] ?? false,
      isFavorite: json['is_favorite'] ?? false,
      lastUpdatedAt: json['last_updated_at'],
      isSynced: json['is_synced'] ?? true,
      deletedAt: json['deleted_at'],
    );
  }

  //
  NoteModel copyWith({
    String? title,
    String? content,
    int? color,
    bool? isArchived,
    bool? isPinned,
    bool? isFavorite,
    String? lastUpdatedAt,
    bool? isSynced,
    String? deletedAt,
  }) {
    return NoteModel(
      id: id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt,
      color: color ?? this.color,
      isArchived: isArchived ?? this.isArchived,
      isPinned: isPinned ?? this.isPinned,
      isFavorite: isFavorite ?? this.isFavorite,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
      isSynced: isSynced ?? this.isSynced,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
}
