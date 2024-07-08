import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:todo_list/features/todo/domain/entities/importance.dart';

part 'local_todo_dto.g.dart';

@Collection()
class LocalTodoDto {
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

  LocalTodoDto({
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

  Id get isarId => _fastHash(id!);

  int _fastHash(String string) {
    var hash = 0xcbf29ce484222325;

    var i = 0;
    while (i < string.length) {
      final codeUnit = string.codeUnitAt(i++);
      hash ^= codeUnit >> 8;
      hash *= 0x100000001b3;
      hash ^= codeUnit & 0xFF;
      hash *= 0x100000001b3;
    }

    return hash;
  }
}
