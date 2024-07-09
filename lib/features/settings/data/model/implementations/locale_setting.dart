part of '../../../../../core/services/settings_service.dart';

class LocaleSetting implements Setting<String> {
  final SettingsStorage _storage;
  static const String _key = 'locale';

  LocaleSetting._(this._storage);

  @override
  String get value => _storage.get(_key) ?? 'ru';

  @override
  Future<bool> set(String value) => _storage.set(_key, value);
}
