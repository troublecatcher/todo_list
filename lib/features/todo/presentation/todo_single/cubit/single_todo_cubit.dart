import 'package:bloc/bloc.dart';
import 'package:todo_list/config/logging/logger.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';
import 'package:todo_list/features/todo/presentation/common/todo_action.dart';

class SingleTodoCubit extends Cubit<Todo> {
  final TodoAction action;
  SingleTodoCubit({required this.action})
      : super(
          switch (action) {
            CreateTodo _ => Todo(
                content: '',
                priority: TodoPriority.none,
                deadline: null,
                done: false,
              ),
            EditTodo _ => action.todo,
          },
        );
  void changeContent(String content) {
    Log.i('updated todo content: $content');
    emit(state.copyWith(content: content));
  }

  void changePriority(TodoPriority priority) {
    Log.i('updated todo priority ${priority.name}');
    emit(state.copyWith(priority: priority));
  }

  void changeDeadline(DateTime? deadline) {
    Log.i('updated todo deadline: ${deadline?.toIso8601String()}');
    emit(state.copyWith(deadline: deadline));
  }
}
