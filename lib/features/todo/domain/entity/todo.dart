import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@Collection()
@JsonSerializable(constructor: '_')
class Todo {
  late String id;

  final String text;

  @enumerated
  final Importance importance;

  @JsonKey(fromJson: _dateFromJsonNullable, toJson: _dateToJsonNullable)
  final DateTime? deadline;

  final bool done;

  final String? color;

  @JsonKey(name: 'created_at', fromJson: _dateFromJson, toJson: _dateToJson)
  late DateTime createdAt;

  @JsonKey(name: 'changed_at', fromJson: _dateFromJson, toJson: _dateToJson)
  late DateTime changedAt;

  @JsonKey(name: 'last_updated_by')
  late String lastUpdatedBy;

  Todo._({
    required this.id,
    required this.text,
    required this.importance,
    this.deadline,
    required this.done,
    this.color,
    required this.createdAt,
    required this.changedAt,
    required this.lastUpdatedBy,
  });

  Todo({
    required this.text,
    required this.importance,
    this.deadline,
    this.color,
    required this.done,
  });

  Id get isarId => _fastHash(id);

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  Map<String, dynamic> toJson() => _$TodoToJson(this);

  Todo copyWithEdit({
    String? id,
    String? text,
    Importance? importance,
    DateTime? deadline,
    bool? done,
    String? color,
    DateTime? createdAt,
    DateTime? changedAt,
    String? lastUpdatedBy,
  }) {
    return Todo._(
      id: id ?? this.id,
      text: text ?? this.text,
      importance: importance ?? this.importance,
      deadline: deadline,
      done: done ?? this.done,
      color: color,
      createdAt: createdAt ?? this.createdAt,
      changedAt: changedAt ?? this.changedAt,
      lastUpdatedBy: lastUpdatedBy ?? this.lastUpdatedBy,
    );
  }

  Todo copyWithCreate({
    String? text,
    DateTime? deadline,
    String? color,
    Importance? importance,
    bool? done,
  }) {
    return Todo(
      text: text ?? this.text,
      deadline: deadline,
      color: color,
      importance: importance ?? this.importance,
      done: false,
    );
  }

  static DateTime _dateFromJson(int unix) =>
      DateTime.fromMillisecondsSinceEpoch(unix);
  static int _dateToJson(DateTime time) => time.millisecondsSinceEpoch;
  static DateTime? _dateFromJsonNullable(int? unix) =>
      unix == null ? null : DateTime.fromMillisecondsSinceEpoch(unix);
  static int? _dateToJsonNullable(DateTime? time) =>
      time?.millisecondsSinceEpoch;

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

enum Importance {
  basic,
  low,
  important;
}
