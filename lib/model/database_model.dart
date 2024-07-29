class Todo {
  int? id;
  String taskName;
  bool isDone;
  String note;
  int priority;
  int likes;

  Todo({
    this.id,
    required this.taskName,
    this.isDone = false,
    this.note = '',
    this.priority = 1,
    this.likes = 0,
  });

  factory Todo.fromMap(Map<String, dynamic> data) {
    return Todo(
      id: data['id'],
      taskName: data['taskName'],
      isDone: data['isDone'] == 1,
      note: data['note'],
      priority: data['priority'],
      likes: data['likes'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskName': taskName,
      'isDone': isDone ? 1 : 0,
      'note': note,
      'priority': priority,
      'likes': likes,
    };
  }
}