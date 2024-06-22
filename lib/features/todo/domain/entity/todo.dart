import 'package:isar/isar.dart';

part 'todo.g.dart';

@Collection()
class Todo {
  Id id = Isar.autoIncrement;
  String? content;
  @enumerated
  TodoPriority priority;
  DateTime? deadline;
  bool? done;

  Todo({
    required this.content,
    required this.priority,
    required this.deadline,
    required this.done,
  });

  Todo copyWith({
    Id? id,
    String? content,
    TodoPriority? priority,
    DateTime? deadline,
    bool? done,
  }) {
    return Todo(
      content: content ?? this.content,
      priority: this.priority,
      deadline: deadline,
      done: this.done,
    )..id = this.id;
  }
}

enum TodoPriority {
  none(displayName: 'Нет'),
  low(displayName: 'Низкий'),
  high(displayName: '!! Высокий');

  final String displayName;

  const TodoPriority({required this.displayName});
}
