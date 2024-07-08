import 'package:todo_list/features/todo/data/dto/remote/remote_todo_dto.dart';
import 'package:todo_list/features/todo/domain/entities/todo_entity.dart';

extension RemoteToEntity on RemoteTodoDto {
  TodoEntity toEntity() {
    return TodoEntity(
      id: id,
      text: text,
      importance: importance,
      deadline: deadline != null
          ? DateTime.fromMillisecondsSinceEpoch(deadline!)
          : null,
      done: done,
      color: color,
      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt),
      changedAt: DateTime.fromMillisecondsSinceEpoch(changedAt),
      lastUpdatedBy: lastUpdatedBy,
    );
  }
}
