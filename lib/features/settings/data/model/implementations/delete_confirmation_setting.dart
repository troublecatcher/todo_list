part of '../../../../../core/services/settings/settings_service.dart';

class DeleteConfirmationSetting implements Setting<bool> {
  final SettingsStorage _storage;
  static const String _key = 'delete_confirmation';

  DeleteConfirmationSetting._(this._storage);

  @override
  bool get value => _storage.get(_key) ?? true;

  @override
  Future<bool> set(bool value) => _storage.set(_key, value);
}
