import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/core/services/settings_service.dart';

class LocaleCubit extends Cubit<String> {
  final _locale = GetIt.I<SettingsService>().locale;
  LocaleCubit() : super('ru');

  void init() => emit(_locale.value);
  Future<void> set(String locale) async {
    await _locale.set(locale);
    emit(locale);
  }
}
