import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/core/services/preferences/preferences_service/preferences_service.dart';

class DialogConfirmationCubit extends Cubit<bool> {
  final _confirmDialogs = GetIt.I<PreferencesService>().confirmDialogs;
  DialogConfirmationCubit() : super(true) {
    init();
  }
  void init() => emit(_confirmDialogs.value);
  Future<void> set(bool confirm) async {
    await _confirmDialogs.set(confirm);
    emit(confirm);
  }
}
