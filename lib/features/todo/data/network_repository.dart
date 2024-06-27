import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/config/logging/logger.dart';
import 'package:todo_list/core/services/shared_preferences_service.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';
import 'package:todo_list/features/todo/data/repository.dart';

class NetworkTodoRepository implements TodoRepository {
  final _sp = GetIt.I<SharedPreferencesService>();
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://beta.mrdekk.ru/todo/',
      headers: {'Authorization': 'Bearer Miriel'},
    ),
  );

  @override
  Stream<List<Todo>> getTodos() async* {
    try {
      final response = await _dio.get('list');
      if (response.statusCode == 200) {
        _sp.revision = response.data['revision'];
        List todoList = (response.data['list'] as List);
        final List<Todo> todos = todoList.map((e) => Todo.fromJson(e)).toList();
        yield todos;
      } else {
        yield [];
      }
    } catch (e) {
      Log.e('Error fetching todos: $e');
      yield [];
    }
  }

  @override
  Future<void> addTodo(Todo todo) async {
    try {
      final response = await _dio.post(
        'list',
        options: _getOptions(),
        data: {'element': todo.toJson()},
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to add todo');
      }
    } catch (e) {
      Log.e('Error adding todo: $e');
    }
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    try {
      final response = await _dio.put(
        'list/${todo.id}',
        options: _getOptions(),
        data: {'element': todo.toJson()},
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to update todo');
      }
    } catch (e) {
      Log.e('Error updating todo: $e');
    }
  }

  @override
  Future<void> deleteTodo(Todo todo) async {
    try {
      final response = await _dio.delete(
        'list/${todo.id}',
        options: _getOptions(),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to delete todo');
      }
    } catch (e) {
      Log.e('Error deleting todo: $e');
    }
  }

  Options _getOptions() =>
      Options(headers: {'X-Last-Known-Revision': _sp.revision});
}
