import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

import '../../../domain/entities/importance.dart';

part 'local_todo.freezed.dart';
part 'local_todo.g.dart';

@freezed
@Collection(ignore: {'copyWith'})
class LocalTodo with _$LocalTodo {
  const LocalTodo._();

  const factory LocalTodo({
    @Index() String? uuid,
    String? text,
    @Enumerated(EnumType.name) Importance? importance,
    DateTime? deadline,
    bool? done,
    String? color,
    DateTime? createdAt,
    DateTime? changedAt,
    String? lastUpdatedBy,
  }) = _LocalTodo;

  Id get id => _fastHash(uuid!);
  /*
    FNV-1a 64bit hash algorithm optimized for Dart Strings
    https://isar.dev/recipes/string_ids.html#fast-hash-function
  */
  int _fastHash(String string) {
    var hash = 0xcbf29ce484222325;
    var i = 0;
    while (i < string.length) {
      final codeUnit = string.codeUnitAt(i++);
      hash ^= codeUnit >> 8;
      hash *= 0x100000001b3;
      hash ^= codeUnit & 0xFF;
      hash *= 0x100000001b3;
    }
    return hash;
  }
}
