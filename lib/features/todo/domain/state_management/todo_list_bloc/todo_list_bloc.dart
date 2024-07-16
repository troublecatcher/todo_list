import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/config/logging/logger.dart';
import 'package:todo_list/core/services/analytics.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/domain/state_management/todo_operation/todo_operation.dart';
import 'package:todo_list/features/todo/domain/state_management/todo_operation/todo_operation_type.dart';

import '../../repository/todo_repository.dart';
part 'todo_list_event.dart';
part 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _todoRepository;
  final TodoOperation _todoOperation;

  TodoListBloc({
    required TodoRepository todoRepository,
    required TodoOperation todoOperation,
  })  : _todoRepository = todoRepository,
        _todoOperation = todoOperation,
        super(TodoInitial()) {
    on<TodosFetchStarted>((event, emit) => _fetchTodos(event, emit));
    on<TodoAdded>((event, emit) => _addTodo(event, emit));
    on<TodoUpdated>((event, emit) => _updateTodo(event, emit));
    on<TodoDeleted>((event, emit) => _deleteTodo(event, emit));
  }

  Future<void> _fetchTodos(
    TodosFetchStarted event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodoLoadInProgress());
    try {
      final todos = await _todoRepository.fetchTodos();
      emit(TodoLoadSuccess(todos));
    } catch (e) {
      emit(TodoFailure(e.toString()));
    }
  }

  Future<void> _addTodo(
    TodoAdded event,
    Emitter<TodoState> emit,
  ) async {
    _todoOperation.startOperation(
      event.todo,
      TodoOperationType.create,
    );
    try {
      await _todoRepository.addTodo(event.todo);
      _updateStateWithNewTodo(event.todo, emit);
    } catch (e) {
      Log.e('Error creating todo ${event.todo.id}: $e');
      emit(TodoFailure(e.toString()));
    }
    _todoOperation.endOperation();
  }

  Future<void> _updateTodo(
    TodoUpdated event,
    Emitter<TodoState> emit,
  ) async {
    _todoOperation.startOperation(
      event.todo,
      TodoOperationType.update,
    );
    try {
      await _todoRepository.updateTodo(event.todo);
      _updateStateWithUpdatedTodo(event.todo, emit);
    } catch (e) {
      Log.e('Error updating todo ${event.todo.id}: $e');
      emit(TodoFailure(e.toString()));
    }
    _todoOperation.endOperation();
  }

  Future<void> _deleteTodo(
    TodoDeleted event,
    Emitter<TodoState> emit,
  ) async {
    _todoOperation.startOperation(
      event.todo,
      TodoOperationType.delete,
    );
    try {
      await _todoRepository.deleteTodo(event.todo);
      _updateStateWithDeletedTodo(event.todo, emit);
    } catch (e) {
      Log.e('Error deleting todo ${event.todo.id}: $e');
      emit(TodoFailure(e.toString()));
    }
    _todoOperation.endOperation();
  }

  void _updateStateWithNewTodo(
    Todo todo,
    Emitter<TodoState> emit,
  ) {
    Log.i('Added todo ${todo.id}');
    Analytics.logCreateTodo(todo);
    final currentState = state as TodoLoadSuccess;
    final updatedTodos = List<Todo>.from(currentState.todos)..add(todo);
    emit(TodoLoadSuccess(updatedTodos));
  }

  void _updateStateWithUpdatedTodo(
    Todo todo,
    Emitter<TodoState> emit,
  ) {
    Log.i('Updated todo ${todo.id}');
    Analytics.logUpdateTodo(todo);
    final currentState = state as TodoLoadSuccess;
    final updatedTodos = currentState.todos.map((t) {
      return t.id == todo.id ? todo : t;
    }).toList();
    emit(TodoLoadSuccess(updatedTodos));
  }

  void _updateStateWithDeletedTodo(
    Todo todo,
    Emitter<TodoState> emit,
  ) {
    Log.i('Deleted todo ${todo.id}');
    Analytics.logDeleteTodo(todo);
    final currentState = state as TodoLoadSuccess;
    final updatedTodos =
        currentState.todos.where((t) => t.id != todo.id).toList();
    emit(TodoLoadSuccess(updatedTodos));
  }
}
