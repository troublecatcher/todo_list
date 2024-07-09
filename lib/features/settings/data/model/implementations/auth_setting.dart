part of '../../../../../core/services/settings_service.dart';

class AuthSetting implements Setting<String> {
  final SettingsStorage _storage;
  static const String _key = 'auth';

  AuthSetting._(this._storage);

  @override
  String? get value => _storage.get(_key);

  @override
  Future<bool> set(String? value) => _storage.set(_key, value);
}
