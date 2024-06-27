import 'package:todo_list/features/todo/domain/entity/todo.dart';

abstract class TodoRepository {
  Future<(List<Todo>, int)> getTodos();
  Future<void> addTodo(Todo todo);
  Future<void> putFresh(List<Todo> todos);
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodo(Todo todo);
}
