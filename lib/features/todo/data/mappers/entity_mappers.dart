part of '../todo_repository_impl.dart';

extension EntityMapper on Todo {
  RemoteTodo toRemote() {
    return RemoteTodo(
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

  LocalTodo toLocal() {
    return LocalTodo(
      uuid: id,
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

extension EntityListMapper on List<Todo> {
  List<RemoteTodo> toRemoteTodos() {
    return map((local) => local.toRemote()).toList();
  }

  List<LocalTodo> toLocalTodos() {
    return map((local) => local.toLocal()).toList();
  }
}
