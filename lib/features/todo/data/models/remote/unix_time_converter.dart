import 'package:freezed_annotation/freezed_annotation.dart';

class UnixTimeConverter implements JsonConverter<int, int> {
  const UnixTimeConverter();

  @override
  int fromJson(int json) => json * 1000;

  @override
  int toJson(int object) => (object / 1000).round();
}
