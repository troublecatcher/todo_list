import 'package:bloc/bloc.dart';
import 'package:todo_list/config/logger/logger.dart';
import 'package:todo_list/features/todo/domain/entities/importance.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/domain/entities/wrapped.dart';

class TodoSingleCubit extends Cubit<Todo> {
  TodoSingleCubit({Todo? todo})
      : super(
          todo ??
              Todo(
                id: '', // will be updated upon saving
                text: '',
                importance: Importance.basic,
                deadline: null,
                done: false,
                color: null,
                createdAt: DateTime.now(), // will be updated upon saving
                changedAt: DateTime.now(), // will be updated upon saving
                lastUpdatedBy: '', // will be updated upon saving
              ),
        );

  void changeText(String text) {
    emit(
      state.copyWith(
        text: text,
      ),
    );
    Log.i('Updated todo text: $text');
  }

  void changeImportance(Importance importance) {
    emit(
      state.copyWith(
        importance: importance,
      ),
    );
    Log.i('Updated todo importance: ${importance.name}');
  }

  void changeDeadline(DateTime? deadline) {
    emit(
      state.copyWith(
        deadline: Wrapped.value(deadline),
      ),
    );
    Log.i('Updated todo deadline: ${deadline?.toIso8601String()}');
  }

  void changeColor(String? color) {
    emit(
      state.copyWith(
        color: Wrapped.value(color),
      ),
    );
    Log.i('Updated todo color: $color');
  }
}
