import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/core/services/shared_preferences_service.dart';

enum ApiKeyType { env, bearer, oauth }

class ApiKeyCubit extends Cubit<ApiKeyState> {
  final _prefs = GetIt.I<SharedPreferencesService>();
  ApiKeyCubit() : super(ApiKeyState(type: ApiKeyType.env, key: '')) {
    init();
  }
  init() {
    if (_prefs.bearer != null) {
      emit(ApiKeyState(type: ApiKeyType.bearer, key: _prefs.bearer!));
    } else if (_prefs.oauth != null) {
      emit(ApiKeyState(type: ApiKeyType.oauth, key: _prefs.oauth!));
    } else {
      emit(ApiKeyState(type: ApiKeyType.env, key: dotenv.env['auth']!));
    }
  }

  Future<void> set(ApiKeyType type, String key) async {
    switch (type) {
      case ApiKeyType.env:
        await _prefs.clearBearer();
        await _prefs.clearOAuth();
      case ApiKeyType.bearer:
        await _prefs.setBearer('Bearer $key');
        await _prefs.clearOAuth();
      case ApiKeyType.oauth:
        await _prefs.setOAuth('OAuth $key');
        await _prefs.clearBearer();
    }
    emit(ApiKeyState(type: type, key: key));
  }
}

final class ApiKeyState {
  final ApiKeyType type;
  final String key;

  ApiKeyState({required this.type, required this.key});
}
