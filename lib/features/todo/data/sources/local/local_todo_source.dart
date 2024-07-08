import 'package:todo_list/features/todo/data/dto/local/local_todo_dto.dart';

abstract class LocalTodoSource {
  Future<List<LocalTodoDto>> getTodos();
  Future<void> addTodo(LocalTodoDto todo);
  Future<void> putFresh(List<LocalTodoDto> todos);
  Future<void> updateTodo(LocalTodoDto todo);
  Future<void> deleteTodo(LocalTodoDto todo);
}
