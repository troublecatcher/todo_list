import 'package:todo_list/features/todo/data/dto/local/local_todo.dart';

abstract class LocalTodoSource {
  Future<List<LocalTodo>> getTodos();
  Future<void> addTodo(LocalTodo todo);
  Future<void> putFresh(List<LocalTodo> todos);
  Future<void> updateTodo(LocalTodo todo);
  Future<void> deleteTodo(LocalTodo todo);
}
