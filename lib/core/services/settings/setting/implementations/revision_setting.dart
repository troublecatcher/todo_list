part of '../../service/settings_service.dart';

class RevisionSetting implements Setting<int> {
  final SettingsStorage _storage;
  static const String _key = 'revision';

  RevisionSetting._(this._storage);

  @override
  int get value => _storage.get(_key) ?? -1;

  @override
  Future<bool> set(int value) => _storage.set(_key, value);

  Future<void> increment() => _storage.set(_key, value + 1);
}
