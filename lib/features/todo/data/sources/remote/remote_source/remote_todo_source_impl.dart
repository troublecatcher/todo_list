import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/features/todo/data/dto/remote/remote_todo.dart';
import 'package:todo_list/features/todo/data/sources/remote/remote_source/remote_todo_source.dart';
import '../../../../../../core/services/preferences/preferences_service/preferences_service.dart';

part '../interceptors/auth_interceptor.dart';
part '../interceptors/revision_interceptor.dart';

class RemoteTodoSourceImpl implements RemoteTodoSource {
  final Dio _dio;

  RemoteTodoSourceImpl(this._dio) {
    _dio.interceptors.add(_AuthInterceptor());
    _dio.interceptors.add(_RevisionInterceptor());
  }

  @override
  Future<(List<RemoteTodo>, int)> getTodos() async {
    final Response<dynamic> response = await _dio.get('list');
    final revision = response.data['revision'] as int;
    final List<Map<String, dynamic>> todoList =
        (response.data['list'] as List).cast<Map<String, dynamic>>();
    final List<RemoteTodo> todos =
        todoList.map((e) => RemoteTodo.fromJson(e)).toList();
    return (todos, revision);
  }

  @override
  Future<void> addTodo(RemoteTodo todo) async {
    final Map<String, Map<String, dynamic>> data = {'element': todo.toJson()};
    await _dio.post<Map<String, dynamic>>('list', data: data);
  }

  @override
  Future<void> putFresh(List<RemoteTodo> todos) async {
    final Map<String, dynamic> data = {
      'list': todos.map((todo) => todo.toJson()).toList(),
    };
    await _dio.patch<Map<String, dynamic>>('list', data: data);
  }

  @override
  Future<void> updateTodo(RemoteTodo todo) async {
    final Map<String, Map<String, dynamic>> data = {'element': todo.toJson()};
    await _dio.put<Map<String, dynamic>>('list/${todo.id}', data: data);
  }

  @override
  Future<void> deleteTodo(RemoteTodo todo) async {
    await _dio.delete<Map<String, dynamic>>('list/${todo.id}');
  }
}
