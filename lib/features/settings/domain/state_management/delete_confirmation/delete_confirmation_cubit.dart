import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../../core/services/services.dart';

class DeleteConfirmationCubit extends Cubit<bool> {
  final _confirmDialogs = GetIt.I<SettingsService>().confirmDialogs;
  DeleteConfirmationCubit() : super(true);

  void init() => emit(_confirmDialogs.value);
  Future<void> set(bool confirm) async {
    await _confirmDialogs.set(confirm);
    emit(confirm);
  }
}
