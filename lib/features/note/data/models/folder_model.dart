class FolderModel {
  final String id;
  final String name;
  final String color;
  final String userId;
  final DateTime createdAt;

  FolderModel({
    required this.id,
    required this.name,
    required this.color,
    required this.userId,
    required this.createdAt,
  });

  factory FolderModel.fromJson(Map<String, dynamic> json) {
    return FolderModel(
      id: json['id'] as String,
      name: json['name'] as String,
      color: json['color'] as String? ?? '#216AFD',
      userId: json['user_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id.isNotEmpty) 'id': id,
      'name': name,
      'color': color,
      'user_id': userId,
    };
  }
}
