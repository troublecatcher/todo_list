part of '../../../../../core/services/settings/settings_service.dart';

class ThemeSetting implements Setting<String> {
  final SettingsStorage _storage;
  static const String _key = 'theme';

  ThemeSetting._(this._storage);

  @override
  String get value => _storage.get(_key) ?? 'system';

  @override
  Future<bool> set(String value) => _storage.set(_key, value);
}
