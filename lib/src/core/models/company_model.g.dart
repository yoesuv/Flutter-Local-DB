// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCompanyCollection on Isar {
  IsarCollection<Company> get companys => this.collection();
}

const CompanySchema = CollectionSchema(
  name: r'Company',
  id: -3921622125198845844,
  properties: {
    r'bs': PropertySchema(
      id: 0,
      name: r'bs',
      type: IsarType.string,
    ),
    r'catchPhrase': PropertySchema(
      id: 1,
      name: r'catchPhrase',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 2,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _companyEstimateSize,
  serialize: _companySerialize,
  deserialize: _companyDeserialize,
  deserializeProp: _companyDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _companyGetId,
  getLinks: _companyGetLinks,
  attach: _companyAttach,
  version: '3.1.0+1',
);

int _companyEstimateSize(
  Company object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.bs;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.catchPhrase;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _companySerialize(
  Company object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.bs);
  writer.writeString(offsets[1], object.catchPhrase);
  writer.writeString(offsets[2], object.name);
}

Company _companyDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Company(
    bs: reader.readStringOrNull(offsets[0]),
    catchPhrase: reader.readStringOrNull(offsets[1]),
    name: reader.readStringOrNull(offsets[2]),
  );
  object.id = id;
  return object;
}

P _companyDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _companyGetId(Company object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _companyGetLinks(Company object) {
  return [];
}

void _companyAttach(IsarCollection<dynamic> col, Id id, Company object) {
  object.id = id;
}

extension CompanyQueryWhereSort on QueryBuilder<Company, Company, QWhere> {
  QueryBuilder<Company, Company, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CompanyQueryWhere on QueryBuilder<Company, Company, QWhereClause> {
  QueryBuilder<Company, Company, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Company, Company, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Company, Company, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Company, Company, QAfterWhereClause> idBetween(
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

extension CompanyQueryFilter
    on QueryBuilder<Company, Company, QFilterCondition> {
  QueryBuilder<Company, Company, QAfterFilterCondition> bsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'bs',
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> bsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'bs',
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> bsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bs',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> bsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bs',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> bsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bs',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> bsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> bsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bs',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> bsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bs',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> bsContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bs',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> bsMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bs',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> bsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bs',
        value: '',
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> bsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bs',
        value: '',
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> catchPhraseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'catchPhrase',
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> catchPhraseIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'catchPhrase',
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> catchPhraseEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'catchPhrase',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> catchPhraseGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'catchPhrase',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> catchPhraseLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'catchPhrase',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> catchPhraseBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'catchPhrase',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> catchPhraseStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'catchPhrase',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> catchPhraseEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'catchPhrase',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> catchPhraseContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'catchPhrase',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> catchPhraseMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'catchPhrase',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> catchPhraseIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'catchPhrase',
        value: '',
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition>
      catchPhraseIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'catchPhrase',
        value: '',
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Company, Company, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Company, Company, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Company, Company, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Company, Company, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension CompanyQueryObject
    on QueryBuilder<Company, Company, QFilterCondition> {}

extension CompanyQueryLinks
    on QueryBuilder<Company, Company, QFilterCondition> {}

extension CompanyQuerySortBy on QueryBuilder<Company, Company, QSortBy> {
  QueryBuilder<Company, Company, QAfterSortBy> sortByBs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bs', Sort.asc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> sortByBsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bs', Sort.desc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> sortByCatchPhrase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'catchPhrase', Sort.asc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> sortByCatchPhraseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'catchPhrase', Sort.desc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension CompanyQuerySortThenBy
    on QueryBuilder<Company, Company, QSortThenBy> {
  QueryBuilder<Company, Company, QAfterSortBy> thenByBs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bs', Sort.asc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> thenByBsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bs', Sort.desc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> thenByCatchPhrase() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'catchPhrase', Sort.asc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> thenByCatchPhraseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'catchPhrase', Sort.desc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Company, Company, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension CompanyQueryWhereDistinct
    on QueryBuilder<Company, Company, QDistinct> {
  QueryBuilder<Company, Company, QDistinct> distinctByBs(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bs', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Company, Company, QDistinct> distinctByCatchPhrase(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'catchPhrase', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Company, Company, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension CompanyQueryProperty
    on QueryBuilder<Company, Company, QQueryProperty> {
  QueryBuilder<Company, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Company, String?, QQueryOperations> bsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bs');
    });
  }

  QueryBuilder<Company, String?, QQueryOperations> catchPhraseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'catchPhrase');
    });
  }

  QueryBuilder<Company, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }
}
