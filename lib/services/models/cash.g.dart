// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCashDataModelCollection on Isar {
  IsarCollection<CashDataModel> get cashDataModels => this.collection();
}

const CashDataModelSchema = CollectionSchema(
  name: r'CashDataModel',
  id: -5543364588347420079,
  properties: {
    r'cash': PropertySchema(
      id: 0,
      name: r'cash',
      type: IsarType.double,
    ),
    r'portfolio': PropertySchema(
      id: 1,
      name: r'portfolio',
      type: IsarType.string,
    )
  },
  estimateSize: _cashDataModelEstimateSize,
  serialize: _cashDataModelSerialize,
  deserialize: _cashDataModelDeserialize,
  deserializeProp: _cashDataModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _cashDataModelGetId,
  getLinks: _cashDataModelGetLinks,
  attach: _cashDataModelAttach,
  version: '3.1.0+1',
);

int _cashDataModelEstimateSize(
  CashDataModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.portfolio.length * 3;
  return bytesCount;
}

void _cashDataModelSerialize(
  CashDataModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.cash);
  writer.writeString(offsets[1], object.portfolio);
}

CashDataModel _cashDataModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CashDataModel();
  object.cash = reader.readDouble(offsets[0]);
  object.id = id;
  object.portfolio = reader.readString(offsets[1]);
  return object;
}

P _cashDataModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cashDataModelGetId(CashDataModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cashDataModelGetLinks(CashDataModel object) {
  return [];
}

void _cashDataModelAttach(
    IsarCollection<dynamic> col, Id id, CashDataModel object) {
  object.id = id;
}

extension CashDataModelQueryWhereSort
    on QueryBuilder<CashDataModel, CashDataModel, QWhere> {
  QueryBuilder<CashDataModel, CashDataModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CashDataModelQueryWhere
    on QueryBuilder<CashDataModel, CashDataModel, QWhereClause> {
  QueryBuilder<CashDataModel, CashDataModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CashDataModel, CashDataModel, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<CashDataModel, CashDataModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CashDataModel, CashDataModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CashDataModel, CashDataModel, QAfterWhereClause> idBetween(
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

extension CashDataModelQueryFilter
    on QueryBuilder<CashDataModel, CashDataModel, QFilterCondition> {
  QueryBuilder<CashDataModel, CashDataModel, QAfterFilterCondition> cashEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cash',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CashDataModel, CashDataModel, QAfterFilterCondition>
      cashGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cash',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CashDataModel, CashDataModel, QAfterFilterCondition>
      cashLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cash',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CashDataModel, CashDataModel, QAfterFilterCondition> cashBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cash',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<CashDataModel, CashDataModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CashDataModel, CashDataModel, QAfterFilterCondition>
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

  QueryBuilder<CashDataModel, CashDataModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<CashDataModel, CashDataModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<CashDataModel, CashDataModel, QAfterFilterCondition>
      portfolioEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'portfolio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CashDataModel, CashDataModel, QAfterFilterCondition>
      portfolioGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'portfolio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CashDataModel, CashDataModel, QAfterFilterCondition>
      portfolioLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'portfolio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CashDataModel, CashDataModel, QAfterFilterCondition>
      portfolioBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'portfolio',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CashDataModel, CashDataModel, QAfterFilterCondition>
      portfolioStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'portfolio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CashDataModel, CashDataModel, QAfterFilterCondition>
      portfolioEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'portfolio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CashDataModel, CashDataModel, QAfterFilterCondition>
      portfolioContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'portfolio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CashDataModel, CashDataModel, QAfterFilterCondition>
      portfolioMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'portfolio',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CashDataModel, CashDataModel, QAfterFilterCondition>
      portfolioIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'portfolio',
        value: '',
      ));
    });
  }

  QueryBuilder<CashDataModel, CashDataModel, QAfterFilterCondition>
      portfolioIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'portfolio',
        value: '',
      ));
    });
  }
}

extension CashDataModelQueryObject
    on QueryBuilder<CashDataModel, CashDataModel, QFilterCondition> {}

extension CashDataModelQueryLinks
    on QueryBuilder<CashDataModel, CashDataModel, QFilterCondition> {}

extension CashDataModelQuerySortBy
    on QueryBuilder<CashDataModel, CashDataModel, QSortBy> {
  QueryBuilder<CashDataModel, CashDataModel, QAfterSortBy> sortByCash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cash', Sort.asc);
    });
  }

  QueryBuilder<CashDataModel, CashDataModel, QAfterSortBy> sortByCashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cash', Sort.desc);
    });
  }

  QueryBuilder<CashDataModel, CashDataModel, QAfterSortBy> sortByPortfolio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'portfolio', Sort.asc);
    });
  }

  QueryBuilder<CashDataModel, CashDataModel, QAfterSortBy>
      sortByPortfolioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'portfolio', Sort.desc);
    });
  }
}

extension CashDataModelQuerySortThenBy
    on QueryBuilder<CashDataModel, CashDataModel, QSortThenBy> {
  QueryBuilder<CashDataModel, CashDataModel, QAfterSortBy> thenByCash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cash', Sort.asc);
    });
  }

  QueryBuilder<CashDataModel, CashDataModel, QAfterSortBy> thenByCashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cash', Sort.desc);
    });
  }

  QueryBuilder<CashDataModel, CashDataModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CashDataModel, CashDataModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CashDataModel, CashDataModel, QAfterSortBy> thenByPortfolio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'portfolio', Sort.asc);
    });
  }

  QueryBuilder<CashDataModel, CashDataModel, QAfterSortBy>
      thenByPortfolioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'portfolio', Sort.desc);
    });
  }
}

extension CashDataModelQueryWhereDistinct
    on QueryBuilder<CashDataModel, CashDataModel, QDistinct> {
  QueryBuilder<CashDataModel, CashDataModel, QDistinct> distinctByCash() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cash');
    });
  }

  QueryBuilder<CashDataModel, CashDataModel, QDistinct> distinctByPortfolio(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'portfolio', caseSensitive: caseSensitive);
    });
  }
}

extension CashDataModelQueryProperty
    on QueryBuilder<CashDataModel, CashDataModel, QQueryProperty> {
  QueryBuilder<CashDataModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CashDataModel, double, QQueryOperations> cashProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cash');
    });
  }

  QueryBuilder<CashDataModel, String, QQueryOperations> portfolioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'portfolio');
    });
  }
}
