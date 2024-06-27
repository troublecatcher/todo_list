import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/config/logging/logger.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_event.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_list_state.dart';
import 'package:todo_list/features/todo/data/repository.dart';

class TodoListBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _networkRepository;
  final TodoRepository _persistenceRepository;
  VisibilityMode mode = VisibilityMode.all;

  TodoListBloc({
    required TodoRepository networkRepository,
    required TodoRepository persistenceRepository,
  })  : _persistenceRepository = persistenceRepository,
        _networkRepository = networkRepository,
        super(TodoInitial()) {
    on<LoadTodos>((event, emit) async {
      emit(TodoLoading());
      try {
        await emit.forEach(
          _networkRepository.getTodos(),
          onData: (todos) {
            return TodoLoaded(todos
                .where(
                  (todo) => switch (mode) {
                    VisibilityMode.all => true,
                    VisibilityMode.undone => !todo.done,
                  },
                )
                .toList());
          },
          onError: (_, __) => TodoError('Failed to load todos'),
        );
      } catch (e) {
        emit(TodoError(e.toString()));
      }
    });

    on<AddTodoEvent>((event, emit) async {
      await _networkRepository.addTodo(event.todo);
      Log.i('created todo (id ${event.todo.id})');
      add(LoadTodos());
    });

    on<UpdateTodoEvent>((event, emit) async {
      await _networkRepository.updateTodo(event.todo);
      Log.i('updated todo (id ${event.todo.id})');
      add(LoadTodos());
    });

    on<DeleteTodoEvent>((event, emit) async {
      await _networkRepository.deleteTodo(event.todo);
      Log.i('deleted todo (id ${event.todo.id})');
      add(LoadTodos());
    });

    on<ToggleVisibilityMode>((event, emit) {
      mode = switch (mode) {
        VisibilityMode.all => VisibilityMode.undone,
        VisibilityMode.undone => VisibilityMode.all,
      };
      Log.i('toggle todo visibility to ${mode.name}');
      add(LoadTodos());
    });
    on<Fetch>((event, emit) async {
      emit(TodoLoading());
      try {
        await emit.forEach(
          _networkRepository.getTodos(),
          onData: (todos) => TodoLoaded(todos
              .where(
                (todo) => switch (mode) {
                  VisibilityMode.all => true,
                  VisibilityMode.undone => !todo.done,
                },
              )
              .toList()),
          onError: (_, __) => TodoError('Failed to load todos'),
        );
      } catch (e) {
        emit(TodoError(e.toString()));
      }
    });
  }
}

enum VisibilityMode { undone, all }
