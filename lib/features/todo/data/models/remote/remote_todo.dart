import 'package:json_annotation/json_annotation.dart';
import 'package:todo_list/features/todo/domain/entities/importance.dart';

part 'remote_todo.g.dart';

@JsonSerializable()
class RemoteTodo {
  final String id;
  final String text;
  final Importance importance;
  final int? deadline;
  final bool done;
  final String? color;

  @JsonKey(name: 'created_at')
  final int createdAt;

  @JsonKey(name: 'changed_at')
  final int changedAt;

  @JsonKey(name: 'last_updated_by')
  final String lastUpdatedBy;

  RemoteTodo({
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

  factory RemoteTodo.fromJson(Map<String, dynamic> json) =>
      _$RemoteTodoFromJson(json);

  Map<String, dynamic> toJson() => _$RemoteTodoToJson(this);
}
