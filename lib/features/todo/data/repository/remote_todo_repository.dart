import 'package:dio/dio.dart';
import 'package:todo_list/features/todo/data/repository/auth_interceptor.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';
import 'package:todo_list/features/todo/data/repository/todo_repository.dart';

class RemoteTodoRepository implements TodoRepository {
  final Dio _dio;

  RemoteTodoRepository(this._dio) {
    _dio.interceptors.add(AuthInterceptor());
  }

  @override
  Future<(List<Todo>, int)> getTodos() async {
    final response = await _dio.get('list');
    final int revision = response.data['revision'];
    List todoList = (response.data['list'] as List);
    final List<Todo> todos = todoList.map((e) => Todo.fromJson(e)).toList();
    return (todos, revision);
  }

  @override
  Future<void> addTodo(Todo todo) async =>
      await _dio.post('list', data: {'element': todo.toJson()});

  @override
  Future<void> putFresh(List<Todo> todos) async => await _dio.patch('list',
      data: {'list': todos.map((todo) => todo.toJson()).toList()});

  @override
  Future<void> updateTodo(Todo todo) async =>
      await _dio.put('list/${todo.id}', data: {'element': todo.toJson()});

  @override
  Future<void> deleteTodo(Todo todo) async =>
      await _dio.delete('list/${todo.id}');
}
