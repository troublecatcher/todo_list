import 'package:isar/isar.dart';
import 'package:todo_list/features/todo/data/dto/local/local_todo_dto.dart';
import 'package:todo_list/features/todo/data/sources/local/local_todo_source.dart';

class LocalTodoSourceImpl implements LocalTodoSource {
  final Isar _isar;

  LocalTodoSourceImpl(this._isar);

  @override
  Future<List<LocalTodoDto>> getTodos() async {
    return await _isar.localTodoDtos.where().findAll();
  }

  @override
  Future<void> addTodo(LocalTodoDto todo) async {
    await _isar.writeTxn(() async => await _isar.localTodoDtos.put(todo));
  }

  @override
  Future<void> putFresh(List<LocalTodoDto> todos) async {
    await _isar.writeTxn(() async => await _isar.localTodoDtos.putAll(todos));
  }

  @override
  Future<void> updateTodo(LocalTodoDto todo) async {
    await _isar.writeTxn(() async => await _isar.localTodoDtos.put(todo));
  }

  @override
  Future<void> deleteTodo(LocalTodoDto todo) async {
    await _isar.writeTxn(
      () async => await _isar.localTodoDtos.delete(todo.isarId),
    );
  }
}
