// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_todo_dto.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLocalTodoDtoCollection on Isar {
  IsarCollection<LocalTodoDto> get localTodoDtos => this.collection();
}

const LocalTodoDtoSchema = CollectionSchema(
  name: r'LocalTodoDto',
  id: 357558065313945282,
  properties: {
    r'changedAt': PropertySchema(
      id: 0,
      name: r'changedAt',
      type: IsarType.dateTime,
    ),
    r'color': PropertySchema(
      id: 1,
      name: r'color',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'deadline': PropertySchema(
      id: 3,
      name: r'deadline',
      type: IsarType.dateTime,
    ),
    r'done': PropertySchema(
      id: 4,
      name: r'done',
      type: IsarType.bool,
    ),
    r'id': PropertySchema(
      id: 5,
      name: r'id',
      type: IsarType.string,
    ),
    r'importance': PropertySchema(
      id: 6,
      name: r'importance',
      type: IsarType.string,
      enumMap: _LocalTodoDtoimportanceEnumValueMap,
    ),
    r'lastUpdatedBy': PropertySchema(
      id: 7,
      name: r'lastUpdatedBy',
      type: IsarType.string,
    ),
    r'text': PropertySchema(
      id: 8,
      name: r'text',
      type: IsarType.string,
    )
  },
  estimateSize: _localTodoDtoEstimateSize,
  serialize: _localTodoDtoSerialize,
  deserialize: _localTodoDtoDeserialize,
  deserializeProp: _localTodoDtoDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'id': IndexSchema(
      id: -3268401673993471357,
      name: r'id',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'id',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _localTodoDtoGetId,
  getLinks: _localTodoDtoGetLinks,
  attach: _localTodoDtoAttach,
  version: '3.1.0+1',
);

int _localTodoDtoEstimateSize(
  LocalTodoDto object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.color;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.id;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.importance;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  {
    final value = object.lastUpdatedBy;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.text;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _localTodoDtoSerialize(
  LocalTodoDto object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.changedAt);
  writer.writeString(offsets[1], object.color);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeDateTime(offsets[3], object.deadline);
  writer.writeBool(offsets[4], object.done);
  writer.writeString(offsets[5], object.id);
  writer.writeString(offsets[6], object.importance?.name);
  writer.writeString(offsets[7], object.lastUpdatedBy);
  writer.writeString(offsets[8], object.text);
}

LocalTodoDto _localTodoDtoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LocalTodoDto(
    changedAt: reader.readDateTimeOrNull(offsets[0]),
    color: reader.readStringOrNull(offsets[1]),
    createdAt: reader.readDateTimeOrNull(offsets[2]),
    deadline: reader.readDateTimeOrNull(offsets[3]),
    done: reader.readBoolOrNull(offsets[4]),
    id: reader.readStringOrNull(offsets[5]),
    importance: _LocalTodoDtoimportanceValueEnumMap[
        reader.readStringOrNull(offsets[6])],
    lastUpdatedBy: reader.readStringOrNull(offsets[7]),
    text: reader.readStringOrNull(offsets[8]),
  );
  return object;
}

P _localTodoDtoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 4:
      return (reader.readBoolOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (_LocalTodoDtoimportanceValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _LocalTodoDtoimportanceEnumValueMap = {
  r'basic': r'basic',
  r'low': r'low',
  r'important': r'important',
};
const _LocalTodoDtoimportanceValueEnumMap = {
  r'basic': Importance.basic,
  r'low': Importance.low,
  r'important': Importance.important,
};

Id _localTodoDtoGetId(LocalTodoDto object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _localTodoDtoGetLinks(LocalTodoDto object) {
  return [];
}

void _localTodoDtoAttach(
    IsarCollection<dynamic> col, Id id, LocalTodoDto object) {}

extension LocalTodoDtoQueryWhereSort
    on QueryBuilder<LocalTodoDto, LocalTodoDto, QWhere> {
  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension LocalTodoDtoQueryWhere
    on QueryBuilder<LocalTodoDto, LocalTodoDto, QWhereClause> {
  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterWhereClause> isarIdNotEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterWhereClause> isarIdGreaterThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterWhereClause> isarIdLessThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterWhereClause> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [null],
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterWhereClause> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'id',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterWhereClause> idEqualTo(
      String? id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterWhereClause> idNotEqualTo(
      String? id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [],
              upper: [id],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [id],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [id],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [],
              upper: [id],
              includeUpper: false,
            ));
      }
    });
  }
}

extension LocalTodoDtoQueryFilter
    on QueryBuilder<LocalTodoDto, LocalTodoDto, QFilterCondition> {
  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      changedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'changedAt',
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      changedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'changedAt',
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      changedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'changedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      changedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'changedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      changedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'changedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      changedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'changedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      colorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'color',
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      colorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'color',
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition> colorEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      colorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition> colorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition> colorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'color',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      colorStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition> colorEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition> colorContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'color',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition> colorMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'color',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      colorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'color',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      colorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'color',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      createdAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      createdAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      createdAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      deadlineIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deadline',
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      deadlineIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deadline',
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      deadlineEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deadline',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      deadlineGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deadline',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      deadlineLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deadline',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      deadlineBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deadline',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition> doneIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'done',
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      doneIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'done',
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition> doneEqualTo(
      bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'done',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition> idEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition> idGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition> idLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition> idBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition> idContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      importanceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'importance',
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      importanceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'importance',
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      importanceEqualTo(
    Importance? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      importanceGreaterThan(
    Importance? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'importance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      importanceLessThan(
    Importance? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'importance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      importanceBetween(
    Importance? lower,
    Importance? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'importance',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      importanceStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'importance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      importanceEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'importance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      importanceContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'importance',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      importanceMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'importance',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      importanceIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'importance',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      importanceIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'importance',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition> isarIdEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition> isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      lastUpdatedByIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastUpdatedBy',
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      lastUpdatedByIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastUpdatedBy',
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      lastUpdatedByEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastUpdatedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      lastUpdatedByGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastUpdatedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      lastUpdatedByLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastUpdatedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      lastUpdatedByBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastUpdatedBy',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      lastUpdatedByStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastUpdatedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      lastUpdatedByEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastUpdatedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      lastUpdatedByContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastUpdatedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      lastUpdatedByMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastUpdatedBy',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      lastUpdatedByIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastUpdatedBy',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      lastUpdatedByIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastUpdatedBy',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition> textIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'text',
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      textIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'text',
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition> textEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      textGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition> textLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition> textBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'text',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      textStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition> textEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition> textContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition> textMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'text',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      textIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterFilterCondition>
      textIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'text',
        value: '',
      ));
    });
  }
}

extension LocalTodoDtoQueryObject
    on QueryBuilder<LocalTodoDto, LocalTodoDto, QFilterCondition> {}

extension LocalTodoDtoQueryLinks
    on QueryBuilder<LocalTodoDto, LocalTodoDto, QFilterCondition> {}

extension LocalTodoDtoQuerySortBy
    on QueryBuilder<LocalTodoDto, LocalTodoDto, QSortBy> {
  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterSortBy> sortByChangedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'changedAt', Sort.asc);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterSortBy> sortByChangedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'changedAt', Sort.desc);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterSortBy> sortByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterSortBy> sortByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterSortBy> sortByDeadline() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deadline', Sort.asc);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterSortBy> sortByDeadlineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deadline', Sort.desc);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterSortBy> sortByDone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'done', Sort.asc);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterSortBy> sortByDoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'done', Sort.desc);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterSortBy> sortByImportance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'importance', Sort.asc);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterSortBy>
      sortByImportanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'importance', Sort.desc);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterSortBy> sortByLastUpdatedBy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdatedBy', Sort.asc);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterSortBy>
      sortByLastUpdatedByDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdatedBy', Sort.desc);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterSortBy> sortByText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.asc);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterSortBy> sortByTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.desc);
    });
  }
}

extension LocalTodoDtoQuerySortThenBy
    on QueryBuilder<LocalTodoDto, LocalTodoDto, QSortThenBy> {
  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterSortBy> thenByChangedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'changedAt', Sort.asc);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterSortBy> thenByChangedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'changedAt', Sort.desc);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterSortBy> thenByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterSortBy> thenByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterSortBy> thenByDeadline() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deadline', Sort.asc);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterSortBy> thenByDeadlineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deadline', Sort.desc);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterSortBy> thenByDone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'done', Sort.asc);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterSortBy> thenByDoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'done', Sort.desc);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterSortBy> thenByImportance() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'importance', Sort.asc);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterSortBy>
      thenByImportanceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'importance', Sort.desc);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterSortBy> thenByLastUpdatedBy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdatedBy', Sort.asc);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterSortBy>
      thenByLastUpdatedByDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUpdatedBy', Sort.desc);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterSortBy> thenByText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.asc);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QAfterSortBy> thenByTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.desc);
    });
  }
}

extension LocalTodoDtoQueryWhereDistinct
    on QueryBuilder<LocalTodoDto, LocalTodoDto, QDistinct> {
  QueryBuilder<LocalTodoDto, LocalTodoDto, QDistinct> distinctByChangedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'changedAt');
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QDistinct> distinctByColor(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'color', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QDistinct> distinctByDeadline() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deadline');
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QDistinct> distinctByDone() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'done');
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QDistinct> distinctByImportance(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'importance', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QDistinct> distinctByLastUpdatedBy(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastUpdatedBy',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalTodoDto, LocalTodoDto, QDistinct> distinctByText(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'text', caseSensitive: caseSensitive);
    });
  }
}

extension LocalTodoDtoQueryProperty
    on QueryBuilder<LocalTodoDto, LocalTodoDto, QQueryProperty> {
  QueryBuilder<LocalTodoDto, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<LocalTodoDto, DateTime?, QQueryOperations> changedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'changedAt');
    });
  }

  QueryBuilder<LocalTodoDto, String?, QQueryOperations> colorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'color');
    });
  }

  QueryBuilder<LocalTodoDto, DateTime?, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<LocalTodoDto, DateTime?, QQueryOperations> deadlineProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deadline');
    });
  }

  QueryBuilder<LocalTodoDto, bool?, QQueryOperations> doneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'done');
    });
  }

  QueryBuilder<LocalTodoDto, String?, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<LocalTodoDto, Importance?, QQueryOperations>
      importanceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'importance');
    });
  }

  QueryBuilder<LocalTodoDto, String?, QQueryOperations>
      lastUpdatedByProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastUpdatedBy');
    });
  }

  QueryBuilder<LocalTodoDto, String?, QQueryOperations> textProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'text');
    });
  }
}
