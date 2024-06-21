import 'package:isar/isar.dart';
import 'package:todo_list/features/todo/domain/todo.dart';
import 'package:todo_list/features/todo/data/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final Isar isar;

  TodoRepositoryImpl(this.isar);

  @override
  Stream<List<Todo>> getTodos() {
    return isar.todos.where().watch(fireImmediately: true);
  }

  @override
  Future<void> addTodo(Todo todo) async {
    await isar.writeTxn(() async {
      await isar.todos.put(todo);
    });
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    await isar.writeTxn(() async {
      await isar.todos.put(todo);
    });
  }

  @override
  Future<void> deleteTodoById(int id) async {
    await isar.writeTxn(() async {
      await isar.todos.delete(id);
    });
  }
}
