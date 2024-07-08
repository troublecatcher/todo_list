part of '../repositories/todo_repository_impl.dart';

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
