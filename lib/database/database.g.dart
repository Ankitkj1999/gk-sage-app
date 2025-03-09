// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CategoriesTableTable extends CategoriesTable
    with TableInfo<$CategoriesTableTable, CategoriesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _thumbnailUrlMeta =
      const VerificationMeta('thumbnailUrl');
  @override
  late final GeneratedColumn<String> thumbnailUrl = GeneratedColumn<String>(
      'image_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _quizCountMeta =
      const VerificationMeta('quizCount');
  @override
  late final GeneratedColumn<int> quizCount = GeneratedColumn<int>(
      'quiz_count', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _featuredMeta =
      const VerificationMeta('featured');
  @override
  late final GeneratedColumn<bool> featured = GeneratedColumn<bool>(
      'featured', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("featured" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, thumbnailUrl, quizCount, featured];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<CategoriesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('image_url')) {
      context.handle(
          _thumbnailUrlMeta,
          thumbnailUrl.isAcceptableOrUnknown(
              data['image_url']!, _thumbnailUrlMeta));
    }
    if (data.containsKey('quiz_count')) {
      context.handle(_quizCountMeta,
          quizCount.isAcceptableOrUnknown(data['quiz_count']!, _quizCountMeta));
    }
    if (data.containsKey('featured')) {
      context.handle(_featuredMeta,
          featured.isAcceptableOrUnknown(data['featured']!, _featuredMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoriesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoriesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      thumbnailUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url']),
      quizCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quiz_count']),
      featured: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}featured']),
    );
  }

  @override
  $CategoriesTableTable createAlias(String alias) {
    return $CategoriesTableTable(attachedDatabase, alias);
  }
}

class CategoriesTableData extends DataClass
    implements Insertable<CategoriesTableData> {
  final String id;
  final String? name;
  final String? thumbnailUrl;
  final int? quizCount;
  final bool? featured;
  const CategoriesTableData(
      {required this.id,
      this.name,
      this.thumbnailUrl,
      this.quizCount,
      this.featured});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || thumbnailUrl != null) {
      map['image_url'] = Variable<String>(thumbnailUrl);
    }
    if (!nullToAbsent || quizCount != null) {
      map['quiz_count'] = Variable<int>(quizCount);
    }
    if (!nullToAbsent || featured != null) {
      map['featured'] = Variable<bool>(featured);
    }
    return map;
  }

  CategoriesTableCompanion toCompanion(bool nullToAbsent) {
    return CategoriesTableCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      thumbnailUrl: thumbnailUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbnailUrl),
      quizCount: quizCount == null && nullToAbsent
          ? const Value.absent()
          : Value(quizCount),
      featured: featured == null && nullToAbsent
          ? const Value.absent()
          : Value(featured),
    );
  }

  factory CategoriesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoriesTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      thumbnailUrl: serializer.fromJson<String?>(json['thumbnailUrl']),
      quizCount: serializer.fromJson<int?>(json['quizCount']),
      featured: serializer.fromJson<bool?>(json['featured']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String?>(name),
      'thumbnailUrl': serializer.toJson<String?>(thumbnailUrl),
      'quizCount': serializer.toJson<int?>(quizCount),
      'featured': serializer.toJson<bool?>(featured),
    };
  }

  CategoriesTableData copyWith(
          {String? id,
          Value<String?> name = const Value.absent(),
          Value<String?> thumbnailUrl = const Value.absent(),
          Value<int?> quizCount = const Value.absent(),
          Value<bool?> featured = const Value.absent()}) =>
      CategoriesTableData(
        id: id ?? this.id,
        name: name.present ? name.value : this.name,
        thumbnailUrl:
            thumbnailUrl.present ? thumbnailUrl.value : this.thumbnailUrl,
        quizCount: quizCount.present ? quizCount.value : this.quizCount,
        featured: featured.present ? featured.value : this.featured,
      );
  CategoriesTableData copyWithCompanion(CategoriesTableCompanion data) {
    return CategoriesTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      thumbnailUrl: data.thumbnailUrl.present
          ? data.thumbnailUrl.value
          : this.thumbnailUrl,
      quizCount: data.quizCount.present ? data.quizCount.value : this.quizCount,
      featured: data.featured.present ? data.featured.value : this.featured,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('thumbnailUrl: $thumbnailUrl, ')
          ..write('quizCount: $quizCount, ')
          ..write('featured: $featured')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, thumbnailUrl, quizCount, featured);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoriesTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.thumbnailUrl == this.thumbnailUrl &&
          other.quizCount == this.quizCount &&
          other.featured == this.featured);
}

class CategoriesTableCompanion extends UpdateCompanion<CategoriesTableData> {
  final Value<String> id;
  final Value<String?> name;
  final Value<String?> thumbnailUrl;
  final Value<int?> quizCount;
  final Value<bool?> featured;
  final Value<int> rowid;
  const CategoriesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.thumbnailUrl = const Value.absent(),
    this.quizCount = const Value.absent(),
    this.featured = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesTableCompanion.insert({
    required String id,
    this.name = const Value.absent(),
    this.thumbnailUrl = const Value.absent(),
    this.quizCount = const Value.absent(),
    this.featured = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<CategoriesTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? thumbnailUrl,
    Expression<int>? quizCount,
    Expression<bool>? featured,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (thumbnailUrl != null) 'image_url': thumbnailUrl,
      if (quizCount != null) 'quiz_count': quizCount,
      if (featured != null) 'featured': featured,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesTableCompanion copyWith(
      {Value<String>? id,
      Value<String?>? name,
      Value<String?>? thumbnailUrl,
      Value<int?>? quizCount,
      Value<bool?>? featured,
      Value<int>? rowid}) {
    return CategoriesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      quizCount: quizCount ?? this.quizCount,
      featured: featured ?? this.featured,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (thumbnailUrl.present) {
      map['image_url'] = Variable<String>(thumbnailUrl.value);
    }
    if (quizCount.present) {
      map['quiz_count'] = Variable<int>(quizCount.value);
    }
    if (featured.present) {
      map['featured'] = Variable<bool>(featured.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('thumbnailUrl: $thumbnailUrl, ')
          ..write('quizCount: $quizCount, ')
          ..write('featured: $featured, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuizzesTableTable extends QuizzesTable
    with TableInfo<$QuizzesTableTable, QuizzesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuizzesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _thumbnailUrlMeta =
      const VerificationMeta('thumbnailUrl');
  @override
  late final GeneratedColumn<String> thumbnailUrl = GeneratedColumn<String>(
      'image_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _parentIdMeta =
      const VerificationMeta('parentId');
  @override
  late final GeneratedColumn<String> parentId = GeneratedColumn<String>(
      'parent_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES categories_table (id)'));
  static const VerificationMeta _timerMeta = const VerificationMeta('timer');
  @override
  late final GeneratedColumn<bool> timer = GeneratedColumn<bool>(
      'timer', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("timer" IN (0, 1))'));
  static const VerificationMeta _quizTimeMeta =
      const VerificationMeta('quizTime');
  @override
  late final GeneratedColumn<int> quizTime = GeneratedColumn<int>(
      'quiz_time', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _questionCountMeta =
      const VerificationMeta('questionCount');
  @override
  late final GeneratedColumn<int> questionCount = GeneratedColumn<int>(
      'question_count', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _pointsRequiredMeta =
      const VerificationMeta('pointsRequired');
  @override
  late final GeneratedColumn<int> pointsRequired = GeneratedColumn<int>(
      'points_required', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _questionOrderMeta =
      const VerificationMeta('questionOrder');
  @override
  late final GeneratedColumn<String> questionOrder = GeneratedColumn<String>(
      'question_order', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _indexMeta = const VerificationMeta('index');
  @override
  late final GeneratedColumn<int> index = GeneratedColumn<int>(
      'index', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        thumbnailUrl,
        parentId,
        timer,
        quizTime,
        description,
        questionCount,
        pointsRequired,
        questionOrder,
        index
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quizzes_table';
  @override
  VerificationContext validateIntegrity(Insertable<QuizzesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('image_url')) {
      context.handle(
          _thumbnailUrlMeta,
          thumbnailUrl.isAcceptableOrUnknown(
              data['image_url']!, _thumbnailUrlMeta));
    }
    if (data.containsKey('parent_id')) {
      context.handle(_parentIdMeta,
          parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta));
    }
    if (data.containsKey('timer')) {
      context.handle(
          _timerMeta, timer.isAcceptableOrUnknown(data['timer']!, _timerMeta));
    }
    if (data.containsKey('quiz_time')) {
      context.handle(_quizTimeMeta,
          quizTime.isAcceptableOrUnknown(data['quiz_time']!, _quizTimeMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('question_count')) {
      context.handle(
          _questionCountMeta,
          questionCount.isAcceptableOrUnknown(
              data['question_count']!, _questionCountMeta));
    }
    if (data.containsKey('points_required')) {
      context.handle(
          _pointsRequiredMeta,
          pointsRequired.isAcceptableOrUnknown(
              data['points_required']!, _pointsRequiredMeta));
    }
    if (data.containsKey('question_order')) {
      context.handle(
          _questionOrderMeta,
          questionOrder.isAcceptableOrUnknown(
              data['question_order']!, _questionOrderMeta));
    }
    if (data.containsKey('index')) {
      context.handle(
          _indexMeta, index.isAcceptableOrUnknown(data['index']!, _indexMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuizzesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuizzesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      thumbnailUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url']),
      parentId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}parent_id']),
      timer: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}timer']),
      quizTime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quiz_time']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      questionCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}question_count']),
      pointsRequired: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}points_required']),
      questionOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}question_order']),
      index: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}index']),
    );
  }

  @override
  $QuizzesTableTable createAlias(String alias) {
    return $QuizzesTableTable(attachedDatabase, alias);
  }
}

class QuizzesTableData extends DataClass
    implements Insertable<QuizzesTableData> {
  final String? id;
  final String? name;
  final String? thumbnailUrl;
  final String? parentId;
  final bool? timer;
  final int? quizTime;
  final String? description;
  final int? questionCount;
  final int? pointsRequired;
  final String? questionOrder;
  final int? index;
  const QuizzesTableData(
      {this.id,
      this.name,
      this.thumbnailUrl,
      this.parentId,
      this.timer,
      this.quizTime,
      this.description,
      this.questionCount,
      this.pointsRequired,
      this.questionOrder,
      this.index});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || thumbnailUrl != null) {
      map['image_url'] = Variable<String>(thumbnailUrl);
    }
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<String>(parentId);
    }
    if (!nullToAbsent || timer != null) {
      map['timer'] = Variable<bool>(timer);
    }
    if (!nullToAbsent || quizTime != null) {
      map['quiz_time'] = Variable<int>(quizTime);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || questionCount != null) {
      map['question_count'] = Variable<int>(questionCount);
    }
    if (!nullToAbsent || pointsRequired != null) {
      map['points_required'] = Variable<int>(pointsRequired);
    }
    if (!nullToAbsent || questionOrder != null) {
      map['question_order'] = Variable<String>(questionOrder);
    }
    if (!nullToAbsent || index != null) {
      map['index'] = Variable<int>(index);
    }
    return map;
  }

  QuizzesTableCompanion toCompanion(bool nullToAbsent) {
    return QuizzesTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      thumbnailUrl: thumbnailUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbnailUrl),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      timer:
          timer == null && nullToAbsent ? const Value.absent() : Value(timer),
      quizTime: quizTime == null && nullToAbsent
          ? const Value.absent()
          : Value(quizTime),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      questionCount: questionCount == null && nullToAbsent
          ? const Value.absent()
          : Value(questionCount),
      pointsRequired: pointsRequired == null && nullToAbsent
          ? const Value.absent()
          : Value(pointsRequired),
      questionOrder: questionOrder == null && nullToAbsent
          ? const Value.absent()
          : Value(questionOrder),
      index:
          index == null && nullToAbsent ? const Value.absent() : Value(index),
    );
  }

  factory QuizzesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuizzesTableData(
      id: serializer.fromJson<String?>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      thumbnailUrl: serializer.fromJson<String?>(json['thumbnailUrl']),
      parentId: serializer.fromJson<String?>(json['parentId']),
      timer: serializer.fromJson<bool?>(json['timer']),
      quizTime: serializer.fromJson<int?>(json['quizTime']),
      description: serializer.fromJson<String?>(json['description']),
      questionCount: serializer.fromJson<int?>(json['questionCount']),
      pointsRequired: serializer.fromJson<int?>(json['pointsRequired']),
      questionOrder: serializer.fromJson<String?>(json['questionOrder']),
      index: serializer.fromJson<int?>(json['index']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String?>(id),
      'name': serializer.toJson<String?>(name),
      'thumbnailUrl': serializer.toJson<String?>(thumbnailUrl),
      'parentId': serializer.toJson<String?>(parentId),
      'timer': serializer.toJson<bool?>(timer),
      'quizTime': serializer.toJson<int?>(quizTime),
      'description': serializer.toJson<String?>(description),
      'questionCount': serializer.toJson<int?>(questionCount),
      'pointsRequired': serializer.toJson<int?>(pointsRequired),
      'questionOrder': serializer.toJson<String?>(questionOrder),
      'index': serializer.toJson<int?>(index),
    };
  }

  QuizzesTableData copyWith(
          {Value<String?> id = const Value.absent(),
          Value<String?> name = const Value.absent(),
          Value<String?> thumbnailUrl = const Value.absent(),
          Value<String?> parentId = const Value.absent(),
          Value<bool?> timer = const Value.absent(),
          Value<int?> quizTime = const Value.absent(),
          Value<String?> description = const Value.absent(),
          Value<int?> questionCount = const Value.absent(),
          Value<int?> pointsRequired = const Value.absent(),
          Value<String?> questionOrder = const Value.absent(),
          Value<int?> index = const Value.absent()}) =>
      QuizzesTableData(
        id: id.present ? id.value : this.id,
        name: name.present ? name.value : this.name,
        thumbnailUrl:
            thumbnailUrl.present ? thumbnailUrl.value : this.thumbnailUrl,
        parentId: parentId.present ? parentId.value : this.parentId,
        timer: timer.present ? timer.value : this.timer,
        quizTime: quizTime.present ? quizTime.value : this.quizTime,
        description: description.present ? description.value : this.description,
        questionCount:
            questionCount.present ? questionCount.value : this.questionCount,
        pointsRequired:
            pointsRequired.present ? pointsRequired.value : this.pointsRequired,
        questionOrder:
            questionOrder.present ? questionOrder.value : this.questionOrder,
        index: index.present ? index.value : this.index,
      );
  QuizzesTableData copyWithCompanion(QuizzesTableCompanion data) {
    return QuizzesTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      thumbnailUrl: data.thumbnailUrl.present
          ? data.thumbnailUrl.value
          : this.thumbnailUrl,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      timer: data.timer.present ? data.timer.value : this.timer,
      quizTime: data.quizTime.present ? data.quizTime.value : this.quizTime,
      description:
          data.description.present ? data.description.value : this.description,
      questionCount: data.questionCount.present
          ? data.questionCount.value
          : this.questionCount,
      pointsRequired: data.pointsRequired.present
          ? data.pointsRequired.value
          : this.pointsRequired,
      questionOrder: data.questionOrder.present
          ? data.questionOrder.value
          : this.questionOrder,
      index: data.index.present ? data.index.value : this.index,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuizzesTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('thumbnailUrl: $thumbnailUrl, ')
          ..write('parentId: $parentId, ')
          ..write('timer: $timer, ')
          ..write('quizTime: $quizTime, ')
          ..write('description: $description, ')
          ..write('questionCount: $questionCount, ')
          ..write('pointsRequired: $pointsRequired, ')
          ..write('questionOrder: $questionOrder, ')
          ..write('index: $index')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      thumbnailUrl,
      parentId,
      timer,
      quizTime,
      description,
      questionCount,
      pointsRequired,
      questionOrder,
      index);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuizzesTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.thumbnailUrl == this.thumbnailUrl &&
          other.parentId == this.parentId &&
          other.timer == this.timer &&
          other.quizTime == this.quizTime &&
          other.description == this.description &&
          other.questionCount == this.questionCount &&
          other.pointsRequired == this.pointsRequired &&
          other.questionOrder == this.questionOrder &&
          other.index == this.index);
}

class QuizzesTableCompanion extends UpdateCompanion<QuizzesTableData> {
  final Value<String?> id;
  final Value<String?> name;
  final Value<String?> thumbnailUrl;
  final Value<String?> parentId;
  final Value<bool?> timer;
  final Value<int?> quizTime;
  final Value<String?> description;
  final Value<int?> questionCount;
  final Value<int?> pointsRequired;
  final Value<String?> questionOrder;
  final Value<int?> index;
  final Value<int> rowid;
  const QuizzesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.thumbnailUrl = const Value.absent(),
    this.parentId = const Value.absent(),
    this.timer = const Value.absent(),
    this.quizTime = const Value.absent(),
    this.description = const Value.absent(),
    this.questionCount = const Value.absent(),
    this.pointsRequired = const Value.absent(),
    this.questionOrder = const Value.absent(),
    this.index = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuizzesTableCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.thumbnailUrl = const Value.absent(),
    this.parentId = const Value.absent(),
    this.timer = const Value.absent(),
    this.quizTime = const Value.absent(),
    this.description = const Value.absent(),
    this.questionCount = const Value.absent(),
    this.pointsRequired = const Value.absent(),
    this.questionOrder = const Value.absent(),
    this.index = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  static Insertable<QuizzesTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? thumbnailUrl,
    Expression<String>? parentId,
    Expression<bool>? timer,
    Expression<int>? quizTime,
    Expression<String>? description,
    Expression<int>? questionCount,
    Expression<int>? pointsRequired,
    Expression<String>? questionOrder,
    Expression<int>? index,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (thumbnailUrl != null) 'image_url': thumbnailUrl,
      if (parentId != null) 'parent_id': parentId,
      if (timer != null) 'timer': timer,
      if (quizTime != null) 'quiz_time': quizTime,
      if (description != null) 'description': description,
      if (questionCount != null) 'question_count': questionCount,
      if (pointsRequired != null) 'points_required': pointsRequired,
      if (questionOrder != null) 'question_order': questionOrder,
      if (index != null) 'index': index,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuizzesTableCompanion copyWith(
      {Value<String?>? id,
      Value<String?>? name,
      Value<String?>? thumbnailUrl,
      Value<String?>? parentId,
      Value<bool?>? timer,
      Value<int?>? quizTime,
      Value<String?>? description,
      Value<int?>? questionCount,
      Value<int?>? pointsRequired,
      Value<String?>? questionOrder,
      Value<int?>? index,
      Value<int>? rowid}) {
    return QuizzesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      parentId: parentId ?? this.parentId,
      timer: timer ?? this.timer,
      quizTime: quizTime ?? this.quizTime,
      description: description ?? this.description,
      questionCount: questionCount ?? this.questionCount,
      pointsRequired: pointsRequired ?? this.pointsRequired,
      questionOrder: questionOrder ?? this.questionOrder,
      index: index ?? this.index,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (thumbnailUrl.present) {
      map['image_url'] = Variable<String>(thumbnailUrl.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<String>(parentId.value);
    }
    if (timer.present) {
      map['timer'] = Variable<bool>(timer.value);
    }
    if (quizTime.present) {
      map['quiz_time'] = Variable<int>(quizTime.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (questionCount.present) {
      map['question_count'] = Variable<int>(questionCount.value);
    }
    if (pointsRequired.present) {
      map['points_required'] = Variable<int>(pointsRequired.value);
    }
    if (questionOrder.present) {
      map['question_order'] = Variable<String>(questionOrder.value);
    }
    if (index.present) {
      map['index'] = Variable<int>(index.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuizzesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('thumbnailUrl: $thumbnailUrl, ')
          ..write('parentId: $parentId, ')
          ..write('timer: $timer, ')
          ..write('quizTime: $quizTime, ')
          ..write('description: $description, ')
          ..write('questionCount: $questionCount, ')
          ..write('pointsRequired: $pointsRequired, ')
          ..write('questionOrder: $questionOrder, ')
          ..write('index: $index, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$QuizDatabase extends GeneratedDatabase {
  _$QuizDatabase(QueryExecutor e) : super(e);
  $QuizDatabaseManager get managers => $QuizDatabaseManager(this);
  late final $CategoriesTableTable categoriesTable =
      $CategoriesTableTable(this);
  late final $QuizzesTableTable quizzesTable = $QuizzesTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [categoriesTable, quizzesTable];
}

typedef $$CategoriesTableTableCreateCompanionBuilder = CategoriesTableCompanion
    Function({
  required String id,
  Value<String?> name,
  Value<String?> thumbnailUrl,
  Value<int?> quizCount,
  Value<bool?> featured,
  Value<int> rowid,
});
typedef $$CategoriesTableTableUpdateCompanionBuilder = CategoriesTableCompanion
    Function({
  Value<String> id,
  Value<String?> name,
  Value<String?> thumbnailUrl,
  Value<int?> quizCount,
  Value<bool?> featured,
  Value<int> rowid,
});

class $$CategoriesTableTableTableManager extends RootTableManager<
    _$QuizDatabase,
    $CategoriesTableTable,
    CategoriesTableData,
    $$CategoriesTableTableFilterComposer,
    $$CategoriesTableTableOrderingComposer,
    $$CategoriesTableTableCreateCompanionBuilder,
    $$CategoriesTableTableUpdateCompanionBuilder> {
  $$CategoriesTableTableTableManager(
      _$QuizDatabase db, $CategoriesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$CategoriesTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$CategoriesTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String?> thumbnailUrl = const Value.absent(),
            Value<int?> quizCount = const Value.absent(),
            Value<bool?> featured = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CategoriesTableCompanion(
            id: id,
            name: name,
            thumbnailUrl: thumbnailUrl,
            quizCount: quizCount,
            featured: featured,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> name = const Value.absent(),
            Value<String?> thumbnailUrl = const Value.absent(),
            Value<int?> quizCount = const Value.absent(),
            Value<bool?> featured = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CategoriesTableCompanion.insert(
            id: id,
            name: name,
            thumbnailUrl: thumbnailUrl,
            quizCount: quizCount,
            featured: featured,
            rowid: rowid,
          ),
        ));
}

class $$CategoriesTableTableFilterComposer
    extends FilterComposer<_$QuizDatabase, $CategoriesTableTable> {
  $$CategoriesTableTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get thumbnailUrl => $state.composableBuilder(
      column: $state.table.thumbnailUrl,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get quizCount => $state.composableBuilder(
      column: $state.table.quizCount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get featured => $state.composableBuilder(
      column: $state.table.featured,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter quizzesTableRefs(
      ComposableFilter Function($$QuizzesTableTableFilterComposer f) f) {
    final $$QuizzesTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.quizzesTable,
        getReferencedColumn: (t) => t.parentId,
        builder: (joinBuilder, parentComposers) =>
            $$QuizzesTableTableFilterComposer(ComposerState($state.db,
                $state.db.quizzesTable, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$CategoriesTableTableOrderingComposer
    extends OrderingComposer<_$QuizDatabase, $CategoriesTableTable> {
  $$CategoriesTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get thumbnailUrl => $state.composableBuilder(
      column: $state.table.thumbnailUrl,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get quizCount => $state.composableBuilder(
      column: $state.table.quizCount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get featured => $state.composableBuilder(
      column: $state.table.featured,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$QuizzesTableTableCreateCompanionBuilder = QuizzesTableCompanion
    Function({
  Value<String?> id,
  Value<String?> name,
  Value<String?> thumbnailUrl,
  Value<String?> parentId,
  Value<bool?> timer,
  Value<int?> quizTime,
  Value<String?> description,
  Value<int?> questionCount,
  Value<int?> pointsRequired,
  Value<String?> questionOrder,
  Value<int?> index,
  Value<int> rowid,
});
typedef $$QuizzesTableTableUpdateCompanionBuilder = QuizzesTableCompanion
    Function({
  Value<String?> id,
  Value<String?> name,
  Value<String?> thumbnailUrl,
  Value<String?> parentId,
  Value<bool?> timer,
  Value<int?> quizTime,
  Value<String?> description,
  Value<int?> questionCount,
  Value<int?> pointsRequired,
  Value<String?> questionOrder,
  Value<int?> index,
  Value<int> rowid,
});

class $$QuizzesTableTableTableManager extends RootTableManager<
    _$QuizDatabase,
    $QuizzesTableTable,
    QuizzesTableData,
    $$QuizzesTableTableFilterComposer,
    $$QuizzesTableTableOrderingComposer,
    $$QuizzesTableTableCreateCompanionBuilder,
    $$QuizzesTableTableUpdateCompanionBuilder> {
  $$QuizzesTableTableTableManager(_$QuizDatabase db, $QuizzesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$QuizzesTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$QuizzesTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String?> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String?> thumbnailUrl = const Value.absent(),
            Value<String?> parentId = const Value.absent(),
            Value<bool?> timer = const Value.absent(),
            Value<int?> quizTime = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<int?> questionCount = const Value.absent(),
            Value<int?> pointsRequired = const Value.absent(),
            Value<String?> questionOrder = const Value.absent(),
            Value<int?> index = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              QuizzesTableCompanion(
            id: id,
            name: name,
            thumbnailUrl: thumbnailUrl,
            parentId: parentId,
            timer: timer,
            quizTime: quizTime,
            description: description,
            questionCount: questionCount,
            pointsRequired: pointsRequired,
            questionOrder: questionOrder,
            index: index,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<String?> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String?> thumbnailUrl = const Value.absent(),
            Value<String?> parentId = const Value.absent(),
            Value<bool?> timer = const Value.absent(),
            Value<int?> quizTime = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<int?> questionCount = const Value.absent(),
            Value<int?> pointsRequired = const Value.absent(),
            Value<String?> questionOrder = const Value.absent(),
            Value<int?> index = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              QuizzesTableCompanion.insert(
            id: id,
            name: name,
            thumbnailUrl: thumbnailUrl,
            parentId: parentId,
            timer: timer,
            quizTime: quizTime,
            description: description,
            questionCount: questionCount,
            pointsRequired: pointsRequired,
            questionOrder: questionOrder,
            index: index,
            rowid: rowid,
          ),
        ));
}

class $$QuizzesTableTableFilterComposer
    extends FilterComposer<_$QuizDatabase, $QuizzesTableTable> {
  $$QuizzesTableTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get thumbnailUrl => $state.composableBuilder(
      column: $state.table.thumbnailUrl,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get timer => $state.composableBuilder(
      column: $state.table.timer,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get quizTime => $state.composableBuilder(
      column: $state.table.quizTime,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get questionCount => $state.composableBuilder(
      column: $state.table.questionCount,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get pointsRequired => $state.composableBuilder(
      column: $state.table.pointsRequired,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get questionOrder => $state.composableBuilder(
      column: $state.table.questionOrder,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get index => $state.composableBuilder(
      column: $state.table.index,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$CategoriesTableTableFilterComposer get parentId {
    final $$CategoriesTableTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.parentId,
            referencedTable: $state.db.categoriesTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$CategoriesTableTableFilterComposer(ComposerState($state.db,
                    $state.db.categoriesTable, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$QuizzesTableTableOrderingComposer
    extends OrderingComposer<_$QuizDatabase, $QuizzesTableTable> {
  $$QuizzesTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get thumbnailUrl => $state.composableBuilder(
      column: $state.table.thumbnailUrl,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get timer => $state.composableBuilder(
      column: $state.table.timer,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get quizTime => $state.composableBuilder(
      column: $state.table.quizTime,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get description => $state.composableBuilder(
      column: $state.table.description,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get questionCount => $state.composableBuilder(
      column: $state.table.questionCount,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get pointsRequired => $state.composableBuilder(
      column: $state.table.pointsRequired,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get questionOrder => $state.composableBuilder(
      column: $state.table.questionOrder,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get index => $state.composableBuilder(
      column: $state.table.index,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$CategoriesTableTableOrderingComposer get parentId {
    final $$CategoriesTableTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.parentId,
            referencedTable: $state.db.categoriesTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder, parentComposers) =>
                $$CategoriesTableTableOrderingComposer(ComposerState($state.db,
                    $state.db.categoriesTable, joinBuilder, parentComposers)));
    return composer;
  }
}

class $QuizDatabaseManager {
  final _$QuizDatabase _db;
  $QuizDatabaseManager(this._db);
  $$CategoriesTableTableTableManager get categoriesTable =>
      $$CategoriesTableTableTableManager(_db, _db.categoriesTable);
  $$QuizzesTableTableTableManager get quizzesTable =>
      $$QuizzesTableTableTableManager(_db, _db.quizzesTable);
}
