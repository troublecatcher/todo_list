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
                text: '',
                importance: Importance.basic,
                deadline: null,
                done: false,
              ),
            EditTodo _ => action.todo,
          },
        );

  void changeText(String text) {
    Log.i('updated todo content: $text');
    emit(state.copyWith(
      text: text,
      deadline: state.deadline,
      color: state.color,
    ));
  }

  void changeImportance(Importance importance) {
    Log.i('updated todo priority ${importance.name}');
    emit(state.copyWith(
      importance: importance,
      deadline: state.deadline,
      color: state.color,
    ));
  }

  void changeDeadline(DateTime? deadline) {
    Log.i('updated todo deadline: ${deadline?.toIso8601String()}');
    emit(state.copyWith(
      deadline: deadline,
      color: state.color,
    ));
  }
}
