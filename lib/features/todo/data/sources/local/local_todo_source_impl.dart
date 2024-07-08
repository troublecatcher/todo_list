import 'package:isar/isar.dart';
import 'package:todo_list/features/todo/data/dto/local/local_todo.dart';
import 'package:todo_list/features/todo/data/sources/local/local_todo_source.dart';

class LocalTodoSourceImpl implements LocalTodoSource {
  final Isar _isar;

  LocalTodoSourceImpl(this._isar);

  @override
  Future<List<LocalTodo>> getTodos() async {
    return await _isar.localTodos.where().findAll();
  }

  @override
  Future<void> addTodo(LocalTodo todo) async {
    await _isar.writeTxn(() async => await _isar.localTodos.put(todo));
  }

  @override
  Future<void> putFresh(List<LocalTodo> todos) async {
    await _isar.writeTxn(() async => await _isar.localTodos.putAll(todos));
  }

  @override
  Future<void> updateTodo(LocalTodo todo) async {
    await _isar.writeTxn(() async => await _isar.localTodos.put(todo));
  }

  @override
  Future<void> deleteTodo(LocalTodo todo) async {
    await _isar
        .writeTxn(() async => await _isar.localTodos.delete(todo.isarId!));
  }
}
