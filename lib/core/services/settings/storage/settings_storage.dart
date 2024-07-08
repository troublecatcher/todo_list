abstract class SettingsStorage {
  T? get<T>(String key);
  Future<bool> set<T>(String key, T value);
  Future<bool> remove(String key);
}
