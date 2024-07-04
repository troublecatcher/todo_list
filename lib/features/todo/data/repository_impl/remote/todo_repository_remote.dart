import 'package:dio/dio.dart';
import 'package:todo_list/features/todo/data/repository_impl/remote/auth_interceptor.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';
import 'package:todo_list/features/todo/data/repository/todo_repository.dart';

class TodoRepositoryRemote implements TodoRepository {
  final Dio _dio;

  TodoRepositoryRemote(this._dio) {
    _dio.interceptors.add(AuthInterceptor());
  }

  @override
  Future<(List<Todo>, int)> getTodos() async {
    final Response<dynamic> response = await _dio.get('list');
    final int revision = response.data['revision'];
    final List todoList = (response.data['list'] as List);
    final List<Todo> todos = todoList.map((e) => Todo.fromJson(e)).toList();
    return (todos, revision);
  }

  @override
  Future<void> addTodo(Todo todo) async {
    final Map data = {'element': todo.toJson()};
    await _dio.post('list', data: data);
  }

  @override
  Future<void> putFresh(List<Todo> todos) async {
    final Map data = {'list': todos.map((todo) => todo.toJson()).toList()};
    await _dio.patch('list', data: data);
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    final Map data = {'element': todo.toJson()};
    await _dio.put('list/${todo.id}', data: data);
  }

  @override
  Future<void> deleteTodo(Todo todo) async {
    await _dio.delete('list/${todo.id}');
  }
}
