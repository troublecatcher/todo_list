part of '../../../../../core/services/settings_service.dart';

class DuckSetting implements Setting<bool> {
  final SettingsStorage _storage;
  static const String _key = 'duck';

  DuckSetting._(this._storage);

  @override
  bool get value => _storage.get(_key) ?? true;

  @override
  Future<bool> set(bool value) => _storage.set(_key, value);
}
