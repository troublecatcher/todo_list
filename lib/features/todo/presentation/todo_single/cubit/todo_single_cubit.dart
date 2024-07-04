import 'package:bloc/bloc.dart';
import 'package:todo_list/config/logger/logger.dart';
import 'package:todo_list/features/todo/domain/entity/todo.dart';
import 'package:todo_list/features/todo/presentation/common/todo_intent.dart';

class TodoSingleCubit extends Cubit<Todo> {
  final TodoIntent intent;
  TodoSingleCubit({required this.intent})
      : super(
          switch (intent) {
            CreateTodoIntent _ => Todo(
                text: '',
                importance: Importance.basic,
                deadline: null,
                done: false,
              ),
            EditTodoIntent _ => intent.todo,
          },
        );

  void changeText(String text) {
    late Function fn;
    switch (intent) {
      case CreateTodoIntent _:
        fn = state.copyWithCreate;
        break;
      case EditTodoIntent _:
        fn = state.copyWithEdit;
        break;
    }
    emit(fn(
      text: text,
      deadline: state.deadline,
      color: state.color,
    ));
    Log.i('updated todo text: $text');
  }

  void changeImportance(Importance importance) {
    late Function fn;
    switch (intent) {
      case CreateTodoIntent _:
        fn = state.copyWithCreate;
        break;
      case EditTodoIntent _:
        fn = state.copyWithEdit;
        break;
    }
    emit(fn(
      importance: importance,
      deadline: state.deadline,
      color: state.color,
    ));
    Log.i('updated todo importance ${importance.name}');
  }

  void changeDeadline(DateTime? deadline) {
    late Function fn;
    switch (intent) {
      case CreateTodoIntent _:
        fn = state.copyWithCreate;
        break;
      case EditTodoIntent _:
        fn = state.copyWithEdit;
        break;
    }
    emit(fn(
      deadline: deadline,
      color: state.color,
    ));
    Log.i('updated todo deadline: ${deadline?.toIso8601String()}');
  }
}
