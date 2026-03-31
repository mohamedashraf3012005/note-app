class NoteModel {
  final String id;
  final String title;
  final String content;
  final String folder;
  final DateTime createdAt;
  final String userId;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.folder,
    required this.createdAt,
    required this.userId,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'] as String,
      title: json['title'] as String? ?? 'Untitled',
      content: json['content'] as String? ?? '',
      folder: json['folder'] as String? ?? 'Personal',
      createdAt: DateTime.parse(json['created_at'] as String),
      userId: json['user_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id.isNotEmpty) 'id': id,
      'title': title,
      'content': content,
      'folder': folder,
      'user_id': userId,
    };
  }
}
