import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/core/services/settings_service.dart';

part 'auth_type.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final _auth = GetIt.I<SettingsService>().auth;

  AuthCubit() : super(AuthState(source: AuthSource.env, key: ''));

  void init() {
    if (_auth.value != null) {
      emit(AuthState(source: AuthSource.manual, key: _auth.value!));
    } else {
      emit(AuthState(source: AuthSource.env, key: dotenv.env['auth']!));
    }
  }

  Future<void> set(AuthSource type, String key) async {
    switch (type) {
      case AuthSource.env:
        await _auth.set(null);
      case AuthSource.manual:
        await _auth.set(key);
    }
    emit(AuthState(source: type, key: key));
  }
}
