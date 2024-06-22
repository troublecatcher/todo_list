import 'package:todo_list/features/todo/domain/entity/todo.dart';

abstract class IGetTodos {
  Stream<List<Todo>> call();
}

abstract class IAddTodo {
  Future<void> call(Todo todo);
}

abstract class IUpdateTodo {
  Future<void> call(Todo todo);
}

abstract class IDeleteTodoById {
  Future<void> call(int id);
}
