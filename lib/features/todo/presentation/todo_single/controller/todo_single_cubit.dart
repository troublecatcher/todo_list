import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';

import '../../../../../config/config.dart';
import '../../../../../core/core.dart';
import '../../../../features.dart';

class TodoSingleCubit extends Cubit<Todo> {
  TodoSingleCubit({Todo? todo})
      : super(
          todo ??
              Todo(
                id: '',
                text: '',
                importance: Importance.basic,
                deadline: null,
                done: false,
                color: null,
                createdAt: DateTime.now(),
                changedAt: DateTime.now(),
                lastUpdatedBy: '',
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

  Todo assignMetadata(Todo? currentTodo) {
    Todo newTodo = state.copyWith(
      id: currentTodo?.id ?? const Uuid().v4(),
      createdAt: currentTodo?.createdAt ?? DateTime.now(),
      changedAt: DateTime.now(),
      lastUpdatedBy: GetIt.I<DeviceInfoService>().info,
    );
    Log.i('Saved todo: ${newTodo.id}');
    emit(newTodo);
    return newTodo;
  }
}
