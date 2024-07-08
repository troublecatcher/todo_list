import 'package:todo_list/features/todo/data/dto/remote/remote_todo.dart';

abstract class RemoteTodoSource {
  Future<(List<RemoteTodo>, int)> getTodos();
  Future<void> addTodo(RemoteTodo todo);
  Future<void> putFresh(List<RemoteTodo> todos);
  Future<void> updateTodo(RemoteTodo todo);
  Future<void> deleteTodo(RemoteTodo todo);
}
