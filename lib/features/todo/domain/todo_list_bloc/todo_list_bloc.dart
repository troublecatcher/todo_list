import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/config/logger/logger.dart';
import 'package:todo_list/features/todo/domain/todo_list_bloc/todo_list_event.dart';
import 'package:todo_list/features/todo/domain/todo_list_bloc/todo_list_state.dart';
import 'package:todo_list/features/todo/domain/entities/todo_entity.dart';
import 'package:todo_list/features/todo/domain/repository/todo_repository.dart';
import 'package:todo_list/features/todo/domain/todo_operation_cubit/todo_operation_notifier.dart';

class TodoListBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _todoRepository;
  final OperationStatusNotifier operationStatusNotifier;

  TodoListBloc({
    required TodoRepository todoRepository,
    required this.operationStatusNotifier,
  })  : _todoRepository = todoRepository,
        super(TodoInitial()) {
    on<TodosFetchStarted>((event, emit) => _fetchTodos(emit));
    on<TodoAdded>((event, emit) => _addTodo(event, emit));
    on<TodoUpdated>((event, emit) => _updateTodo(event, emit));
    on<TodoDeleted>((event, emit) => _deleteTodo(event, emit));
  }

  Future<void> _fetchTodos(Emitter<TodoState> emit) async {
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
    operationStatusNotifier.startOperation(event.todo);
    try {
      await _todoRepository.addTodo(event.todo);
      _updateStateWithNewTodo(event.todo, emit);
    } catch (e) {
      Log.e('Error creating todo ${event.todo.id}: $e');
      emit(TodoFailure(e.toString()));
    }
    operationStatusNotifier.endOperation();
  }

  Future<void> _updateTodo(
    TodoUpdated event,
    Emitter<TodoState> emit,
  ) async {
    operationStatusNotifier.startOperation(event.todo);
    try {
      await _todoRepository.updateTodo(event.todo);
      _updateStateWithUpdatedTodo(event.todo, emit);
    } catch (e) {
      Log.e('Error updating todo ${event.todo.id}: $e');
      emit(TodoFailure(e.toString()));
    }
    operationStatusNotifier.endOperation();
  }

  Future<void> _deleteTodo(
    TodoDeleted event,
    Emitter<TodoState> emit,
  ) async {
    operationStatusNotifier.startOperation(event.todo);
    try {
      await _todoRepository.deleteTodo(event.todo);
      _updateStateWithDeletedTodo(event.todo, emit);
    } catch (e) {
      Log.e('Error deleting todo ${event.todo.id}: $e');
      emit(TodoFailure(e.toString()));
    }
    operationStatusNotifier.endOperation();
  }

  void _updateStateWithNewTodo(
    TodoEntity todo,
    Emitter<TodoState> emit,
  ) {
    Log.i('Added todo ${todo.id}');
    final currentState = state as TodoLoadSuccess;
    final updatedTodos = List<TodoEntity>.from(currentState.todos)..add(todo);
    emit(TodoLoadSuccess(updatedTodos));
  }

  void _updateStateWithUpdatedTodo(
    TodoEntity todo,
    Emitter<TodoState> emit,
  ) {
    Log.i('Updated todo ${todo.id}');
    final currentState = state as TodoLoadSuccess;
    final updatedTodos = currentState.todos.map((t) {
      return t.id == todo.id ? todo : t;
    }).toList();
    emit(TodoLoadSuccess(updatedTodos));
  }

  void _updateStateWithDeletedTodo(
    TodoEntity todo,
    Emitter<TodoState> emit,
  ) {
    Log.i('Deleted todo ${todo.id}');
    final currentState = state as TodoLoadSuccess;
    final updatedTodos =
        currentState.todos.where((t) => t.id != todo.id).toList();
    emit(TodoLoadSuccess(updatedTodos));
  }
}
