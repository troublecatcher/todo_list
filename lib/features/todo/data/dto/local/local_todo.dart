import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:todo_list/features/todo/domain/entities/importance.dart';

part 'local_todo.g.dart';

@Collection()
class LocalTodo {
  Id? isarId = Isar.autoIncrement;

  @Index()
  String? id;

  String? text;

  @Enumerated(EnumType.name)
  Importance? importance;

  DateTime? deadline;

  bool? done;

  String? color;

  @JsonKey(name: 'created_at')
  DateTime? createdAt;

  @JsonKey(name: 'changed_at')
  DateTime? changedAt;

  @JsonKey(name: 'last_updated_by')
  String? lastUpdatedBy;

  LocalTodo({
    this.id,
    this.text,
    this.importance,
    this.deadline,
    this.done,
    this.color,
    this.createdAt,
    this.changedAt,
    this.lastUpdatedBy,
  });
}
