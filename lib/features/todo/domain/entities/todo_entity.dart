import 'package:todo_list/features/todo/domain/entities/importance.dart';
import 'package:todo_list/features/todo/domain/entities/wrapped.dart';

class TodoEntity {
  final String id;
  final String text;
  final Importance importance;
  final DateTime? deadline;
  final bool done;
  final String? color;
  final DateTime createdAt;
  final DateTime changedAt;
  final String lastUpdatedBy;

  TodoEntity({
    required this.id,
    required this.text,
    required this.importance,
    this.deadline,
    required this.done,
    this.color,
    required this.createdAt,
    required this.changedAt,
    required this.lastUpdatedBy,
  });

  TodoEntity copyWith({
    String? id,
    String? text,
    Importance? importance,
    Wrapped<DateTime?>? deadline,
    bool? done,
    Wrapped<String?>? color,
    DateTime? createdAt,
    DateTime? changedAt,
    String? lastUpdatedBy,
  }) {
    return TodoEntity(
      id: id ?? this.id,
      text: text ?? this.text,
      importance: importance ?? this.importance,
      deadline: deadline != null ? deadline.value : this.deadline,
      done: done ?? this.done,
      color: color != null ? color.value : this.color,
      createdAt: createdAt ?? this.createdAt,
      changedAt: changedAt ?? this.changedAt,
      lastUpdatedBy: lastUpdatedBy ?? this.lastUpdatedBy,
    );
  }
}
