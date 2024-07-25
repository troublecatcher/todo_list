import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_list/features/todo/data/models/remote/unix_time_converter.dart';

import '../../../domain/entities/importance.dart';

part 'remote_todo.freezed.dart';
part 'remote_todo.g.dart';

@freezed
class RemoteTodo with _$RemoteTodo {
  const factory RemoteTodo({
    required String id,
    required String text,
    required Importance importance,
    @UnixTimeConverter() int? deadline,
    required bool done,
    String? color,
    @JsonKey(name: 'created_at') @UnixTimeConverter() required int createdAt,
    @JsonKey(name: 'changed_at') @UnixTimeConverter() required int changedAt,
    @JsonKey(name: 'last_updated_by') required String lastUpdatedBy,
  }) = _RemoteTodo;

  factory RemoteTodo.fromJson(Map<String, dynamic> json) =>
      _$RemoteTodoFromJson(json);
}
