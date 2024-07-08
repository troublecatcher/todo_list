part of '../state_management/todo_list_bloc/todo_list_bloc.dart';

class FetchTodosUseCase {
  final TodoRepository _todoRepository;
  FetchTodosUseCase(this._todoRepository);

  Future<List<TodoEntity>> call() async {
    return await _todoRepository.fetchTodos();
  }
}

class AddTodoUseCase {
  final TodoRepository _todoRepository;
  AddTodoUseCase(this._todoRepository);

  Future<void> call(TodoEntity todo) async {
    await _todoRepository.addTodo(todo);
  }
}

class UpdateTodoUseCase {
  final TodoRepository _todoRepository;
  UpdateTodoUseCase(this._todoRepository);

  Future<void> call(TodoEntity todo) async {
    await _todoRepository.updateTodo(todo);
  }
}

class DeleteTodoUseCase {
  final TodoRepository _todoRepository;
  DeleteTodoUseCase(this._todoRepository);

  Future<void> call(TodoEntity todo) async {
    await _todoRepository.deleteTodo(todo);
  }
}
