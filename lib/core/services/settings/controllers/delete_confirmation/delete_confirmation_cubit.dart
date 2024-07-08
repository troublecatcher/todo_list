import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/core/services/settings/service/settings_service.dart';

class DeleteConfirmationCubit extends Cubit<bool> {
  final _confirmDialogs = GetIt.I<SettingsService>().confirmDialogs;
  DeleteConfirmationCubit() : super(true) {
    init();
  }
  void init() => emit(_confirmDialogs.value);
  Future<void> set(bool confirm) async {
    await _confirmDialogs.set(confirm);
    emit(confirm);
  }
}
