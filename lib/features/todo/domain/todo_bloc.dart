import 'dart:async';

import 'package:todo_list/features/todo/data/todo_repository.dart';
import 'package:todo_list/features/todo/domain/todo.dart';

class TodoBloc {
  final GetTodos getTodos;
  final AddTodo addTodo;
  final UpdateTodo updateTodo;
  final DeleteTodoById deleteTodoById;

  late final Stream<List<Todo>> _todoStream;

  Stream<List<Todo>> get todos => _todoStream;

  TodoBloc({
    required this.getTodos,
    required this.addTodo,
    required this.updateTodo,
    required this.deleteTodoById,
  }) {
    _todoStream = getTodos().asBroadcastStream();
  }

  Future<void> add(Todo todo) async {
    await addTodo.call(todo);
  }

  Future<void> update(Todo todo) async {
    await updateTodo.call(todo);
  }

  Future<void> delete(int id) async {
    await deleteTodoById.call(id);
  }
}
