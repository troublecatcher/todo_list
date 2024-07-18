part of '../../../../../core/services/settings_service.dart';

class InitSyncSetting implements Setting<bool> {
  final SettingsStorage _storage;
  static const String _key = 'init_sync';

  InitSyncSetting._(this._storage);

  @override
  bool get value => _storage.get(_key) ?? false;

  @override
  Future<bool> set(bool value) => _storage.set(_key, value);
}
