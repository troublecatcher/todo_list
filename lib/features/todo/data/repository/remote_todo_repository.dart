import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/core/services/shared_preferences_service.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';
import 'package:todo_list/features/todo/data/repository/todo_repository.dart';

class RemoteTodoRepository implements TodoRepository {
  final _sp = GetIt.I<SharedPreferencesService>();
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://hive.mrdekk.ru/todo/',
      headers: {'Authorization': 'Bearer Miriel'},
    ),
  );

  @override
  Future<(List<Todo>, int)> getTodos() async {
    final response = await _dio.get('list');
    if (response.statusCode == 200) {
      final int revision = response.data['revision'];
      List todoList = (response.data['list'] as List);
      final List<Todo> todos = todoList.map((e) => Todo.fromJson(e)).toList();
      return (todos, revision);
    } else {
      return (<Todo>[], -1);
    }
  }

  @override
  Future<void> addTodo(Todo todo) async {
    final response = await _dio.post(
      'list',
      options: Options(headers: {'X-Last-Known-Revision': _sp.revision}),
      data: {'element': todo.toJson()},
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add todo');
    }
  }

  @override
  Future<void> putFresh(List<Todo> todos) async {
    final response = await _dio.patch(
      'list',
      options: Options(headers: {'X-Last-Known-Revision': _sp.revision}),
      data: {'list': todos.map((todo) => todo.toJson()).toList()},
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add todo');
    }
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    final response = await _dio.put(
      'list/${todo.id}',
      options: Options(headers: {'X-Last-Known-Revision': _sp.revision}),
      data: {'element': todo.toJson()},
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update todo');
    }
  }

  @override
  Future<void> deleteTodo(Todo todo) async {
    final response = await _dio.delete(
      'list/${todo.id}',
      options: Options(headers: {'X-Last-Known-Revision': _sp.revision}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete todo');
    }
  }
}
