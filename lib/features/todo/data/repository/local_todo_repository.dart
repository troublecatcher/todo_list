import 'package:isar/isar.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';
import 'package:todo_list/features/todo/data/repository/todo_repository.dart';

class LocalTodoRepository implements TodoRepository {
  final Isar _isar;

  LocalTodoRepository(this._isar);

  @override
  Future<(List<Todo>, int)> getTodos() async {
    return (await _isar.todos.where().findAll(), -1);
  }

  @override
  Future<void> addTodo(Todo todo) async {
    await _isar.writeTxn(() async {
      await _isar.todos.put(todo);
    });
  }

  @override
  Future<void> putFresh(List<Todo> todos) async {
    await _isar.writeTxn(() async {
      await _isar.todos.putAll(todos);
    });
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    await _isar.writeTxn(() async {
      await _isar.todos.put(todo);
    });
  }

  @override
  Future<void> deleteTodo(Todo todo) async {
    await _isar.writeTxn(() async {
      await _isar.todos.delete(todo.isarId);
    });
  }
}
