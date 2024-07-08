import 'package:todo_list/features/todo/data/dto/remote/remote_todo_dto.dart';

abstract class RemoteTodoSource {
  Future<(List<RemoteTodoDto>, int)> getTodos();
  Future<void> addTodo(RemoteTodoDto todo);
  Future<void> putFresh(List<RemoteTodoDto> todos);
  Future<void> updateTodo(RemoteTodoDto todo);
  Future<void> deleteTodo(RemoteTodoDto todo);
}
