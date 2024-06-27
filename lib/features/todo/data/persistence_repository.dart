import 'package:isar/isar.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';
import 'package:todo_list/features/todo/data/repository.dart';

class PersistenceTodoRepository implements TodoRepository {
  final Isar _isar;

  PersistenceTodoRepository(this._isar);

  @override
  Stream<List<Todo>> getTodos() {
    return _isar.todos.where().watch(fireImmediately: true);
  }

  @override
  Future<void> addTodo(Todo todo) async {
    await _isar.writeTxn(() async {
      await _isar.todos.put(todo);
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
