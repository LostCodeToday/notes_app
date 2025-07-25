class Note {
  final String id;
  final String title;
  final String content;
  final String? categoryId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isArchived;

  Note({
    required this.id,
    required this.title,
    required this.content,
    this.categoryId,
    required this.createdAt,
    required this.updatedAt,
    this.isArchived = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'categoryId': categoryId,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'isArchived': isArchived,
      };

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        categoryId: json['categoryId'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        isArchived: json['isArchived'] ?? false,
      );
}
