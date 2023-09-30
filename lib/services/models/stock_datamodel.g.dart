// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_datamodel.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetStockDataModelCollection on Isar {
  IsarCollection<StockDataModel> get stockDataModels => this.collection();
}

const StockDataModelSchema = CollectionSchema(
  name: r'StockDataModel',
  id: -2239919520671560992,
  properties: {
    r'amount': PropertySchema(
      id: 0,
      name: r'amount',
      type: IsarType.long,
    ),
    r'bist': PropertySchema(
      id: 1,
      name: r'bist',
      type: IsarType.double,
    ),
    r'date': PropertySchema(
      id: 2,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'dollar': PropertySchema(
      id: 3,
      name: r'dollar',
      type: IsarType.double,
    ),
    r'portfolio': PropertySchema(
      id: 4,
      name: r'portfolio',
      type: IsarType.string,
    ),
    r'price': PropertySchema(
      id: 5,
      name: r'price',
      type: IsarType.double,
    ),
    r'title': PropertySchema(
      id: 6,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _stockDataModelEstimateSize,
  serialize: _stockDataModelSerialize,
  deserialize: _stockDataModelDeserialize,
  deserializeProp: _stockDataModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _stockDataModelGetId,
  getLinks: _stockDataModelGetLinks,
  attach: _stockDataModelAttach,
  version: '3.1.0+1',
);

int _stockDataModelEstimateSize(
  StockDataModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.portfolio.length * 3;
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _stockDataModelSerialize(
  StockDataModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.amount);
  writer.writeDouble(offsets[1], object.bist);
  writer.writeDateTime(offsets[2], object.date);
  writer.writeDouble(offsets[3], object.dollar);
  writer.writeString(offsets[4], object.portfolio);
  writer.writeDouble(offsets[5], object.price);
  writer.writeString(offsets[6], object.title);
}

StockDataModel _stockDataModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = StockDataModel();
  object.amount = reader.readLong(offsets[0]);
  object.bist = reader.readDouble(offsets[1]);
  object.date = reader.readDateTime(offsets[2]);
  object.dollar = reader.readDouble(offsets[3]);
  object.id = id;
  object.portfolio = reader.readString(offsets[4]);
  object.price = reader.readDouble(offsets[5]);
  object.title = reader.readString(offsets[6]);
  return object;
}

P _stockDataModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _stockDataModelGetId(StockDataModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _stockDataModelGetLinks(StockDataModel object) {
  return [];
}

void _stockDataModelAttach(
    IsarCollection<dynamic> col, Id id, StockDataModel object) {
  object.id = id;
}

extension StockDataModelQueryWhereSort
    on QueryBuilder<StockDataModel, StockDataModel, QWhere> {
  QueryBuilder<StockDataModel, StockDataModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension StockDataModelQueryWhere
    on QueryBuilder<StockDataModel, StockDataModel, QWhereClause> {
  QueryBuilder<StockDataModel, StockDataModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<StockDataModel, StockDataModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterWhereClause> idBetween(
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

extension StockDataModelQueryFilter
    on QueryBuilder<StockDataModel, StockDataModel, QFilterCondition> {
  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
      amountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amount',
        value: value,
      ));
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
      amountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amount',
        value: value,
      ));
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
      amountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amount',
        value: value,
      ));
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
      amountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
      bistEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bist',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
      bistGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bist',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
      bistLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bist',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
      bistBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bist',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
      dateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
      dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
      dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
      dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
      dollarEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dollar',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
      dollarGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dollar',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
      dollarLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dollar',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
      dollarBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dollar',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
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

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
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

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
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

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
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

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
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

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
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

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
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

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
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

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
      portfolioContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'portfolio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
      portfolioMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'portfolio',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
      portfolioIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'portfolio',
        value: '',
      ));
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
      portfolioIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'portfolio',
        value: '',
      ));
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
      priceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
      priceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
      priceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
      priceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'price',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
      titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
      titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
      titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
      titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
      titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
      titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
      titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension StockDataModelQueryObject
    on QueryBuilder<StockDataModel, StockDataModel, QFilterCondition> {}

extension StockDataModelQueryLinks
    on QueryBuilder<StockDataModel, StockDataModel, QFilterCondition> {}

extension StockDataModelQuerySortBy
    on QueryBuilder<StockDataModel, StockDataModel, QSortBy> {
  QueryBuilder<StockDataModel, StockDataModel, QAfterSortBy> sortByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterSortBy>
      sortByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterSortBy> sortByBist() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bist', Sort.asc);
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterSortBy> sortByBistDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bist', Sort.desc);
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterSortBy> sortByDollar() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dollar', Sort.asc);
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterSortBy>
      sortByDollarDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dollar', Sort.desc);
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterSortBy> sortByPortfolio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'portfolio', Sort.asc);
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterSortBy>
      sortByPortfolioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'portfolio', Sort.desc);
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterSortBy> sortByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.asc);
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterSortBy> sortByPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.desc);
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension StockDataModelQuerySortThenBy
    on QueryBuilder<StockDataModel, StockDataModel, QSortThenBy> {
  QueryBuilder<StockDataModel, StockDataModel, QAfterSortBy> thenByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterSortBy>
      thenByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterSortBy> thenByBist() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bist', Sort.asc);
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterSortBy> thenByBistDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bist', Sort.desc);
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterSortBy> thenByDollar() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dollar', Sort.asc);
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterSortBy>
      thenByDollarDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dollar', Sort.desc);
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterSortBy> thenByPortfolio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'portfolio', Sort.asc);
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterSortBy>
      thenByPortfolioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'portfolio', Sort.desc);
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterSortBy> thenByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.asc);
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterSortBy> thenByPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.desc);
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension StockDataModelQueryWhereDistinct
    on QueryBuilder<StockDataModel, StockDataModel, QDistinct> {
  QueryBuilder<StockDataModel, StockDataModel, QDistinct> distinctByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amount');
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QDistinct> distinctByBist() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bist');
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QDistinct> distinctByDollar() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dollar');
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QDistinct> distinctByPortfolio(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'portfolio', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QDistinct> distinctByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'price');
    });
  }

  QueryBuilder<StockDataModel, StockDataModel, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension StockDataModelQueryProperty
    on QueryBuilder<StockDataModel, StockDataModel, QQueryProperty> {
  QueryBuilder<StockDataModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<StockDataModel, int, QQueryOperations> amountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amount');
    });
  }

  QueryBuilder<StockDataModel, double, QQueryOperations> bistProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bist');
    });
  }

  QueryBuilder<StockDataModel, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<StockDataModel, double, QQueryOperations> dollarProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dollar');
    });
  }

  QueryBuilder<StockDataModel, String, QQueryOperations> portfolioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'portfolio');
    });
  }

  QueryBuilder<StockDataModel, double, QQueryOperations> priceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'price');
    });
  }

  QueryBuilder<StockDataModel, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}
