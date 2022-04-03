class Task {
  final String name;
  bool isCompleted;
  Task({
    required this.name,
    this.isCompleted = false,
  });

  Task.fromMap(Map map)
      : name = map['name'],
        isCompleted = map['isCompleted'];

  Map toMap() {
    return {
      'name': name,
      'isCompleted': isCompleted,
    };
  }
}
