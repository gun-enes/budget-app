// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_data_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMonthlyDataModelCollection on Isar {
  IsarCollection<MonthlyDataModel> get monthlyDataModels => this.collection();
}

const MonthlyDataModelSchema = CollectionSchema(
  name: r'MonthlyDataModel',
  id: 4796954440434210934,
  properties: {
    r'expense': PropertySchema(
      id: 0,
      name: r'expense',
      type: IsarType.long,
    ),
    r'income': PropertySchema(
      id: 1,
      name: r'income',
      type: IsarType.long,
    ),
    r'title': PropertySchema(
      id: 2,
      name: r'title',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _monthlyDataModelEstimateSize,
  serialize: _monthlyDataModelSerialize,
  deserialize: _monthlyDataModelDeserialize,
  deserializeProp: _monthlyDataModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _monthlyDataModelGetId,
  getLinks: _monthlyDataModelGetLinks,
  attach: _monthlyDataModelAttach,
  version: '3.1.0+1',
);

int _monthlyDataModelEstimateSize(
  MonthlyDataModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _monthlyDataModelSerialize(
  MonthlyDataModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.expense);
  writer.writeLong(offsets[1], object.income);
  writer.writeDateTime(offsets[2], object.title);
}

MonthlyDataModel _monthlyDataModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MonthlyDataModel();
  object.expense = reader.readLong(offsets[0]);
  object.id = id;
  object.income = reader.readLong(offsets[1]);
  object.title = reader.readDateTime(offsets[2]);
  return object;
}

P _monthlyDataModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _monthlyDataModelGetId(MonthlyDataModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _monthlyDataModelGetLinks(MonthlyDataModel object) {
  return [];
}

void _monthlyDataModelAttach(
    IsarCollection<dynamic> col, Id id, MonthlyDataModel object) {
  object.id = id;
}

extension MonthlyDataModelQueryWhereSort
    on QueryBuilder<MonthlyDataModel, MonthlyDataModel, QWhere> {
  QueryBuilder<MonthlyDataModel, MonthlyDataModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MonthlyDataModelQueryWhere
    on QueryBuilder<MonthlyDataModel, MonthlyDataModel, QWhereClause> {
  QueryBuilder<MonthlyDataModel, MonthlyDataModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MonthlyDataModel, MonthlyDataModel, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<MonthlyDataModel, MonthlyDataModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MonthlyDataModel, MonthlyDataModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MonthlyDataModel, MonthlyDataModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MonthlyDataModelQueryFilter
    on QueryBuilder<MonthlyDataModel, MonthlyDataModel, QFilterCondition> {
  QueryBuilder<MonthlyDataModel, MonthlyDataModel, QAfterFilterCondition>
      expenseEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expense',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthlyDataModel, MonthlyDataModel, QAfterFilterCondition>
      expenseGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expense',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthlyDataModel, MonthlyDataModel, QAfterFilterCondition>
      expenseLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expense',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthlyDataModel, MonthlyDataModel, QAfterFilterCondition>
      expenseBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expense',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MonthlyDataModel, MonthlyDataModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthlyDataModel, MonthlyDataModel, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthlyDataModel, MonthlyDataModel, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthlyDataModel, MonthlyDataModel, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MonthlyDataModel, MonthlyDataModel, QAfterFilterCondition>
      incomeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'income',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthlyDataModel, MonthlyDataModel, QAfterFilterCondition>
      incomeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'income',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthlyDataModel, MonthlyDataModel, QAfterFilterCondition>
      incomeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'income',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthlyDataModel, MonthlyDataModel, QAfterFilterCondition>
      incomeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'income',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MonthlyDataModel, MonthlyDataModel, QAfterFilterCondition>
      titleEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthlyDataModel, MonthlyDataModel, QAfterFilterCondition>
      titleGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthlyDataModel, MonthlyDataModel, QAfterFilterCondition>
      titleLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
      ));
    });
  }

  QueryBuilder<MonthlyDataModel, MonthlyDataModel, QAfterFilterCondition>
      titleBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MonthlyDataModelQueryObject
    on QueryBuilder<MonthlyDataModel, MonthlyDataModel, QFilterCondition> {}

extension MonthlyDataModelQueryLinks
    on QueryBuilder<MonthlyDataModel, MonthlyDataModel, QFilterCondition> {}

extension MonthlyDataModelQuerySortBy
    on QueryBuilder<MonthlyDataModel, MonthlyDataModel, QSortBy> {
  QueryBuilder<MonthlyDataModel, MonthlyDataModel, QAfterSortBy>
      sortByExpense() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expense', Sort.asc);
    });
  }

  QueryBuilder<MonthlyDataModel, MonthlyDataModel, QAfterSortBy>
      sortByExpenseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expense', Sort.desc);
    });
  }

  QueryBuilder<MonthlyDataModel, MonthlyDataModel, QAfterSortBy>
      sortByIncome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'income', Sort.asc);
    });
  }

  QueryBuilder<MonthlyDataModel, MonthlyDataModel, QAfterSortBy>
      sortByIncomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'income', Sort.desc);
    });
  }

  QueryBuilder<MonthlyDataModel, MonthlyDataModel, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<MonthlyDataModel, MonthlyDataModel, QAfterSortBy>
      sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension MonthlyDataModelQuerySortThenBy
    on QueryBuilder<MonthlyDataModel, MonthlyDataModel, QSortThenBy> {
  QueryBuilder<MonthlyDataModel, MonthlyDataModel, QAfterSortBy>
      thenByExpense() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expense', Sort.asc);
    });
  }

  QueryBuilder<MonthlyDataModel, MonthlyDataModel, QAfterSortBy>
      thenByExpenseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expense', Sort.desc);
    });
  }

  QueryBuilder<MonthlyDataModel, MonthlyDataModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MonthlyDataModel, MonthlyDataModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MonthlyDataModel, MonthlyDataModel, QAfterSortBy>
      thenByIncome() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'income', Sort.asc);
    });
  }

  QueryBuilder<MonthlyDataModel, MonthlyDataModel, QAfterSortBy>
      thenByIncomeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'income', Sort.desc);
    });
  }

  QueryBuilder<MonthlyDataModel, MonthlyDataModel, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<MonthlyDataModel, MonthlyDataModel, QAfterSortBy>
      thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension MonthlyDataModelQueryWhereDistinct
    on QueryBuilder<MonthlyDataModel, MonthlyDataModel, QDistinct> {
  QueryBuilder<MonthlyDataModel, MonthlyDataModel, QDistinct>
      distinctByExpense() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expense');
    });
  }

  QueryBuilder<MonthlyDataModel, MonthlyDataModel, QDistinct>
      distinctByIncome() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'income');
    });
  }

  QueryBuilder<MonthlyDataModel, MonthlyDataModel, QDistinct>
      distinctByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title');
    });
  }
}

extension MonthlyDataModelQueryProperty
    on QueryBuilder<MonthlyDataModel, MonthlyDataModel, QQueryProperty> {
  QueryBuilder<MonthlyDataModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MonthlyDataModel, int, QQueryOperations> expenseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expense');
    });
  }

  QueryBuilder<MonthlyDataModel, int, QQueryOperations> incomeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'income');
    });
  }

  QueryBuilder<MonthlyDataModel, DateTime, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}
