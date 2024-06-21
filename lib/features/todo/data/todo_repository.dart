import 'package:todo_list/features/todo/domain/todo.dart';

abstract class TodoRepository {
  Stream<List<Todo>> getTodos();
  Future<void> addTodo(Todo todo);
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodoById(int id);
}

class GetTodos {
  final TodoRepository repository;

  GetTodos(this.repository);

  Stream<List<Todo>> call() {
    return repository.getTodos();
  }
}

class AddTodo {
  final TodoRepository repository;

  AddTodo(this.repository);

  Future<void> call(Todo todo) {
    return repository.addTodo(todo);
  }
}

class UpdateTodo {
  final TodoRepository repository;

  UpdateTodo(this.repository);

  Future<void> call(Todo todo) {
    return repository.updateTodo(todo);
  }
}

class DeleteTodoById {
  final TodoRepository repository;

  DeleteTodoById(this.repository);

  Future<void> call(int id) {
    return repository.deleteTodoById(id);
  }
}
