import 'package:todo_list/features/todo/domain/entity/todo.dart';

abstract class TodoRepository {
  Stream<List<Todo>> getTodos();
  Stream<List<Todo>> getUndoneTodos();
  Future<void> addTodo(Todo todo);
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodoById(int id);
}
