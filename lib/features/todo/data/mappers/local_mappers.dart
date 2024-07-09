part of '../repositories/todo_repository_impl.dart';

extension LocalMapper on LocalTodo {
  Todo toEntity() {
    return Todo(
      id: id!,
      text: text!,
      importance: importance!,
      deadline: deadline,
      done: done!,
      color: color,
      createdAt: createdAt!,
      changedAt: changedAt!,
      lastUpdatedBy: lastUpdatedBy!,
    );
  }

  RemoteTodo toRemote() {
    return RemoteTodo(
      id: id!,
      text: text!,
      importance: importance!,
      deadline: deadline?.millisecondsSinceEpoch,
      done: done!,
      color: color,
      createdAt: createdAt!.millisecondsSinceEpoch,
      changedAt: changedAt!.millisecondsSinceEpoch,
      lastUpdatedBy: lastUpdatedBy!,
    );
  }
}

extension LocalListMapper on List<LocalTodo> {
  List<Todo> toEntities() {
    return map((local) => local.toEntity()).toList();
  }

  List<RemoteTodo> toRemoteTodos() {
    return map((local) => local.toRemote()).toList();
  }
}
