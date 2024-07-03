import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/config/logger/logger.dart';
import 'package:todo_list/core/services/shared_preferences_service.dart';
import 'package:todo_list/features/todo/data/repository/todo_repository.dart';
import 'package:todo_list/features/todo/domain/todo_list_bloc/todo_list_event.dart';
import 'package:todo_list/features/todo/domain/todo_list_bloc/todo_list_state.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';
import 'package:todo_list/features/todo/domain/todo_operation_cubit/todo_operation_notifier.dart';

class TodoListBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _remote;
  final TodoRepository _local;
  final SharedPreferencesService _sp = GetIt.I<SharedPreferencesService>();
  final OperationStatusNotifier operationStatusNotifier;

  TodoListBloc({
    required TodoRepository remote,
    required TodoRepository local,
    required this.operationStatusNotifier,
  })  : _local = local,
        _remote = remote,
        super(TodoInitial()) {
    on<TodosFetchStarted>((event, emit) => _fetchTodos(emit));
    on<TodoAdded>((event, emit) => _addTodo(event, emit));
    on<TodoUpdated>((event, emit) => _updateTodo(event, emit));
    on<TodoDeleted>((event, emit) => _deleteTodo(event, emit));
  }

  Future<void> _fetchTodos(Emitter<TodoState> emit) async {
    emit(TodoLoadInProgress());
    final int localRevision = _sp.revision;
    try {
      Log.i('Fetching todos remote');
      final (List<Todo> remoteTodos, int remoteRevision) =
          await _remote.getTodos();
      if (remoteRevision < localRevision) {
        final (List<Todo> localTodos, _) = await _local.getTodos();
        await _remote.putFresh(localTodos);
        await _sp.setRev(remoteRevision);
        Log.w('Local revision won, overwritten remote');
        emit(TodoLoadSuccess(localTodos));
      } else {
        await _local.putFresh(remoteTodos);
        await _sp.setRev(remoteRevision);
        Log.w('Remote revision won, overwritten local');
        emit(TodoLoadSuccess(remoteTodos));
      }
    } catch (e, s) {
      Log.e('Error fetching todos from remote: $e, $s');
      Log.i('Fetching todos local');
      try {
        final (List<Todo> localTodos, _) = await _local.getTodos();
        emit(TodoLoadSuccess(localTodos));
      } catch (e, s) {
        Log.e('Error fetching todos from local: $e, $s');
        emit(TodoFailure(e.toString()));
      }
    }
  }

  Future<void> _addTodo(
    TodoAdded event,
    Emitter<TodoState> emit,
  ) async {
    operationStatusNotifier.startOperation(event.todo);
    await _executeAction(
      remoteAction: () => _remote.addTodo(event.todo),
      localAction: () => _local.addTodo(event.todo),
      onSuccess: () => _updateStateWithNewTodo(event.todo, emit),
      onError: (e, s) => Log.e('Error creating todo ${event.todo.id}: $e, $s'),
      emit: emit,
    );
    operationStatusNotifier.endOperation();
  }

  Future<void> _updateTodo(
    TodoUpdated event,
    Emitter<TodoState> emit,
  ) async {
    operationStatusNotifier.startOperation(event.todo);
    await _executeAction(
      remoteAction: () => _remote.updateTodo(event.todo),
      localAction: () => _local.updateTodo(event.todo),
      onSuccess: () => _updateStateWithUpdatedTodo(event.todo, emit),
      onError: (e, s) => Log.e('Error updating todo ${event.todo.id}: $e, $s'),
      emit: emit,
    );
    operationStatusNotifier.endOperation();
  }

  Future<void> _deleteTodo(
    TodoDeleted event,
    Emitter<TodoState> emit,
  ) async {
    operationStatusNotifier.startOperation(event.todo);
    await _executeAction(
      remoteAction: () => _remote.deleteTodo(event.todo),
      localAction: () => _local.deleteTodo(event.todo),
      onSuccess: () => _updateStateWithDeletedTodo(event.todo, emit),
      onError: (e, s) => Log.e('Error deleting todo ${event.todo.id}: $e, $s'),
      emit: emit,
    );
    operationStatusNotifier.endOperation();
  }

  Future<void> _executeAction({
    required Function() remoteAction,
    required Function() localAction,
    required void Function() onSuccess,
    required void Function(dynamic e, dynamic s) onError,
    required Emitter<TodoState> emit,
  }) async {
    bool saved = false;
    try {
      await remoteAction();
      await _sp.incRev().then((_) => saved = true);
    } catch (e, s) {
      Log.e('Error in remote: $e, $s');
    }
    try {
      await localAction();
      if (!saved) await _sp.incRev();
      onSuccess();
    } catch (e, s) {
      onError(e, s);
      emit(TodoFailure(e.toString()));
    }
  }

  void _updateStateWithNewTodo(
    Todo todo,
    Emitter<TodoState> emit,
  ) {
    Log.i('Added todo ${todo.id}');
    final currentState = state as TodoLoadSuccess;
    final updatedTodos = List<Todo>.from(currentState.todos)..add(todo);
    emit(TodoLoadSuccess(updatedTodos));
  }

  void _updateStateWithUpdatedTodo(
    Todo todo,
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
    Todo todo,
    Emitter<TodoState> emit,
  ) {
    Log.i('Deleted todo ${todo.id}');
    final currentState = state as TodoLoadSuccess;
    final updatedTodos =
        currentState.todos.where((t) => t.id != todo.id).toList();
    emit(TodoLoadSuccess(updatedTodos));
  }
}
