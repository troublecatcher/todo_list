import 'package:dio/dio.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';
import 'package:todo_list/features/todo/data/todo_repository.dart';

class NetworkTodoRepository implements TodoRepository {
  final Dio _dio;

  NetworkTodoRepository(this._dio);

  @override
  Stream<List<Todo>> getTodos() async* {
    try {
      final response = await _dio.get('/list');
      if (response.statusCode == 200) {
        List<Todo> todos =
            (response.data as List).map((todo) => Todo.fromJson(todo)).toList();
        yield todos;
      } else {
        yield [];
      }
    } catch (e) {
      print('Error fetching todos: $e');
      yield [];
    }
    // yield [];
  }

  @override
  Future<void> addTodo(Todo todo) async {}

  @override
  Future<void> updateTodo(Todo todo) async {}

  @override
  Future<void> deleteTodoById(int id) async {}
}
