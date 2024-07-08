import 'package:todo_list/features/todo/data/dto/local/local_todo.dart';
import 'package:todo_list/features/todo/data/dto/remote/remote_todo.dart';
import 'package:todo_list/features/todo/domain/entities/todo_entity.dart';

extension RemoteTodoConversion on RemoteTodo {
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

extension LocalTodoConversion on LocalTodo {
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

extension TodoEntityConversion on TodoEntity {
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
