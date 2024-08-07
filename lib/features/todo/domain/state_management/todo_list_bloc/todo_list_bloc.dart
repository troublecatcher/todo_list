import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/features/todo/data/models/remote/unauthorized_exception.dart';

import '../../../../../config/log/logger.dart';
import '../../../../../core/services/analytics.dart';
import '../../entities/todo.dart';
import '../../repository/todo_repository.dart';
import '../todo_operation/todo_operation_interface.dart';
import '../todo_operation/todo_operation_type.dart';

part 'todo_list_event.dart';
part 'todo_list_state.dart';

class TodoListBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _todoRepository;
  final TodoOperationInterface _todoOperation;
  final Analytics _analytics;

  TodoListBloc({
    required TodoRepository todoRepository,
    required TodoOperationInterface todoOperation,
    required Analytics analytics,
  })  : _todoRepository = todoRepository,
        _todoOperation = todoOperation,
        _analytics = analytics,
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
      _handleError(e, emit);
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
      _handleError(e, emit);
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
      _handleError(e, emit);
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
      _handleError(e, emit);
    }
    _todoOperation.endOperation();
  }

  void _handleError(
    dynamic error,
    Emitter<TodoState> emit,
  ) {
    if (error is UnauthorizedException) {
      emit(TodoUnauthorized());
    } else {
      emit(TodoFailure(error.toString()));
    }
  }

  void _updateStateWithNewTodo(
    Todo todo,
    Emitter<TodoState> emit,
  ) {
    Log.i('Added todo ${todo.id}');
    _analytics.logCreateTodo(todo);
    final currentState = state as TodoLoadSuccess;
    final updatedTodos = List<Todo>.from(currentState.todos)..add(todo);
    emit(TodoLoadSuccess(updatedTodos));
  }

  void _updateStateWithUpdatedTodo(
    Todo todo,
    Emitter<TodoState> emit,
  ) {
    Log.i('Updated todo ${todo.id}');
    _analytics.logUpdateTodo(todo);
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
    _analytics.logDeleteTodo(todo);
    final currentState = state as TodoLoadSuccess;
    final updatedTodos =
        currentState.todos.where((t) => t.id != todo.id).toList();
    emit(TodoLoadSuccess(updatedTodos));
  }
}
