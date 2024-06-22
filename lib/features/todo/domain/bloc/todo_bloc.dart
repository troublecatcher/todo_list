import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_event.dart';
import 'package:todo_list/features/todo/domain/bloc/todo_state.dart';
import 'package:todo_list/features/todo/data/todo_repository.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;

  TodoBloc({required this.todoRepository}) : super(TodoInitial()) {
    on<LoadTodos>((event, emit) async {
      emit(TodoLoading());
      try {
        await emit.forEach(
          todoRepository.getTodos(),
          onData: (todos) => TodoLoaded(todos),
          onError: (_, __) => TodoError('Failed to load todos'),
        );
      } catch (e) {
        emit(TodoError(e.toString()));
      }
    });

    on<AddTodoEvent>((event, emit) async {
      await todoRepository.addTodo(event.todo);
      add(LoadTodos());
    });

    on<UpdateTodoEvent>((event, emit) async {
      await todoRepository.updateTodo(event.todo);
      add(LoadTodos());
    });

    on<DeleteTodoEvent>((event, emit) async {
      await todoRepository.deleteTodoById(event.id);
      add(LoadTodos());
    });
  }
}
