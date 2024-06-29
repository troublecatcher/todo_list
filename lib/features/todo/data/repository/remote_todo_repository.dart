import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/core/services/shared_preferences_service.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';
import 'package:todo_list/features/todo/data/repository/todo_repository.dart';

class RemoteTodoRepository implements TodoRepository {
  static final _sp = GetIt.I<SharedPreferencesService>();
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://hive.mrdekk.ru/todo/',
      headers: {'Authorization': '${dotenv.env['auth']}'},
    ),
  );

  @override
  Future<(List<Todo>, int)> getTodos() async {
    final response = await _dio.get('list');
    final int revision = response.data['revision'];
    List todoList = (response.data['list'] as List);
    final List<Todo> todos = todoList.map((e) => Todo.fromJson(e)).toList();
    return (todos, revision);
  }

  @override
  Future<void> addTodo(Todo todo) async => await _dio.post(
        'list',
        options: Options(headers: {'X-Last-Known-Revision': _sp.revision}),
        data: {'element': todo.toJson()},
      );

  @override
  Future<void> putFresh(List<Todo> todos) async => await _dio.patch(
        'list',
        options: Options(headers: {'X-Last-Known-Revision': _sp.revision}),
        data: {'list': todos.map((todo) => todo.toJson()).toList()},
      );

  @override
  Future<void> updateTodo(Todo todo) async => await _dio.put(
        'list/${todo.id}',
        options: Options(headers: {'X-Last-Known-Revision': _sp.revision}),
        data: {'element': todo.toJson()},
      );

  @override
  Future<void> deleteTodo(Todo todo) async => await _dio.delete(
        'list/${todo.id}',
        options: Options(headers: {'X-Last-Known-Revision': _sp.revision}),
      );
}
