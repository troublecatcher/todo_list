import 'package:todo_list/features/todo/domain/entities/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> fetchTodos();
  Future<void> addTodo(Todo todo);
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodo(Todo todo);
}
