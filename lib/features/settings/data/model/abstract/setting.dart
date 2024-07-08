abstract class Setting<T> {
  T? get value;
  Future<bool> set(T value);
}
