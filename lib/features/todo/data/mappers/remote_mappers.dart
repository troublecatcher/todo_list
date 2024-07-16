part of '../todo_repository_impl.dart';

extension RemoteMapper on RemoteTodo {
  Todo toEntity() {
    return Todo(
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

  LocalTodo toLocal() {
    return LocalTodo(
      uuid: id,
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

extension RemoteListMapper on List<RemoteTodo> {
  List<Todo> toEntities() {
    return map((local) => local.toEntity()).toList();
  }

  List<LocalTodo> toLocalTodos() {
    return map((local) => local.toLocal()).toList();
  }
}
