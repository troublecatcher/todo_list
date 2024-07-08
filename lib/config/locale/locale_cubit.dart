import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/core/services/shared_preferences_service.dart';

class LocaleCubit extends Cubit<String> {
  final _prefs = GetIt.I<SharedPreferencesService>();
  LocaleCubit() : super('en') {
    init();
  }
  init() => emit(_prefs.locale);
  set(String locale) async {
    await _prefs.setLocale(locale);
    emit(locale);
  }
}
