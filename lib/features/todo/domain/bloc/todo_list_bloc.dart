import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/config/logging/logger.dart';
import 'package:todo_list/core/services/shared_preferences_service.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_event.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_state.dart';
import 'package:todo_list/features/todo/data/repository.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';

class TodoListBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _networkRepository;
  final TodoRepository _persistenceRepository;
  final SharedPreferencesService _sp = GetIt.I<SharedPreferencesService>();
  VisibilityMode mode = VisibilityMode.all;

  TodoListBloc({
    required TodoRepository networkRepository,
    required TodoRepository persistenceRepository,
  })  : _persistenceRepository = persistenceRepository,
        _networkRepository = networkRepository,
        super(TodoInitial()) {
    on<FetchTodos>((event, emit) async => await _fetchTodos(emit));
    on<AddTodoEvent>((event, emit) async => await _addTodo(event, emit));
    on<UpdateTodoEvent>((event, emit) async => await _updateTodo(event, emit));
    on<DeleteTodoEvent>((event, emit) async => await _deleteTodo(event, emit));
    on<ToggleVisibilityMode>((event, emit) => _toggleVisibility());
  }

  Future<void> _fetchTodos(Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      await emit.forEach(
        _networkRepository.getTodos(),
        onData: (todos) {
          condition(todo) => switch (mode) {
                VisibilityMode.all => true,
                VisibilityMode.undone => !todo.done,
              };
          return TodoLoaded(todos.where(condition).toList());
        },
        onError: (_, __) => TodoError('Failed to load todos'),
      );
    } catch (e) {
      Log.e('Error fetching todo: $e');
      emit(TodoError(e.toString()));
    }
  }

  Future<void> _addTodo(AddTodoEvent event, Emitter<TodoState> emit) async {
    try {
      await Future.wait([
        _networkRepository.addTodo(event.todo),
        _persistenceRepository.addTodo(event.todo),
        _sp.increment(),
      ]);
      Log.i('created todo (id ${event.todo.id})');
      if (state is TodoLoaded) {
        final currentState = state as TodoLoaded;
        final updatedTodos = List<Todo>.from(currentState.todos)
          ..add(event.todo);
        emit(TodoLoaded(updatedTodos));
      }
    } catch (e) {
      Log.e('Error adding todo: $e');
    }
  }

  Future<void> _updateTodo(
      UpdateTodoEvent event, Emitter<TodoState> emit) async {
    try {
      await Future.wait([
        _networkRepository.updateTodo(event.todo),
        _persistenceRepository.updateTodo(event.todo),
        _sp.increment(),
      ]);
      Log.i('updated todo (id ${event.todo.id})');
      if (state is TodoLoaded) {
        final currentState = state as TodoLoaded;
        final updatedTodos = currentState.todos.map((todo) {
          return todo.id == event.todo.id ? event.todo : todo;
        }).toList();
        emit(TodoLoaded(updatedTodos));
      }
    } catch (e) {
      Log.e('Error updating todo: $e');
    }
  }

  Future<void> _deleteTodo(
      DeleteTodoEvent event, Emitter<TodoState> emit) async {
    try {
      await Future.wait([
        _networkRepository.deleteTodo(event.todo),
        _persistenceRepository.deleteTodo(event.todo),
        _sp.increment(),
      ]);
      Log.i('deleted todo (id ${event.todo.id})');
      if (state is TodoLoaded) {
        final currentState = state as TodoLoaded;
        final updatedTodos = currentState.todos
            .where((todo) => todo.id != event.todo.id)
            .toList();
        emit(TodoLoaded(updatedTodos));
      }
    } catch (e) {
      Log.e('Error updating todo: $e');
    }
  }

  void _toggleVisibility() {
    mode = switch (mode) {
      VisibilityMode.all => VisibilityMode.undone,
      VisibilityMode.undone => VisibilityMode.all,
    };
    Log.i('toggle todo visibility to ${mode.name}');
  }
}

enum VisibilityMode { all, undone }
