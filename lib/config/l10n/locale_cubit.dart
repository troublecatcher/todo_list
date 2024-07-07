import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/core/services/preferences/preferences_service/preferences_service.dart';

class LocaleCubit extends Cubit<String> {
  final _locale = GetIt.I<PreferencesService>().locale;
  LocaleCubit() : super('ru') {
    init();
  }
  init() => emit(_locale.value);
  set(String locale) async {
    await _locale.set(locale);
    emit(locale);
  }
}
