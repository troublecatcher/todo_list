import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/config/logging/logger.dart';
import 'package:todo_list/core/services/shared_preferences_service.dart';
import 'package:todo_list/features/todo/data/local_todo_repository.dart';
import 'package:todo_list/features/todo/data/remote_todo_repository.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_event.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_state.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';

class TodoListBloc extends Bloc<TodoEvent, TodoState> {
  final RemoteTodoRepository _remote;
  final LocalTodoRepository _local;
  final SharedPreferencesService _sp = GetIt.I<SharedPreferencesService>();

  TodoListBloc({
    required RemoteTodoRepository remote,
    required LocalTodoRepository local,
  })  : _local = local,
        _remote = remote,
        super(TodoInitial()) {
    on<FetchTodos>((event, emit) => _fetchTodos(emit));
    on<AddTodoEvent>((event, emit) => _addTodo(event, emit));
    on<UpdateTodoEvent>((event, emit) => _updateTodo(event, emit));
    on<DeleteTodoEvent>((event, emit) => _deleteTodo(event, emit));
  }

  Future<void> _fetchTodos(Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      final (List<Todo> remoteTodos, int remoteRevision) =
          await _remote.getTodos();
      final int localRevision = _sp.revision;
      if (remoteRevision < localRevision) {
        final (List<Todo> localTodos, _) = await _local.getTodos();
        await _remote.putFresh(localTodos);
        emit(TodoLoaded(localTodos));
      } else {
        await _local.putFresh(remoteTodos);
        emit(TodoLoaded(remoteTodos));
      }
      await _sp.setRev(remoteRevision);
    } catch (e) {
      Log.e('Error fetching todos from remote: $e');
      try {
        final (List<Todo> localTodos, _) = await _local.getTodos();
        emit(TodoLoaded(localTodos));
      } catch (e, s) {
        Log.e('Error fetching todos from local: $e, $s');
        emit(TodoError(e.toString()));
      }
    }
  }

  Future<void> _addTodo(
    AddTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    await _executeAction(
      remoteAction: () => Future.wait([
        _remote.addTodo(event.todo),
        _sp.incRev(),
      ]),
      localAction: () => _local.addTodo(event.todo),
      onSuccess: () => _updateStateWithNewTodo(event.todo, emit),
      onError: (e, s) => Log.e('Error creating todo ${event.todo.id}: $e, $s'),
      emit: emit,
    );
  }

  Future<void> _updateTodo(
    UpdateTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    await _executeAction(
      remoteAction: () => Future.wait([
        _remote.updateTodo(event.todo),
        _sp.incRev(),
      ]),
      localAction: () => _local.updateTodo(event.todo),
      onSuccess: () => _updateStateWithUpdatedTodo(event.todo, emit),
      onError: (e, s) => Log.e('Error updating todo ${event.todo.id}: $e, $s'),
      emit: emit,
    );
  }

  Future<void> _deleteTodo(
    DeleteTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    await _executeAction(
      remoteAction: () => Future.wait([
        _remote.deleteTodo(event.todo),
        _sp.incRev(),
      ]),
      localAction: () => _local.deleteTodo(event.todo),
      onSuccess: () => _updateStateWithDeletedTodo(event.todo, emit),
      onError: (e, s) => Log.e('Error deleting todo ${event.todo.id}: $e, $s'),
      emit: emit,
    );
  }

  Future<void> _executeAction({
    required Function() remoteAction,
    required Function() localAction,
    required void Function() onSuccess,
    required void Function(dynamic e, dynamic s) onError,
    required Emitter<TodoState> emit,
  }) async {
    try {
      await remoteAction();
    } catch (e) {
      Log.e('Error in remote action: $e');
    }
    try {
      await localAction();
      onSuccess();
    } catch (e, s) {
      onError(e, s);
      emit(TodoError(e.toString()));
    }
  }

  void _updateStateWithNewTodo(
    Todo todo,
    Emitter<TodoState> emit,
  ) {
    Log.i('Added todo ${todo.id}');
    final currentState = state as TodoLoaded;
    final updatedTodos = List<Todo>.from(currentState.todos)..add(todo);
    emit(TodoLoaded(updatedTodos));
  }

  void _updateStateWithUpdatedTodo(
    Todo todo,
    Emitter<TodoState> emit,
  ) {
    Log.i('Updated todo ${todo.id}');
    final currentState = state as TodoLoaded;
    final updatedTodos = currentState.todos.map((t) {
      return t.id == todo.id ? todo : t;
    }).toList();
    emit(TodoLoaded(updatedTodos));
  }

  void _updateStateWithDeletedTodo(
    Todo todo,
    Emitter<TodoState> emit,
  ) {
    Log.i('Deleted todo ${todo.id}');
    final currentState = state as TodoLoaded;
    final updatedTodos =
        currentState.todos.where((t) => t.id != todo.id).toList();
    emit(TodoLoaded(updatedTodos));
  }
}
