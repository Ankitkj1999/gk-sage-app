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

class $QuestionsTableTable extends QuestionsTable
    with TableInfo<$QuestionsTableTable, QuestionsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _quizIdMeta = const VerificationMeta('quizId');
  @override
  late final GeneratedColumn<String> quizId = GeneratedColumn<String>(
      'quiz_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES quizzes_table (id)'));
  static const VerificationMeta _catIdMeta = const VerificationMeta('catId');
  @override
  late final GeneratedColumn<String> catId = GeneratedColumn<String>(
      'cat_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _questionTitleMeta =
      const VerificationMeta('questionTitle');
  @override
  late final GeneratedColumn<String> questionTitle = GeneratedColumn<String>(
      'question_title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _optionsMeta =
      const VerificationMeta('options');
  @override
  late final GeneratedColumn<String> options = GeneratedColumn<String>(
      'options', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _correctAnswerIndexMeta =
      const VerificationMeta('correctAnswerIndex');
  @override
  late final GeneratedColumn<int> correctAnswerIndex = GeneratedColumn<int>(
      'correct_answer_index', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _hasFourOptionsMeta =
      const VerificationMeta('hasFourOptions');
  @override
  late final GeneratedColumn<bool> hasFourOptions = GeneratedColumn<bool>(
      'has_four_options', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("has_four_options" IN (0, 1))'));
  static const VerificationMeta _questionTypeMeta =
      const VerificationMeta('questionType');
  @override
  late final GeneratedColumn<String> questionType = GeneratedColumn<String>(
      'question_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _questionImageUrlMeta =
      const VerificationMeta('questionImageUrl');
  @override
  late final GeneratedColumn<String> questionImageUrl = GeneratedColumn<String>(
      'question_image_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _questionAudioUrlMeta =
      const VerificationMeta('questionAudioUrl');
  @override
  late final GeneratedColumn<String> questionAudioUrl = GeneratedColumn<String>(
      'question_audio_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _questionVideoUrlMeta =
      const VerificationMeta('questionVideoUrl');
  @override
  late final GeneratedColumn<String> questionVideoUrl = GeneratedColumn<String>(
      'question_video_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _explainationMeta =
      const VerificationMeta('explaination');
  @override
  late final GeneratedColumn<String> explaination = GeneratedColumn<String>(
      'explaination', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _optionsTypeMeta =
      const VerificationMeta('optionsType');
  @override
  late final GeneratedColumn<String> optionsType = GeneratedColumn<String>(
      'options_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        quizId,
        catId,
        questionTitle,
        options,
        correctAnswerIndex,
        hasFourOptions,
        questionType,
        questionImageUrl,
        questionAudioUrl,
        questionVideoUrl,
        explaination,
        optionsType,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'questions_table';
  @override
  VerificationContext validateIntegrity(Insertable<QuestionsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('quiz_id')) {
      context.handle(_quizIdMeta,
          quizId.isAcceptableOrUnknown(data['quiz_id']!, _quizIdMeta));
    } else if (isInserting) {
      context.missing(_quizIdMeta);
    }
    if (data.containsKey('cat_id')) {
      context.handle(
          _catIdMeta, catId.isAcceptableOrUnknown(data['cat_id']!, _catIdMeta));
    }
    if (data.containsKey('question_title')) {
      context.handle(
          _questionTitleMeta,
          questionTitle.isAcceptableOrUnknown(
              data['question_title']!, _questionTitleMeta));
    }
    if (data.containsKey('options')) {
      context.handle(_optionsMeta,
          options.isAcceptableOrUnknown(data['options']!, _optionsMeta));
    }
    if (data.containsKey('correct_answer_index')) {
      context.handle(
          _correctAnswerIndexMeta,
          correctAnswerIndex.isAcceptableOrUnknown(
              data['correct_answer_index']!, _correctAnswerIndexMeta));
    }
    if (data.containsKey('has_four_options')) {
      context.handle(
          _hasFourOptionsMeta,
          hasFourOptions.isAcceptableOrUnknown(
              data['has_four_options']!, _hasFourOptionsMeta));
    }
    if (data.containsKey('question_type')) {
      context.handle(
          _questionTypeMeta,
          questionType.isAcceptableOrUnknown(
              data['question_type']!, _questionTypeMeta));
    }
    if (data.containsKey('question_image_url')) {
      context.handle(
          _questionImageUrlMeta,
          questionImageUrl.isAcceptableOrUnknown(
              data['question_image_url']!, _questionImageUrlMeta));
    }
    if (data.containsKey('question_audio_url')) {
      context.handle(
          _questionAudioUrlMeta,
          questionAudioUrl.isAcceptableOrUnknown(
              data['question_audio_url']!, _questionAudioUrlMeta));
    }
    if (data.containsKey('question_video_url')) {
      context.handle(
          _questionVideoUrlMeta,
          questionVideoUrl.isAcceptableOrUnknown(
              data['question_video_url']!, _questionVideoUrlMeta));
    }
    if (data.containsKey('explaination')) {
      context.handle(
          _explainationMeta,
          explaination.isAcceptableOrUnknown(
              data['explaination']!, _explainationMeta));
    }
    if (data.containsKey('options_type')) {
      context.handle(
          _optionsTypeMeta,
          optionsType.isAcceptableOrUnknown(
              data['options_type']!, _optionsTypeMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuestionsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuestionsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      quizId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}quiz_id'])!,
      catId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cat_id']),
      questionTitle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}question_title']),
      options: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}options']),
      correctAnswerIndex: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}correct_answer_index']),
      hasFourOptions: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}has_four_options']),
      questionType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}question_type']),
      questionImageUrl: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}question_image_url']),
      questionAudioUrl: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}question_audio_url']),
      questionVideoUrl: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}question_video_url']),
      explaination: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}explaination']),
      optionsType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}options_type']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at']),
    );
  }

  @override
  $QuestionsTableTable createAlias(String alias) {
    return $QuestionsTableTable(attachedDatabase, alias);
  }
}

class QuestionsTableData extends DataClass
    implements Insertable<QuestionsTableData> {
  final String id;
  final String quizId;
  final String? catId;
  final String? questionTitle;
  final String? options;
  final int? correctAnswerIndex;
  final bool? hasFourOptions;
  final String? questionType;
  final String? questionImageUrl;
  final String? questionAudioUrl;
  final String? questionVideoUrl;
  final String? explaination;
  final String? optionsType;
  final int? createdAt;
  const QuestionsTableData(
      {required this.id,
      required this.quizId,
      this.catId,
      this.questionTitle,
      this.options,
      this.correctAnswerIndex,
      this.hasFourOptions,
      this.questionType,
      this.questionImageUrl,
      this.questionAudioUrl,
      this.questionVideoUrl,
      this.explaination,
      this.optionsType,
      this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['quiz_id'] = Variable<String>(quizId);
    if (!nullToAbsent || catId != null) {
      map['cat_id'] = Variable<String>(catId);
    }
    if (!nullToAbsent || questionTitle != null) {
      map['question_title'] = Variable<String>(questionTitle);
    }
    if (!nullToAbsent || options != null) {
      map['options'] = Variable<String>(options);
    }
    if (!nullToAbsent || correctAnswerIndex != null) {
      map['correct_answer_index'] = Variable<int>(correctAnswerIndex);
    }
    if (!nullToAbsent || hasFourOptions != null) {
      map['has_four_options'] = Variable<bool>(hasFourOptions);
    }
    if (!nullToAbsent || questionType != null) {
      map['question_type'] = Variable<String>(questionType);
    }
    if (!nullToAbsent || questionImageUrl != null) {
      map['question_image_url'] = Variable<String>(questionImageUrl);
    }
    if (!nullToAbsent || questionAudioUrl != null) {
      map['question_audio_url'] = Variable<String>(questionAudioUrl);
    }
    if (!nullToAbsent || questionVideoUrl != null) {
      map['question_video_url'] = Variable<String>(questionVideoUrl);
    }
    if (!nullToAbsent || explaination != null) {
      map['explaination'] = Variable<String>(explaination);
    }
    if (!nullToAbsent || optionsType != null) {
      map['options_type'] = Variable<String>(optionsType);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<int>(createdAt);
    }
    return map;
  }

  QuestionsTableCompanion toCompanion(bool nullToAbsent) {
    return QuestionsTableCompanion(
      id: Value(id),
      quizId: Value(quizId),
      catId:
          catId == null && nullToAbsent ? const Value.absent() : Value(catId),
      questionTitle: questionTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(questionTitle),
      options: options == null && nullToAbsent
          ? const Value.absent()
          : Value(options),
      correctAnswerIndex: correctAnswerIndex == null && nullToAbsent
          ? const Value.absent()
          : Value(correctAnswerIndex),
      hasFourOptions: hasFourOptions == null && nullToAbsent
          ? const Value.absent()
          : Value(hasFourOptions),
      questionType: questionType == null && nullToAbsent
          ? const Value.absent()
          : Value(questionType),
      questionImageUrl: questionImageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(questionImageUrl),
      questionAudioUrl: questionAudioUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(questionAudioUrl),
      questionVideoUrl: questionVideoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(questionVideoUrl),
      explaination: explaination == null && nullToAbsent
          ? const Value.absent()
          : Value(explaination),
      optionsType: optionsType == null && nullToAbsent
          ? const Value.absent()
          : Value(optionsType),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory QuestionsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuestionsTableData(
      id: serializer.fromJson<String>(json['id']),
      quizId: serializer.fromJson<String>(json['quizId']),
      catId: serializer.fromJson<String?>(json['catId']),
      questionTitle: serializer.fromJson<String?>(json['questionTitle']),
      options: serializer.fromJson<String?>(json['options']),
      correctAnswerIndex: serializer.fromJson<int?>(json['correctAnswerIndex']),
      hasFourOptions: serializer.fromJson<bool?>(json['hasFourOptions']),
      questionType: serializer.fromJson<String?>(json['questionType']),
      questionImageUrl: serializer.fromJson<String?>(json['questionImageUrl']),
      questionAudioUrl: serializer.fromJson<String?>(json['questionAudioUrl']),
      questionVideoUrl: serializer.fromJson<String?>(json['questionVideoUrl']),
      explaination: serializer.fromJson<String?>(json['explaination']),
      optionsType: serializer.fromJson<String?>(json['optionsType']),
      createdAt: serializer.fromJson<int?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'quizId': serializer.toJson<String>(quizId),
      'catId': serializer.toJson<String?>(catId),
      'questionTitle': serializer.toJson<String?>(questionTitle),
      'options': serializer.toJson<String?>(options),
      'correctAnswerIndex': serializer.toJson<int?>(correctAnswerIndex),
      'hasFourOptions': serializer.toJson<bool?>(hasFourOptions),
      'questionType': serializer.toJson<String?>(questionType),
      'questionImageUrl': serializer.toJson<String?>(questionImageUrl),
      'questionAudioUrl': serializer.toJson<String?>(questionAudioUrl),
      'questionVideoUrl': serializer.toJson<String?>(questionVideoUrl),
      'explaination': serializer.toJson<String?>(explaination),
      'optionsType': serializer.toJson<String?>(optionsType),
      'createdAt': serializer.toJson<int?>(createdAt),
    };
  }

  QuestionsTableData copyWith(
          {String? id,
          String? quizId,
          Value<String?> catId = const Value.absent(),
          Value<String?> questionTitle = const Value.absent(),
          Value<String?> options = const Value.absent(),
          Value<int?> correctAnswerIndex = const Value.absent(),
          Value<bool?> hasFourOptions = const Value.absent(),
          Value<String?> questionType = const Value.absent(),
          Value<String?> questionImageUrl = const Value.absent(),
          Value<String?> questionAudioUrl = const Value.absent(),
          Value<String?> questionVideoUrl = const Value.absent(),
          Value<String?> explaination = const Value.absent(),
          Value<String?> optionsType = const Value.absent(),
          Value<int?> createdAt = const Value.absent()}) =>
      QuestionsTableData(
        id: id ?? this.id,
        quizId: quizId ?? this.quizId,
        catId: catId.present ? catId.value : this.catId,
        questionTitle:
            questionTitle.present ? questionTitle.value : this.questionTitle,
        options: options.present ? options.value : this.options,
        correctAnswerIndex: correctAnswerIndex.present
            ? correctAnswerIndex.value
            : this.correctAnswerIndex,
        hasFourOptions:
            hasFourOptions.present ? hasFourOptions.value : this.hasFourOptions,
        questionType:
            questionType.present ? questionType.value : this.questionType,
        questionImageUrl: questionImageUrl.present
            ? questionImageUrl.value
            : this.questionImageUrl,
        questionAudioUrl: questionAudioUrl.present
            ? questionAudioUrl.value
            : this.questionAudioUrl,
        questionVideoUrl: questionVideoUrl.present
            ? questionVideoUrl.value
            : this.questionVideoUrl,
        explaination:
            explaination.present ? explaination.value : this.explaination,
        optionsType: optionsType.present ? optionsType.value : this.optionsType,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
      );
  QuestionsTableData copyWithCompanion(QuestionsTableCompanion data) {
    return QuestionsTableData(
      id: data.id.present ? data.id.value : this.id,
      quizId: data.quizId.present ? data.quizId.value : this.quizId,
      catId: data.catId.present ? data.catId.value : this.catId,
      questionTitle: data.questionTitle.present
          ? data.questionTitle.value
          : this.questionTitle,
      options: data.options.present ? data.options.value : this.options,
      correctAnswerIndex: data.correctAnswerIndex.present
          ? data.correctAnswerIndex.value
          : this.correctAnswerIndex,
      hasFourOptions: data.hasFourOptions.present
          ? data.hasFourOptions.value
          : this.hasFourOptions,
      questionType: data.questionType.present
          ? data.questionType.value
          : this.questionType,
      questionImageUrl: data.questionImageUrl.present
          ? data.questionImageUrl.value
          : this.questionImageUrl,
      questionAudioUrl: data.questionAudioUrl.present
          ? data.questionAudioUrl.value
          : this.questionAudioUrl,
      questionVideoUrl: data.questionVideoUrl.present
          ? data.questionVideoUrl.value
          : this.questionVideoUrl,
      explaination: data.explaination.present
          ? data.explaination.value
          : this.explaination,
      optionsType:
          data.optionsType.present ? data.optionsType.value : this.optionsType,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuestionsTableData(')
          ..write('id: $id, ')
          ..write('quizId: $quizId, ')
          ..write('catId: $catId, ')
          ..write('questionTitle: $questionTitle, ')
          ..write('options: $options, ')
          ..write('correctAnswerIndex: $correctAnswerIndex, ')
          ..write('hasFourOptions: $hasFourOptions, ')
          ..write('questionType: $questionType, ')
          ..write('questionImageUrl: $questionImageUrl, ')
          ..write('questionAudioUrl: $questionAudioUrl, ')
          ..write('questionVideoUrl: $questionVideoUrl, ')
          ..write('explaination: $explaination, ')
          ..write('optionsType: $optionsType, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      quizId,
      catId,
      questionTitle,
      options,
      correctAnswerIndex,
      hasFourOptions,
      questionType,
      questionImageUrl,
      questionAudioUrl,
      questionVideoUrl,
      explaination,
      optionsType,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuestionsTableData &&
          other.id == this.id &&
          other.quizId == this.quizId &&
          other.catId == this.catId &&
          other.questionTitle == this.questionTitle &&
          other.options == this.options &&
          other.correctAnswerIndex == this.correctAnswerIndex &&
          other.hasFourOptions == this.hasFourOptions &&
          other.questionType == this.questionType &&
          other.questionImageUrl == this.questionImageUrl &&
          other.questionAudioUrl == this.questionAudioUrl &&
          other.questionVideoUrl == this.questionVideoUrl &&
          other.explaination == this.explaination &&
          other.optionsType == this.optionsType &&
          other.createdAt == this.createdAt);
}

class QuestionsTableCompanion extends UpdateCompanion<QuestionsTableData> {
  final Value<String> id;
  final Value<String> quizId;
  final Value<String?> catId;
  final Value<String?> questionTitle;
  final Value<String?> options;
  final Value<int?> correctAnswerIndex;
  final Value<bool?> hasFourOptions;
  final Value<String?> questionType;
  final Value<String?> questionImageUrl;
  final Value<String?> questionAudioUrl;
  final Value<String?> questionVideoUrl;
  final Value<String?> explaination;
  final Value<String?> optionsType;
  final Value<int?> createdAt;
  final Value<int> rowid;
  const QuestionsTableCompanion({
    this.id = const Value.absent(),
    this.quizId = const Value.absent(),
    this.catId = const Value.absent(),
    this.questionTitle = const Value.absent(),
    this.options = const Value.absent(),
    this.correctAnswerIndex = const Value.absent(),
    this.hasFourOptions = const Value.absent(),
    this.questionType = const Value.absent(),
    this.questionImageUrl = const Value.absent(),
    this.questionAudioUrl = const Value.absent(),
    this.questionVideoUrl = const Value.absent(),
    this.explaination = const Value.absent(),
    this.optionsType = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuestionsTableCompanion.insert({
    required String id,
    required String quizId,
    this.catId = const Value.absent(),
    this.questionTitle = const Value.absent(),
    this.options = const Value.absent(),
    this.correctAnswerIndex = const Value.absent(),
    this.hasFourOptions = const Value.absent(),
    this.questionType = const Value.absent(),
    this.questionImageUrl = const Value.absent(),
    this.questionAudioUrl = const Value.absent(),
    this.questionVideoUrl = const Value.absent(),
    this.explaination = const Value.absent(),
    this.optionsType = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        quizId = Value(quizId);
  static Insertable<QuestionsTableData> custom({
    Expression<String>? id,
    Expression<String>? quizId,
    Expression<String>? catId,
    Expression<String>? questionTitle,
    Expression<String>? options,
    Expression<int>? correctAnswerIndex,
    Expression<bool>? hasFourOptions,
    Expression<String>? questionType,
    Expression<String>? questionImageUrl,
    Expression<String>? questionAudioUrl,
    Expression<String>? questionVideoUrl,
    Expression<String>? explaination,
    Expression<String>? optionsType,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (quizId != null) 'quiz_id': quizId,
      if (catId != null) 'cat_id': catId,
      if (questionTitle != null) 'question_title': questionTitle,
      if (options != null) 'options': options,
      if (correctAnswerIndex != null)
        'correct_answer_index': correctAnswerIndex,
      if (hasFourOptions != null) 'has_four_options': hasFourOptions,
      if (questionType != null) 'question_type': questionType,
      if (questionImageUrl != null) 'question_image_url': questionImageUrl,
      if (questionAudioUrl != null) 'question_audio_url': questionAudioUrl,
      if (questionVideoUrl != null) 'question_video_url': questionVideoUrl,
      if (explaination != null) 'explaination': explaination,
      if (optionsType != null) 'options_type': optionsType,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuestionsTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? quizId,
      Value<String?>? catId,
      Value<String?>? questionTitle,
      Value<String?>? options,
      Value<int?>? correctAnswerIndex,
      Value<bool?>? hasFourOptions,
      Value<String?>? questionType,
      Value<String?>? questionImageUrl,
      Value<String?>? questionAudioUrl,
      Value<String?>? questionVideoUrl,
      Value<String?>? explaination,
      Value<String?>? optionsType,
      Value<int?>? createdAt,
      Value<int>? rowid}) {
    return QuestionsTableCompanion(
      id: id ?? this.id,
      quizId: quizId ?? this.quizId,
      catId: catId ?? this.catId,
      questionTitle: questionTitle ?? this.questionTitle,
      options: options ?? this.options,
      correctAnswerIndex: correctAnswerIndex ?? this.correctAnswerIndex,
      hasFourOptions: hasFourOptions ?? this.hasFourOptions,
      questionType: questionType ?? this.questionType,
      questionImageUrl: questionImageUrl ?? this.questionImageUrl,
      questionAudioUrl: questionAudioUrl ?? this.questionAudioUrl,
      questionVideoUrl: questionVideoUrl ?? this.questionVideoUrl,
      explaination: explaination ?? this.explaination,
      optionsType: optionsType ?? this.optionsType,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (quizId.present) {
      map['quiz_id'] = Variable<String>(quizId.value);
    }
    if (catId.present) {
      map['cat_id'] = Variable<String>(catId.value);
    }
    if (questionTitle.present) {
      map['question_title'] = Variable<String>(questionTitle.value);
    }
    if (options.present) {
      map['options'] = Variable<String>(options.value);
    }
    if (correctAnswerIndex.present) {
      map['correct_answer_index'] = Variable<int>(correctAnswerIndex.value);
    }
    if (hasFourOptions.present) {
      map['has_four_options'] = Variable<bool>(hasFourOptions.value);
    }
    if (questionType.present) {
      map['question_type'] = Variable<String>(questionType.value);
    }
    if (questionImageUrl.present) {
      map['question_image_url'] = Variable<String>(questionImageUrl.value);
    }
    if (questionAudioUrl.present) {
      map['question_audio_url'] = Variable<String>(questionAudioUrl.value);
    }
    if (questionVideoUrl.present) {
      map['question_video_url'] = Variable<String>(questionVideoUrl.value);
    }
    if (explaination.present) {
      map['explaination'] = Variable<String>(explaination.value);
    }
    if (optionsType.present) {
      map['options_type'] = Variable<String>(optionsType.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionsTableCompanion(')
          ..write('id: $id, ')
          ..write('quizId: $quizId, ')
          ..write('catId: $catId, ')
          ..write('questionTitle: $questionTitle, ')
          ..write('options: $options, ')
          ..write('correctAnswerIndex: $correctAnswerIndex, ')
          ..write('hasFourOptions: $hasFourOptions, ')
          ..write('questionType: $questionType, ')
          ..write('questionImageUrl: $questionImageUrl, ')
          ..write('questionAudioUrl: $questionAudioUrl, ')
          ..write('questionVideoUrl: $questionVideoUrl, ')
          ..write('explaination: $explaination, ')
          ..write('optionsType: $optionsType, ')
          ..write('createdAt: $createdAt, ')
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
  late final $QuestionsTableTable questionsTable = $QuestionsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [categoriesTable, quizzesTable, questionsTable];
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

  ComposableFilter questionsTableRefs(
      ComposableFilter Function($$QuestionsTableTableFilterComposer f) f) {
    final $$QuestionsTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.questionsTable,
        getReferencedColumn: (t) => t.quizId,
        builder: (joinBuilder, parentComposers) =>
            $$QuestionsTableTableFilterComposer(ComposerState($state.db,
                $state.db.questionsTable, joinBuilder, parentComposers)));
    return f(composer);
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

typedef $$QuestionsTableTableCreateCompanionBuilder = QuestionsTableCompanion
    Function({
  required String id,
  required String quizId,
  Value<String?> catId,
  Value<String?> questionTitle,
  Value<String?> options,
  Value<int?> correctAnswerIndex,
  Value<bool?> hasFourOptions,
  Value<String?> questionType,
  Value<String?> questionImageUrl,
  Value<String?> questionAudioUrl,
  Value<String?> questionVideoUrl,
  Value<String?> explaination,
  Value<String?> optionsType,
  Value<int?> createdAt,
  Value<int> rowid,
});
typedef $$QuestionsTableTableUpdateCompanionBuilder = QuestionsTableCompanion
    Function({
  Value<String> id,
  Value<String> quizId,
  Value<String?> catId,
  Value<String?> questionTitle,
  Value<String?> options,
  Value<int?> correctAnswerIndex,
  Value<bool?> hasFourOptions,
  Value<String?> questionType,
  Value<String?> questionImageUrl,
  Value<String?> questionAudioUrl,
  Value<String?> questionVideoUrl,
  Value<String?> explaination,
  Value<String?> optionsType,
  Value<int?> createdAt,
  Value<int> rowid,
});

class $$QuestionsTableTableTableManager extends RootTableManager<
    _$QuizDatabase,
    $QuestionsTableTable,
    QuestionsTableData,
    $$QuestionsTableTableFilterComposer,
    $$QuestionsTableTableOrderingComposer,
    $$QuestionsTableTableCreateCompanionBuilder,
    $$QuestionsTableTableUpdateCompanionBuilder> {
  $$QuestionsTableTableTableManager(
      _$QuizDatabase db, $QuestionsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$QuestionsTableTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$QuestionsTableTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> quizId = const Value.absent(),
            Value<String?> catId = const Value.absent(),
            Value<String?> questionTitle = const Value.absent(),
            Value<String?> options = const Value.absent(),
            Value<int?> correctAnswerIndex = const Value.absent(),
            Value<bool?> hasFourOptions = const Value.absent(),
            Value<String?> questionType = const Value.absent(),
            Value<String?> questionImageUrl = const Value.absent(),
            Value<String?> questionAudioUrl = const Value.absent(),
            Value<String?> questionVideoUrl = const Value.absent(),
            Value<String?> explaination = const Value.absent(),
            Value<String?> optionsType = const Value.absent(),
            Value<int?> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              QuestionsTableCompanion(
            id: id,
            quizId: quizId,
            catId: catId,
            questionTitle: questionTitle,
            options: options,
            correctAnswerIndex: correctAnswerIndex,
            hasFourOptions: hasFourOptions,
            questionType: questionType,
            questionImageUrl: questionImageUrl,
            questionAudioUrl: questionAudioUrl,
            questionVideoUrl: questionVideoUrl,
            explaination: explaination,
            optionsType: optionsType,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String quizId,
            Value<String?> catId = const Value.absent(),
            Value<String?> questionTitle = const Value.absent(),
            Value<String?> options = const Value.absent(),
            Value<int?> correctAnswerIndex = const Value.absent(),
            Value<bool?> hasFourOptions = const Value.absent(),
            Value<String?> questionType = const Value.absent(),
            Value<String?> questionImageUrl = const Value.absent(),
            Value<String?> questionAudioUrl = const Value.absent(),
            Value<String?> questionVideoUrl = const Value.absent(),
            Value<String?> explaination = const Value.absent(),
            Value<String?> optionsType = const Value.absent(),
            Value<int?> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              QuestionsTableCompanion.insert(
            id: id,
            quizId: quizId,
            catId: catId,
            questionTitle: questionTitle,
            options: options,
            correctAnswerIndex: correctAnswerIndex,
            hasFourOptions: hasFourOptions,
            questionType: questionType,
            questionImageUrl: questionImageUrl,
            questionAudioUrl: questionAudioUrl,
            questionVideoUrl: questionVideoUrl,
            explaination: explaination,
            optionsType: optionsType,
            createdAt: createdAt,
            rowid: rowid,
          ),
        ));
}

class $$QuestionsTableTableFilterComposer
    extends FilterComposer<_$QuizDatabase, $QuestionsTableTable> {
  $$QuestionsTableTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get catId => $state.composableBuilder(
      column: $state.table.catId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get questionTitle => $state.composableBuilder(
      column: $state.table.questionTitle,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get options => $state.composableBuilder(
      column: $state.table.options,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get correctAnswerIndex => $state.composableBuilder(
      column: $state.table.correctAnswerIndex,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get hasFourOptions => $state.composableBuilder(
      column: $state.table.hasFourOptions,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get questionType => $state.composableBuilder(
      column: $state.table.questionType,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get questionImageUrl => $state.composableBuilder(
      column: $state.table.questionImageUrl,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get questionAudioUrl => $state.composableBuilder(
      column: $state.table.questionAudioUrl,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get questionVideoUrl => $state.composableBuilder(
      column: $state.table.questionVideoUrl,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get explaination => $state.composableBuilder(
      column: $state.table.explaination,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get optionsType => $state.composableBuilder(
      column: $state.table.optionsType,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$QuizzesTableTableFilterComposer get quizId {
    final $$QuizzesTableTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.quizId,
        referencedTable: $state.db.quizzesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$QuizzesTableTableFilterComposer(ComposerState($state.db,
                $state.db.quizzesTable, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$QuestionsTableTableOrderingComposer
    extends OrderingComposer<_$QuizDatabase, $QuestionsTableTable> {
  $$QuestionsTableTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get catId => $state.composableBuilder(
      column: $state.table.catId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get questionTitle => $state.composableBuilder(
      column: $state.table.questionTitle,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get options => $state.composableBuilder(
      column: $state.table.options,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get correctAnswerIndex => $state.composableBuilder(
      column: $state.table.correctAnswerIndex,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get hasFourOptions => $state.composableBuilder(
      column: $state.table.hasFourOptions,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get questionType => $state.composableBuilder(
      column: $state.table.questionType,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get questionImageUrl => $state.composableBuilder(
      column: $state.table.questionImageUrl,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get questionAudioUrl => $state.composableBuilder(
      column: $state.table.questionAudioUrl,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get questionVideoUrl => $state.composableBuilder(
      column: $state.table.questionVideoUrl,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get explaination => $state.composableBuilder(
      column: $state.table.explaination,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get optionsType => $state.composableBuilder(
      column: $state.table.optionsType,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$QuizzesTableTableOrderingComposer get quizId {
    final $$QuizzesTableTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.quizId,
        referencedTable: $state.db.quizzesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$QuizzesTableTableOrderingComposer(ComposerState($state.db,
                $state.db.quizzesTable, joinBuilder, parentComposers)));
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
  $$QuestionsTableTableTableManager get questionsTable =>
      $$QuestionsTableTableTableManager(_db, _db.questionsTable);
}
