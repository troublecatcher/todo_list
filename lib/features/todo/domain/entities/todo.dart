import 'package:todo_list/features/todo/domain/entities/importance.dart';
import 'package:todo_list/features/todo/domain/entities/wrapped.dart';

class Todo {
  final String id;
  final String text;
  final Importance importance;
  final DateTime? deadline;
  final bool done;
  final String? color;
  final DateTime createdAt;
  final DateTime changedAt;
  final String lastUpdatedBy;

  Todo({
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

  Todo copyWith({
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
    return Todo(
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

  Map<String, Object> toMap() {
    return {
      'id': id,
      'text': text,
      'importance': importance.name,
      'deadline': deadline?.toIso8601String() ?? 'null',
      'done': done ? 'true' : 'false',
      'color': color ?? 'null',
      'createdAt': createdAt.toIso8601String(),
      'changedAt': changedAt.toIso8601String(),
      'lastUpdatedBy': lastUpdatedBy,
    };
  }
}
