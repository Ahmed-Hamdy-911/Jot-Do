class NoteModel {
  final String? id;
  final String title;
  final String content;
  final String createdAt;
  final int color;
  final bool isHighlight;
  final bool isPinned;
  final bool isFavorite;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.color,
    this.isHighlight = false,
    this.isPinned = false,
    this.isFavorite = false,
  });

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
