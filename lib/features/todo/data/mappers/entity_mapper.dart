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
