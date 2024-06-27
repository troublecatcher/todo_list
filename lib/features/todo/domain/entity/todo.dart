import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@Collection()
@JsonSerializable()
class Todo {
  Id id = Isar.autoIncrement;
  final String content;
  @enumerated
  final TodoPriority priority;
  final DateTime? deadline;
  final bool done;

  Todo({
    this.id = Isar.autoIncrement,
    required this.content,
    required this.priority,
    this.deadline,
    required this.done,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  Map<String, dynamic> toJson() => _$TodoToJson(this);

  Todo copyWith({
    int? id,
    String? content,
    TodoPriority? priority,
    DateTime? deadline,
    bool? done,
  }) {
    return Todo(
      id: id ?? this.id,
      content: content ?? this.content,
      priority: priority ?? this.priority,
      deadline: deadline,
      done: done ?? this.done,
    );
  }
}

enum TodoPriority {
  basic(displayName: 'Нет'),
  low(displayName: 'Низкий'),
  important(displayName: '!! Высокий');

  final String displayName;

  const TodoPriority({required this.displayName});
}
