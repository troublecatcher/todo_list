import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/core/services/shared_preferences_service.dart';

class DialogConfirmationCubit extends Cubit<bool> {
  final _prefs = GetIt.I<SharedPreferencesService>();
  DialogConfirmationCubit() : super(true) {
    init();
  }
  init() => emit(_prefs.confirmDialogs);
  set(bool confirm) async {
    await _prefs.setConfirmDialogs(confirm);
    emit(confirm);
  }
}
