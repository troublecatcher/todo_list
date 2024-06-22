import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/config/logging/logger.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_event.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_state.dart';
import 'package:todo_list/features/todo/data/todo_repository.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;
  VisibilityMode mode = VisibilityMode.all;

  TodoBloc({required this.todoRepository}) : super(TodoInitial()) {
    // this event is being added everytime
    // a change occurs in the list of todos, FOR NOW =)
    on<LoadTodos>((event, emit) async {
      emit(TodoLoading());
      switch (mode) {
        case VisibilityMode.all:
          try {
            await emit.forEach(
              todoRepository.getTodos(),
              onData: (todos) => TodoLoaded(todos),
              onError: (_, __) => TodoError('Failed to load todos'),
            );
          } catch (e) {
            emit(TodoError(e.toString()));
          }
          break;
        case VisibilityMode.undone:
          try {
            await emit.forEach(
              todoRepository.getUndoneTodos(),
              onData: (todos) => TodoLoaded(todos),
              onError: (_, __) => TodoError('Failed to load todos'),
            );
          } catch (e) {
            emit(TodoError(e.toString()));
          }
          break;
      }
    });

    on<AddTodoEvent>((event, emit) async {
      await todoRepository.addTodo(event.todo);
      Log.i('created todo (id ${event.todo.id})');
      add(LoadTodos());
    });

    on<UpdateTodoEvent>((event, emit) async {
      await todoRepository.updateTodo(event.todo);
      Log.i('updated todo (id ${event.todo.id})');
      add(LoadTodos());
    });

    on<DeleteTodoEvent>((event, emit) async {
      await todoRepository.deleteTodoById(event.id);
      Log.i('deleted todo (id ${event.id})');
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
  }
}

enum VisibilityMode { undone, all }
