part of '../repositories/todo_repository_impl.dart';

extension LocalToEntity on LocalTodoDto {
  TodoEntity toEntity() {
    return TodoEntity(
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
}
