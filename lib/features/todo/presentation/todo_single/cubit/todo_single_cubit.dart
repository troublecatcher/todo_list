import 'package:bloc/bloc.dart';
import 'package:todo_list/config/logger/logger.dart';
import 'package:todo_list/features/todo/domain/entities/importance.dart';
import 'package:todo_list/features/todo/domain/entities/todo_entity.dart';

class TodoSingleCubit extends Cubit<TodoEntity> {
  TodoSingleCubit({TodoEntity? todo})
      : super(
          todo ??
              TodoEntity(
                id: '', // Assuming id will be set later when saving
                text: '',
                importance: Importance.basic,
                deadline: null,
                done: false,
                createdAt:
                    DateTime.now(), // Set to now by default for new todos
                changedAt:
                    DateTime.now(), // Set to now by default for new todos
                lastUpdatedBy:
                    '', // Assuming lastUpdatedBy will be set later when saving
              ),
        );

  void changeText(String text) {
    emit(
      state.copyWith(
        text: text,
        changedAt: DateTime.now(), // Update the changedAt timestamp
      ),
    );
    Log.i('Updated todo text: $text');
  }

  void changeImportance(Importance importance) {
    emit(
      state.copyWith(
        importance: importance,
        changedAt: DateTime.now(), // Update the changedAt timestamp
      ),
    );
    Log.i('Updated todo importance: ${importance.name}');
  }

  void changeDeadline(DateTime? deadline) {
    emit(
      state.copyWith(
        deadline: deadline,
        changedAt: DateTime.now(), // Update the changedAt timestamp
      ),
    );
    Log.i('Updated todo deadline: ${deadline?.toIso8601String()}');
  }

  void changeColor(String? color) {
    emit(
      state.copyWith(
        color: color,
        changedAt: DateTime.now(), // Update the changedAt timestamp
      ),
    );
    Log.i('Updated todo color: $color');
  }

  void toggleDone(bool done) {
    emit(
      state.copyWith(
        done: done,
        changedAt: DateTime.now(), // Update the changedAt timestamp
      ),
    );
    Log.i('Updated todo done status: $done');
  }
}
