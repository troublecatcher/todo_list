// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'local_todo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LocalTodo {
  @Index()
  String? get uuid => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  @Enumerated(EnumType.name)
  Importance? get importance => throw _privateConstructorUsedError;
  DateTime? get deadline => throw _privateConstructorUsedError;
  bool? get done => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get changedAt => throw _privateConstructorUsedError;
  String? get lastUpdatedBy => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LocalTodoCopyWith<LocalTodo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalTodoCopyWith<$Res> {
  factory $LocalTodoCopyWith(LocalTodo value, $Res Function(LocalTodo) then) =
      _$LocalTodoCopyWithImpl<$Res, LocalTodo>;
  @useResult
  $Res call(
      {@Index() String? uuid,
      String? text,
      @Enumerated(EnumType.name) Importance? importance,
      DateTime? deadline,
      bool? done,
      String? color,
      DateTime? createdAt,
      DateTime? changedAt,
      String? lastUpdatedBy});
}

/// @nodoc
class _$LocalTodoCopyWithImpl<$Res, $Val extends LocalTodo>
    implements $LocalTodoCopyWith<$Res> {
  _$LocalTodoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = freezed,
    Object? text = freezed,
    Object? importance = freezed,
    Object? deadline = freezed,
    Object? done = freezed,
    Object? color = freezed,
    Object? createdAt = freezed,
    Object? changedAt = freezed,
    Object? lastUpdatedBy = freezed,
  }) {
    return _then(_value.copyWith(
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      importance: freezed == importance
          ? _value.importance
          : importance // ignore: cast_nullable_to_non_nullable
              as Importance?,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      done: freezed == done
          ? _value.done
          : done // ignore: cast_nullable_to_non_nullable
              as bool?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      changedAt: freezed == changedAt
          ? _value.changedAt
          : changedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastUpdatedBy: freezed == lastUpdatedBy
          ? _value.lastUpdatedBy
          : lastUpdatedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocalTodoImplCopyWith<$Res>
    implements $LocalTodoCopyWith<$Res> {
  factory _$$LocalTodoImplCopyWith(
          _$LocalTodoImpl value, $Res Function(_$LocalTodoImpl) then) =
      __$$LocalTodoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@Index() String? uuid,
      String? text,
      @Enumerated(EnumType.name) Importance? importance,
      DateTime? deadline,
      bool? done,
      String? color,
      DateTime? createdAt,
      DateTime? changedAt,
      String? lastUpdatedBy});
}

/// @nodoc
class __$$LocalTodoImplCopyWithImpl<$Res>
    extends _$LocalTodoCopyWithImpl<$Res, _$LocalTodoImpl>
    implements _$$LocalTodoImplCopyWith<$Res> {
  __$$LocalTodoImplCopyWithImpl(
      _$LocalTodoImpl _value, $Res Function(_$LocalTodoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uuid = freezed,
    Object? text = freezed,
    Object? importance = freezed,
    Object? deadline = freezed,
    Object? done = freezed,
    Object? color = freezed,
    Object? createdAt = freezed,
    Object? changedAt = freezed,
    Object? lastUpdatedBy = freezed,
  }) {
    return _then(_$LocalTodoImpl(
      uuid: freezed == uuid
          ? _value.uuid
          : uuid // ignore: cast_nullable_to_non_nullable
              as String?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      importance: freezed == importance
          ? _value.importance
          : importance // ignore: cast_nullable_to_non_nullable
              as Importance?,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      done: freezed == done
          ? _value.done
          : done // ignore: cast_nullable_to_non_nullable
              as bool?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      changedAt: freezed == changedAt
          ? _value.changedAt
          : changedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastUpdatedBy: freezed == lastUpdatedBy
          ? _value.lastUpdatedBy
          : lastUpdatedBy // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$LocalTodoImpl extends _LocalTodo {
  const _$LocalTodoImpl(
      {@Index() this.uuid,
      this.text,
      @Enumerated(EnumType.name) this.importance,
      this.deadline,
      this.done,
      this.color,
      this.createdAt,
      this.changedAt,
      this.lastUpdatedBy})
      : super._();

  @override
  @Index()
  final String? uuid;
  @override
  final String? text;
  @override
  @Enumerated(EnumType.name)
  final Importance? importance;
  @override
  final DateTime? deadline;
  @override
  final bool? done;
  @override
  final String? color;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? changedAt;
  @override
  final String? lastUpdatedBy;

  @override
  String toString() {
    return 'LocalTodo(uuid: $uuid, text: $text, importance: $importance, deadline: $deadline, done: $done, color: $color, createdAt: $createdAt, changedAt: $changedAt, lastUpdatedBy: $lastUpdatedBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocalTodoImpl &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.importance, importance) ||
                other.importance == importance) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline) &&
            (identical(other.done, done) || other.done == done) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.changedAt, changedAt) ||
                other.changedAt == changedAt) &&
            (identical(other.lastUpdatedBy, lastUpdatedBy) ||
                other.lastUpdatedBy == lastUpdatedBy));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uuid, text, importance, deadline,
      done, color, createdAt, changedAt, lastUpdatedBy);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LocalTodoImplCopyWith<_$LocalTodoImpl> get copyWith =>
      __$$LocalTodoImplCopyWithImpl<_$LocalTodoImpl>(this, _$identity);
}

abstract class _LocalTodo extends LocalTodo {
  const factory _LocalTodo(
      {@Index() final String? uuid,
      final String? text,
      @Enumerated(EnumType.name) final Importance? importance,
      final DateTime? deadline,
      final bool? done,
      final String? color,
      final DateTime? createdAt,
      final DateTime? changedAt,
      final String? lastUpdatedBy}) = _$LocalTodoImpl;
  const _LocalTodo._() : super._();

  @override
  @Index()
  String? get uuid;
  @override
  String? get text;
  @override
  @Enumerated(EnumType.name)
  Importance? get importance;
  @override
  DateTime? get deadline;
  @override
  bool? get done;
  @override
  String? get color;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get changedAt;
  @override
  String? get lastUpdatedBy;
  @override
  @JsonKey(ignore: true)
  _$$LocalTodoImplCopyWith<_$LocalTodoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
