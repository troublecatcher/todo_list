import 'package:freezed_annotation/freezed_annotation.dart';

enum Importance {
  @JsonValue('basic')
  basic,
  @JsonValue('low')
  low,
  @JsonValue('important')
  important;
}
