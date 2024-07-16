import 'package:bloc/bloc.dart';
import 'package:todo_list/config/logging/logger.dart';

part 'visibility_mode.dart';

class VisibilityCubit extends Cubit<VisibilityMode> {
  VisibilityCubit() : super(VisibilityMode.all);
  void toggle() {
    final newMode = switch (state) {
      VisibilityMode.all => VisibilityMode.undone,
      VisibilityMode.undone => VisibilityMode.all,
    };

    Log.i('toggle todo visibility to ${newMode.name}');
    emit(newMode);
  }
}
