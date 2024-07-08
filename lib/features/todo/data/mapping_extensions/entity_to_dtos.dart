import 'package:todo_list/features/todo/data/dto/local/local_todo_dto.dart';
import 'package:todo_list/features/todo/data/dto/remote/remote_todo_dto.dart';
import 'package:todo_list/features/todo/domain/entities/todo_entity.dart';

extension EntityToDtos on TodoEntity {
  RemoteTodoDto toRemote() {
    return RemoteTodoDto(
      id: id,
      text: text,
      importance: importance,
      deadline: deadline?.millisecondsSinceEpoch,
      done: done,
      color: color,
      createdAt: createdAt.millisecondsSinceEpoch,
      changedAt: changedAt.millisecondsSinceEpoch,
      lastUpdatedBy: lastUpdatedBy,
    );
  }

  LocalTodoDto toLocal() {
    return LocalTodoDto(
      id: id,
      text: text,
      importance: importance,
      deadline: deadline,
      done: done,
      color: color,
      createdAt: createdAt,
      changedAt: changedAt,
      lastUpdatedBy: lastUpdatedBy,
    );
  }
}
