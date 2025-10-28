class Todo {
  Todo({
    required this.createdAt,
    required this.title,
    this.isDone = false,
    this.expiresAt,
  });

  bool isDone;
  String title;
  DateTime createdAt;
  DateTime? expiresAt;
}


