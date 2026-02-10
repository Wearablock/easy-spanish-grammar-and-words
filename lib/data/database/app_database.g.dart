// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $StudyRecordsTable extends StudyRecords
    with TableInfo<$StudyRecordsTable, StudyRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudyRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _questionIdMeta = const VerificationMeta(
    'questionId',
  );
  @override
  late final GeneratedColumn<String> questionId = GeneratedColumn<String>(
    'question_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _topicIdMeta = const VerificationMeta(
    'topicId',
  );
  @override
  late final GeneratedColumn<String> topicId = GeneratedColumn<String>(
    'topic_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _levelIdMeta = const VerificationMeta(
    'levelId',
  );
  @override
  late final GeneratedColumn<String> levelId = GeneratedColumn<String>(
    'level_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _correctCountMeta = const VerificationMeta(
    'correctCount',
  );
  @override
  late final GeneratedColumn<int> correctCount = GeneratedColumn<int>(
    'correct_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _wrongCountMeta = const VerificationMeta(
    'wrongCount',
  );
  @override
  late final GeneratedColumn<int> wrongCount = GeneratedColumn<int>(
    'wrong_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastStudiedAtMeta = const VerificationMeta(
    'lastStudiedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastStudiedAt =
      GeneratedColumn<DateTime>(
        'last_studied_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _nextReviewAtMeta = const VerificationMeta(
    'nextReviewAt',
  );
  @override
  late final GeneratedColumn<DateTime> nextReviewAt = GeneratedColumn<DateTime>(
    'next_review_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    questionId,
    topicId,
    levelId,
    level,
    correctCount,
    wrongCount,
    lastStudiedAt,
    nextReviewAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'study_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<StudyRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('question_id')) {
      context.handle(
        _questionIdMeta,
        questionId.isAcceptableOrUnknown(data['question_id']!, _questionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_questionIdMeta);
    }
    if (data.containsKey('topic_id')) {
      context.handle(
        _topicIdMeta,
        topicId.isAcceptableOrUnknown(data['topic_id']!, _topicIdMeta),
      );
    } else if (isInserting) {
      context.missing(_topicIdMeta);
    }
    if (data.containsKey('level_id')) {
      context.handle(
        _levelIdMeta,
        levelId.isAcceptableOrUnknown(data['level_id']!, _levelIdMeta),
      );
    } else if (isInserting) {
      context.missing(_levelIdMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    }
    if (data.containsKey('correct_count')) {
      context.handle(
        _correctCountMeta,
        correctCount.isAcceptableOrUnknown(
          data['correct_count']!,
          _correctCountMeta,
        ),
      );
    }
    if (data.containsKey('wrong_count')) {
      context.handle(
        _wrongCountMeta,
        wrongCount.isAcceptableOrUnknown(data['wrong_count']!, _wrongCountMeta),
      );
    }
    if (data.containsKey('last_studied_at')) {
      context.handle(
        _lastStudiedAtMeta,
        lastStudiedAt.isAcceptableOrUnknown(
          data['last_studied_at']!,
          _lastStudiedAtMeta,
        ),
      );
    }
    if (data.containsKey('next_review_at')) {
      context.handle(
        _nextReviewAtMeta,
        nextReviewAt.isAcceptableOrUnknown(
          data['next_review_at']!,
          _nextReviewAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {questionId},
  ];
  @override
  StudyRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StudyRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      questionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_id'],
      )!,
      topicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}topic_id'],
      )!,
      levelId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}level_id'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}level'],
      )!,
      correctCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}correct_count'],
      )!,
      wrongCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wrong_count'],
      )!,
      lastStudiedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_studied_at'],
      ),
      nextReviewAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}next_review_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $StudyRecordsTable createAlias(String alias) {
    return $StudyRecordsTable(attachedDatabase, alias);
  }
}

class StudyRecord extends DataClass implements Insertable<StudyRecord> {
  final int id;

  /// 문제 ID (questions_meta.json의 id와 일치)
  final String questionId;

  /// Topic ID (역정규화, 조회 최적화용)
  final String topicId;

  /// Level ID (역정규화, 통계용)
  final String levelId;

  /// 학습 레벨 (0: 신규, 1-4: 학습중, 5: 완전습득)
  final int level;

  /// 누적 정답 횟수
  final int correctCount;

  /// 누적 오답 횟수
  final int wrongCount;

  /// 마지막 학습 시간
  final DateTime? lastStudiedAt;

  /// 다음 복습 예정 시간
  final DateTime? nextReviewAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const StudyRecord({
    required this.id,
    required this.questionId,
    required this.topicId,
    required this.levelId,
    required this.level,
    required this.correctCount,
    required this.wrongCount,
    this.lastStudiedAt,
    this.nextReviewAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['question_id'] = Variable<String>(questionId);
    map['topic_id'] = Variable<String>(topicId);
    map['level_id'] = Variable<String>(levelId);
    map['level'] = Variable<int>(level);
    map['correct_count'] = Variable<int>(correctCount);
    map['wrong_count'] = Variable<int>(wrongCount);
    if (!nullToAbsent || lastStudiedAt != null) {
      map['last_studied_at'] = Variable<DateTime>(lastStudiedAt);
    }
    if (!nullToAbsent || nextReviewAt != null) {
      map['next_review_at'] = Variable<DateTime>(nextReviewAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  StudyRecordsCompanion toCompanion(bool nullToAbsent) {
    return StudyRecordsCompanion(
      id: Value(id),
      questionId: Value(questionId),
      topicId: Value(topicId),
      levelId: Value(levelId),
      level: Value(level),
      correctCount: Value(correctCount),
      wrongCount: Value(wrongCount),
      lastStudiedAt: lastStudiedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastStudiedAt),
      nextReviewAt: nextReviewAt == null && nullToAbsent
          ? const Value.absent()
          : Value(nextReviewAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory StudyRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StudyRecord(
      id: serializer.fromJson<int>(json['id']),
      questionId: serializer.fromJson<String>(json['questionId']),
      topicId: serializer.fromJson<String>(json['topicId']),
      levelId: serializer.fromJson<String>(json['levelId']),
      level: serializer.fromJson<int>(json['level']),
      correctCount: serializer.fromJson<int>(json['correctCount']),
      wrongCount: serializer.fromJson<int>(json['wrongCount']),
      lastStudiedAt: serializer.fromJson<DateTime?>(json['lastStudiedAt']),
      nextReviewAt: serializer.fromJson<DateTime?>(json['nextReviewAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'questionId': serializer.toJson<String>(questionId),
      'topicId': serializer.toJson<String>(topicId),
      'levelId': serializer.toJson<String>(levelId),
      'level': serializer.toJson<int>(level),
      'correctCount': serializer.toJson<int>(correctCount),
      'wrongCount': serializer.toJson<int>(wrongCount),
      'lastStudiedAt': serializer.toJson<DateTime?>(lastStudiedAt),
      'nextReviewAt': serializer.toJson<DateTime?>(nextReviewAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  StudyRecord copyWith({
    int? id,
    String? questionId,
    String? topicId,
    String? levelId,
    int? level,
    int? correctCount,
    int? wrongCount,
    Value<DateTime?> lastStudiedAt = const Value.absent(),
    Value<DateTime?> nextReviewAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => StudyRecord(
    id: id ?? this.id,
    questionId: questionId ?? this.questionId,
    topicId: topicId ?? this.topicId,
    levelId: levelId ?? this.levelId,
    level: level ?? this.level,
    correctCount: correctCount ?? this.correctCount,
    wrongCount: wrongCount ?? this.wrongCount,
    lastStudiedAt: lastStudiedAt.present
        ? lastStudiedAt.value
        : this.lastStudiedAt,
    nextReviewAt: nextReviewAt.present ? nextReviewAt.value : this.nextReviewAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  StudyRecord copyWithCompanion(StudyRecordsCompanion data) {
    return StudyRecord(
      id: data.id.present ? data.id.value : this.id,
      questionId: data.questionId.present
          ? data.questionId.value
          : this.questionId,
      topicId: data.topicId.present ? data.topicId.value : this.topicId,
      levelId: data.levelId.present ? data.levelId.value : this.levelId,
      level: data.level.present ? data.level.value : this.level,
      correctCount: data.correctCount.present
          ? data.correctCount.value
          : this.correctCount,
      wrongCount: data.wrongCount.present
          ? data.wrongCount.value
          : this.wrongCount,
      lastStudiedAt: data.lastStudiedAt.present
          ? data.lastStudiedAt.value
          : this.lastStudiedAt,
      nextReviewAt: data.nextReviewAt.present
          ? data.nextReviewAt.value
          : this.nextReviewAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StudyRecord(')
          ..write('id: $id, ')
          ..write('questionId: $questionId, ')
          ..write('topicId: $topicId, ')
          ..write('levelId: $levelId, ')
          ..write('level: $level, ')
          ..write('correctCount: $correctCount, ')
          ..write('wrongCount: $wrongCount, ')
          ..write('lastStudiedAt: $lastStudiedAt, ')
          ..write('nextReviewAt: $nextReviewAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    questionId,
    topicId,
    levelId,
    level,
    correctCount,
    wrongCount,
    lastStudiedAt,
    nextReviewAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StudyRecord &&
          other.id == this.id &&
          other.questionId == this.questionId &&
          other.topicId == this.topicId &&
          other.levelId == this.levelId &&
          other.level == this.level &&
          other.correctCount == this.correctCount &&
          other.wrongCount == this.wrongCount &&
          other.lastStudiedAt == this.lastStudiedAt &&
          other.nextReviewAt == this.nextReviewAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class StudyRecordsCompanion extends UpdateCompanion<StudyRecord> {
  final Value<int> id;
  final Value<String> questionId;
  final Value<String> topicId;
  final Value<String> levelId;
  final Value<int> level;
  final Value<int> correctCount;
  final Value<int> wrongCount;
  final Value<DateTime?> lastStudiedAt;
  final Value<DateTime?> nextReviewAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const StudyRecordsCompanion({
    this.id = const Value.absent(),
    this.questionId = const Value.absent(),
    this.topicId = const Value.absent(),
    this.levelId = const Value.absent(),
    this.level = const Value.absent(),
    this.correctCount = const Value.absent(),
    this.wrongCount = const Value.absent(),
    this.lastStudiedAt = const Value.absent(),
    this.nextReviewAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  StudyRecordsCompanion.insert({
    this.id = const Value.absent(),
    required String questionId,
    required String topicId,
    required String levelId,
    this.level = const Value.absent(),
    this.correctCount = const Value.absent(),
    this.wrongCount = const Value.absent(),
    this.lastStudiedAt = const Value.absent(),
    this.nextReviewAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : questionId = Value(questionId),
       topicId = Value(topicId),
       levelId = Value(levelId);
  static Insertable<StudyRecord> custom({
    Expression<int>? id,
    Expression<String>? questionId,
    Expression<String>? topicId,
    Expression<String>? levelId,
    Expression<int>? level,
    Expression<int>? correctCount,
    Expression<int>? wrongCount,
    Expression<DateTime>? lastStudiedAt,
    Expression<DateTime>? nextReviewAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (questionId != null) 'question_id': questionId,
      if (topicId != null) 'topic_id': topicId,
      if (levelId != null) 'level_id': levelId,
      if (level != null) 'level': level,
      if (correctCount != null) 'correct_count': correctCount,
      if (wrongCount != null) 'wrong_count': wrongCount,
      if (lastStudiedAt != null) 'last_studied_at': lastStudiedAt,
      if (nextReviewAt != null) 'next_review_at': nextReviewAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  StudyRecordsCompanion copyWith({
    Value<int>? id,
    Value<String>? questionId,
    Value<String>? topicId,
    Value<String>? levelId,
    Value<int>? level,
    Value<int>? correctCount,
    Value<int>? wrongCount,
    Value<DateTime?>? lastStudiedAt,
    Value<DateTime?>? nextReviewAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return StudyRecordsCompanion(
      id: id ?? this.id,
      questionId: questionId ?? this.questionId,
      topicId: topicId ?? this.topicId,
      levelId: levelId ?? this.levelId,
      level: level ?? this.level,
      correctCount: correctCount ?? this.correctCount,
      wrongCount: wrongCount ?? this.wrongCount,
      lastStudiedAt: lastStudiedAt ?? this.lastStudiedAt,
      nextReviewAt: nextReviewAt ?? this.nextReviewAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (questionId.present) {
      map['question_id'] = Variable<String>(questionId.value);
    }
    if (topicId.present) {
      map['topic_id'] = Variable<String>(topicId.value);
    }
    if (levelId.present) {
      map['level_id'] = Variable<String>(levelId.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (correctCount.present) {
      map['correct_count'] = Variable<int>(correctCount.value);
    }
    if (wrongCount.present) {
      map['wrong_count'] = Variable<int>(wrongCount.value);
    }
    if (lastStudiedAt.present) {
      map['last_studied_at'] = Variable<DateTime>(lastStudiedAt.value);
    }
    if (nextReviewAt.present) {
      map['next_review_at'] = Variable<DateTime>(nextReviewAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudyRecordsCompanion(')
          ..write('id: $id, ')
          ..write('questionId: $questionId, ')
          ..write('topicId: $topicId, ')
          ..write('levelId: $levelId, ')
          ..write('level: $level, ')
          ..write('correctCount: $correctCount, ')
          ..write('wrongCount: $wrongCount, ')
          ..write('lastStudiedAt: $lastStudiedAt, ')
          ..write('nextReviewAt: $nextReviewAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $WrongAnswersTable extends WrongAnswers
    with TableInfo<$WrongAnswersTable, WrongAnswer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WrongAnswersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _questionIdMeta = const VerificationMeta(
    'questionId',
  );
  @override
  late final GeneratedColumn<String> questionId = GeneratedColumn<String>(
    'question_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _topicIdMeta = const VerificationMeta(
    'topicId',
  );
  @override
  late final GeneratedColumn<String> topicId = GeneratedColumn<String>(
    'topic_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _levelIdMeta = const VerificationMeta(
    'levelId',
  );
  @override
  late final GeneratedColumn<String> levelId = GeneratedColumn<String>(
    'level_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wrongCountMeta = const VerificationMeta(
    'wrongCount',
  );
  @override
  late final GeneratedColumn<int> wrongCount = GeneratedColumn<int>(
    'wrong_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _lastWrongAnswerMeta = const VerificationMeta(
    'lastWrongAnswer',
  );
  @override
  late final GeneratedColumn<String> lastWrongAnswer = GeneratedColumn<String>(
    'last_wrong_answer',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _wrongAtMeta = const VerificationMeta(
    'wrongAt',
  );
  @override
  late final GeneratedColumn<DateTime> wrongAt = GeneratedColumn<DateTime>(
    'wrong_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _correctedAtMeta = const VerificationMeta(
    'correctedAt',
  );
  @override
  late final GeneratedColumn<DateTime> correctedAt = GeneratedColumn<DateTime>(
    'corrected_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    questionId,
    topicId,
    levelId,
    wrongCount,
    lastWrongAnswer,
    wrongAt,
    correctedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wrong_answers';
  @override
  VerificationContext validateIntegrity(
    Insertable<WrongAnswer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('question_id')) {
      context.handle(
        _questionIdMeta,
        questionId.isAcceptableOrUnknown(data['question_id']!, _questionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_questionIdMeta);
    }
    if (data.containsKey('topic_id')) {
      context.handle(
        _topicIdMeta,
        topicId.isAcceptableOrUnknown(data['topic_id']!, _topicIdMeta),
      );
    } else if (isInserting) {
      context.missing(_topicIdMeta);
    }
    if (data.containsKey('level_id')) {
      context.handle(
        _levelIdMeta,
        levelId.isAcceptableOrUnknown(data['level_id']!, _levelIdMeta),
      );
    } else if (isInserting) {
      context.missing(_levelIdMeta);
    }
    if (data.containsKey('wrong_count')) {
      context.handle(
        _wrongCountMeta,
        wrongCount.isAcceptableOrUnknown(data['wrong_count']!, _wrongCountMeta),
      );
    }
    if (data.containsKey('last_wrong_answer')) {
      context.handle(
        _lastWrongAnswerMeta,
        lastWrongAnswer.isAcceptableOrUnknown(
          data['last_wrong_answer']!,
          _lastWrongAnswerMeta,
        ),
      );
    }
    if (data.containsKey('wrong_at')) {
      context.handle(
        _wrongAtMeta,
        wrongAt.isAcceptableOrUnknown(data['wrong_at']!, _wrongAtMeta),
      );
    } else if (isInserting) {
      context.missing(_wrongAtMeta);
    }
    if (data.containsKey('corrected_at')) {
      context.handle(
        _correctedAtMeta,
        correctedAt.isAcceptableOrUnknown(
          data['corrected_at']!,
          _correctedAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {questionId},
  ];
  @override
  WrongAnswer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WrongAnswer(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      questionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_id'],
      )!,
      topicId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}topic_id'],
      )!,
      levelId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}level_id'],
      )!,
      wrongCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wrong_count'],
      )!,
      lastWrongAnswer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_wrong_answer'],
      ),
      wrongAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}wrong_at'],
      )!,
      correctedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}corrected_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $WrongAnswersTable createAlias(String alias) {
    return $WrongAnswersTable(attachedDatabase, alias);
  }
}

class WrongAnswer extends DataClass implements Insertable<WrongAnswer> {
  final int id;

  /// 문제 ID (고유)
  final String questionId;

  /// Topic ID (역정규화)
  final String topicId;

  /// Level ID (역정규화)
  final String levelId;

  /// 틀린 총 횟수
  final int wrongCount;

  /// 마지막으로 선택한 오답
  final String? lastWrongAnswer;

  /// 마지막으로 틀린 시간
  final DateTime wrongAt;

  /// 정답으로 맞춘 시간 (복습 완료)
  final DateTime? correctedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const WrongAnswer({
    required this.id,
    required this.questionId,
    required this.topicId,
    required this.levelId,
    required this.wrongCount,
    this.lastWrongAnswer,
    required this.wrongAt,
    this.correctedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['question_id'] = Variable<String>(questionId);
    map['topic_id'] = Variable<String>(topicId);
    map['level_id'] = Variable<String>(levelId);
    map['wrong_count'] = Variable<int>(wrongCount);
    if (!nullToAbsent || lastWrongAnswer != null) {
      map['last_wrong_answer'] = Variable<String>(lastWrongAnswer);
    }
    map['wrong_at'] = Variable<DateTime>(wrongAt);
    if (!nullToAbsent || correctedAt != null) {
      map['corrected_at'] = Variable<DateTime>(correctedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  WrongAnswersCompanion toCompanion(bool nullToAbsent) {
    return WrongAnswersCompanion(
      id: Value(id),
      questionId: Value(questionId),
      topicId: Value(topicId),
      levelId: Value(levelId),
      wrongCount: Value(wrongCount),
      lastWrongAnswer: lastWrongAnswer == null && nullToAbsent
          ? const Value.absent()
          : Value(lastWrongAnswer),
      wrongAt: Value(wrongAt),
      correctedAt: correctedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(correctedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory WrongAnswer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WrongAnswer(
      id: serializer.fromJson<int>(json['id']),
      questionId: serializer.fromJson<String>(json['questionId']),
      topicId: serializer.fromJson<String>(json['topicId']),
      levelId: serializer.fromJson<String>(json['levelId']),
      wrongCount: serializer.fromJson<int>(json['wrongCount']),
      lastWrongAnswer: serializer.fromJson<String?>(json['lastWrongAnswer']),
      wrongAt: serializer.fromJson<DateTime>(json['wrongAt']),
      correctedAt: serializer.fromJson<DateTime?>(json['correctedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'questionId': serializer.toJson<String>(questionId),
      'topicId': serializer.toJson<String>(topicId),
      'levelId': serializer.toJson<String>(levelId),
      'wrongCount': serializer.toJson<int>(wrongCount),
      'lastWrongAnswer': serializer.toJson<String?>(lastWrongAnswer),
      'wrongAt': serializer.toJson<DateTime>(wrongAt),
      'correctedAt': serializer.toJson<DateTime?>(correctedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  WrongAnswer copyWith({
    int? id,
    String? questionId,
    String? topicId,
    String? levelId,
    int? wrongCount,
    Value<String?> lastWrongAnswer = const Value.absent(),
    DateTime? wrongAt,
    Value<DateTime?> correctedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => WrongAnswer(
    id: id ?? this.id,
    questionId: questionId ?? this.questionId,
    topicId: topicId ?? this.topicId,
    levelId: levelId ?? this.levelId,
    wrongCount: wrongCount ?? this.wrongCount,
    lastWrongAnswer: lastWrongAnswer.present
        ? lastWrongAnswer.value
        : this.lastWrongAnswer,
    wrongAt: wrongAt ?? this.wrongAt,
    correctedAt: correctedAt.present ? correctedAt.value : this.correctedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  WrongAnswer copyWithCompanion(WrongAnswersCompanion data) {
    return WrongAnswer(
      id: data.id.present ? data.id.value : this.id,
      questionId: data.questionId.present
          ? data.questionId.value
          : this.questionId,
      topicId: data.topicId.present ? data.topicId.value : this.topicId,
      levelId: data.levelId.present ? data.levelId.value : this.levelId,
      wrongCount: data.wrongCount.present
          ? data.wrongCount.value
          : this.wrongCount,
      lastWrongAnswer: data.lastWrongAnswer.present
          ? data.lastWrongAnswer.value
          : this.lastWrongAnswer,
      wrongAt: data.wrongAt.present ? data.wrongAt.value : this.wrongAt,
      correctedAt: data.correctedAt.present
          ? data.correctedAt.value
          : this.correctedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WrongAnswer(')
          ..write('id: $id, ')
          ..write('questionId: $questionId, ')
          ..write('topicId: $topicId, ')
          ..write('levelId: $levelId, ')
          ..write('wrongCount: $wrongCount, ')
          ..write('lastWrongAnswer: $lastWrongAnswer, ')
          ..write('wrongAt: $wrongAt, ')
          ..write('correctedAt: $correctedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    questionId,
    topicId,
    levelId,
    wrongCount,
    lastWrongAnswer,
    wrongAt,
    correctedAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WrongAnswer &&
          other.id == this.id &&
          other.questionId == this.questionId &&
          other.topicId == this.topicId &&
          other.levelId == this.levelId &&
          other.wrongCount == this.wrongCount &&
          other.lastWrongAnswer == this.lastWrongAnswer &&
          other.wrongAt == this.wrongAt &&
          other.correctedAt == this.correctedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WrongAnswersCompanion extends UpdateCompanion<WrongAnswer> {
  final Value<int> id;
  final Value<String> questionId;
  final Value<String> topicId;
  final Value<String> levelId;
  final Value<int> wrongCount;
  final Value<String?> lastWrongAnswer;
  final Value<DateTime> wrongAt;
  final Value<DateTime?> correctedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const WrongAnswersCompanion({
    this.id = const Value.absent(),
    this.questionId = const Value.absent(),
    this.topicId = const Value.absent(),
    this.levelId = const Value.absent(),
    this.wrongCount = const Value.absent(),
    this.lastWrongAnswer = const Value.absent(),
    this.wrongAt = const Value.absent(),
    this.correctedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  WrongAnswersCompanion.insert({
    this.id = const Value.absent(),
    required String questionId,
    required String topicId,
    required String levelId,
    this.wrongCount = const Value.absent(),
    this.lastWrongAnswer = const Value.absent(),
    required DateTime wrongAt,
    this.correctedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : questionId = Value(questionId),
       topicId = Value(topicId),
       levelId = Value(levelId),
       wrongAt = Value(wrongAt);
  static Insertable<WrongAnswer> custom({
    Expression<int>? id,
    Expression<String>? questionId,
    Expression<String>? topicId,
    Expression<String>? levelId,
    Expression<int>? wrongCount,
    Expression<String>? lastWrongAnswer,
    Expression<DateTime>? wrongAt,
    Expression<DateTime>? correctedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (questionId != null) 'question_id': questionId,
      if (topicId != null) 'topic_id': topicId,
      if (levelId != null) 'level_id': levelId,
      if (wrongCount != null) 'wrong_count': wrongCount,
      if (lastWrongAnswer != null) 'last_wrong_answer': lastWrongAnswer,
      if (wrongAt != null) 'wrong_at': wrongAt,
      if (correctedAt != null) 'corrected_at': correctedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  WrongAnswersCompanion copyWith({
    Value<int>? id,
    Value<String>? questionId,
    Value<String>? topicId,
    Value<String>? levelId,
    Value<int>? wrongCount,
    Value<String?>? lastWrongAnswer,
    Value<DateTime>? wrongAt,
    Value<DateTime?>? correctedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return WrongAnswersCompanion(
      id: id ?? this.id,
      questionId: questionId ?? this.questionId,
      topicId: topicId ?? this.topicId,
      levelId: levelId ?? this.levelId,
      wrongCount: wrongCount ?? this.wrongCount,
      lastWrongAnswer: lastWrongAnswer ?? this.lastWrongAnswer,
      wrongAt: wrongAt ?? this.wrongAt,
      correctedAt: correctedAt ?? this.correctedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (questionId.present) {
      map['question_id'] = Variable<String>(questionId.value);
    }
    if (topicId.present) {
      map['topic_id'] = Variable<String>(topicId.value);
    }
    if (levelId.present) {
      map['level_id'] = Variable<String>(levelId.value);
    }
    if (wrongCount.present) {
      map['wrong_count'] = Variable<int>(wrongCount.value);
    }
    if (lastWrongAnswer.present) {
      map['last_wrong_answer'] = Variable<String>(lastWrongAnswer.value);
    }
    if (wrongAt.present) {
      map['wrong_at'] = Variable<DateTime>(wrongAt.value);
    }
    if (correctedAt.present) {
      map['corrected_at'] = Variable<DateTime>(correctedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WrongAnswersCompanion(')
          ..write('id: $id, ')
          ..write('questionId: $questionId, ')
          ..write('topicId: $topicId, ')
          ..write('levelId: $levelId, ')
          ..write('wrongCount: $wrongCount, ')
          ..write('lastWrongAnswer: $lastWrongAnswer, ')
          ..write('wrongAt: $wrongAt, ')
          ..write('correctedAt: $correctedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $DailyStatsTable extends DailyStats
    with TableInfo<$DailyStatsTable, DailyStat> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyStatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _questionsStudiedMeta = const VerificationMeta(
    'questionsStudied',
  );
  @override
  late final GeneratedColumn<int> questionsStudied = GeneratedColumn<int>(
    'questions_studied',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _correctAnswersMeta = const VerificationMeta(
    'correctAnswers',
  );
  @override
  late final GeneratedColumn<int> correctAnswers = GeneratedColumn<int>(
    'correct_answers',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _studyTimeSecMeta = const VerificationMeta(
    'studyTimeSec',
  );
  @override
  late final GeneratedColumn<int> studyTimeSec = GeneratedColumn<int>(
    'study_time_sec',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _newQuestionsMeta = const VerificationMeta(
    'newQuestions',
  );
  @override
  late final GeneratedColumn<int> newQuestions = GeneratedColumn<int>(
    'new_questions',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _reviewQuestionsMeta = const VerificationMeta(
    'reviewQuestions',
  );
  @override
  late final GeneratedColumn<int> reviewQuestions = GeneratedColumn<int>(
    'review_questions',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _dailyGoalMeta = const VerificationMeta(
    'dailyGoal',
  );
  @override
  late final GeneratedColumn<int> dailyGoal = GeneratedColumn<int>(
    'daily_goal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(15),
  );
  static const VerificationMeta _goalAchievedMeta = const VerificationMeta(
    'goalAchieved',
  );
  @override
  late final GeneratedColumn<bool> goalAchieved = GeneratedColumn<bool>(
    'goal_achieved',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("goal_achieved" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    questionsStudied,
    correctAnswers,
    studyTimeSec,
    newQuestions,
    reviewQuestions,
    dailyGoal,
    goalAchieved,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_stats';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyStat> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('questions_studied')) {
      context.handle(
        _questionsStudiedMeta,
        questionsStudied.isAcceptableOrUnknown(
          data['questions_studied']!,
          _questionsStudiedMeta,
        ),
      );
    }
    if (data.containsKey('correct_answers')) {
      context.handle(
        _correctAnswersMeta,
        correctAnswers.isAcceptableOrUnknown(
          data['correct_answers']!,
          _correctAnswersMeta,
        ),
      );
    }
    if (data.containsKey('study_time_sec')) {
      context.handle(
        _studyTimeSecMeta,
        studyTimeSec.isAcceptableOrUnknown(
          data['study_time_sec']!,
          _studyTimeSecMeta,
        ),
      );
    }
    if (data.containsKey('new_questions')) {
      context.handle(
        _newQuestionsMeta,
        newQuestions.isAcceptableOrUnknown(
          data['new_questions']!,
          _newQuestionsMeta,
        ),
      );
    }
    if (data.containsKey('review_questions')) {
      context.handle(
        _reviewQuestionsMeta,
        reviewQuestions.isAcceptableOrUnknown(
          data['review_questions']!,
          _reviewQuestionsMeta,
        ),
      );
    }
    if (data.containsKey('daily_goal')) {
      context.handle(
        _dailyGoalMeta,
        dailyGoal.isAcceptableOrUnknown(data['daily_goal']!, _dailyGoalMeta),
      );
    }
    if (data.containsKey('goal_achieved')) {
      context.handle(
        _goalAchievedMeta,
        goalAchieved.isAcceptableOrUnknown(
          data['goal_achieved']!,
          _goalAchievedMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {date},
  ];
  @override
  DailyStat map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyStat(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      questionsStudied: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}questions_studied'],
      )!,
      correctAnswers: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}correct_answers'],
      )!,
      studyTimeSec: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}study_time_sec'],
      )!,
      newQuestions: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}new_questions'],
      )!,
      reviewQuestions: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}review_questions'],
      )!,
      dailyGoal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}daily_goal'],
      )!,
      goalAchieved: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}goal_achieved'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $DailyStatsTable createAlias(String alias) {
    return $DailyStatsTable(attachedDatabase, alias);
  }
}

class DailyStat extends DataClass implements Insertable<DailyStat> {
  final int id;

  /// 학습 날짜 (YYYY-MM-DD, 고유)
  final DateTime date;

  /// 학습한 총 문제 수
  final int questionsStudied;

  /// 정답 수
  final int correctAnswers;

  /// 학습 시간 (초)
  final int studyTimeSec;

  /// 신규 문제 수
  final int newQuestions;

  /// 복습 문제 수
  final int reviewQuestions;

  /// 해당일 목표 문제 수
  final int dailyGoal;

  /// 목표 달성 여부
  final bool goalAchieved;
  final DateTime createdAt;
  final DateTime updatedAt;
  const DailyStat({
    required this.id,
    required this.date,
    required this.questionsStudied,
    required this.correctAnswers,
    required this.studyTimeSec,
    required this.newQuestions,
    required this.reviewQuestions,
    required this.dailyGoal,
    required this.goalAchieved,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['questions_studied'] = Variable<int>(questionsStudied);
    map['correct_answers'] = Variable<int>(correctAnswers);
    map['study_time_sec'] = Variable<int>(studyTimeSec);
    map['new_questions'] = Variable<int>(newQuestions);
    map['review_questions'] = Variable<int>(reviewQuestions);
    map['daily_goal'] = Variable<int>(dailyGoal);
    map['goal_achieved'] = Variable<bool>(goalAchieved);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DailyStatsCompanion toCompanion(bool nullToAbsent) {
    return DailyStatsCompanion(
      id: Value(id),
      date: Value(date),
      questionsStudied: Value(questionsStudied),
      correctAnswers: Value(correctAnswers),
      studyTimeSec: Value(studyTimeSec),
      newQuestions: Value(newQuestions),
      reviewQuestions: Value(reviewQuestions),
      dailyGoal: Value(dailyGoal),
      goalAchieved: Value(goalAchieved),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory DailyStat.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyStat(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      questionsStudied: serializer.fromJson<int>(json['questionsStudied']),
      correctAnswers: serializer.fromJson<int>(json['correctAnswers']),
      studyTimeSec: serializer.fromJson<int>(json['studyTimeSec']),
      newQuestions: serializer.fromJson<int>(json['newQuestions']),
      reviewQuestions: serializer.fromJson<int>(json['reviewQuestions']),
      dailyGoal: serializer.fromJson<int>(json['dailyGoal']),
      goalAchieved: serializer.fromJson<bool>(json['goalAchieved']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'questionsStudied': serializer.toJson<int>(questionsStudied),
      'correctAnswers': serializer.toJson<int>(correctAnswers),
      'studyTimeSec': serializer.toJson<int>(studyTimeSec),
      'newQuestions': serializer.toJson<int>(newQuestions),
      'reviewQuestions': serializer.toJson<int>(reviewQuestions),
      'dailyGoal': serializer.toJson<int>(dailyGoal),
      'goalAchieved': serializer.toJson<bool>(goalAchieved),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DailyStat copyWith({
    int? id,
    DateTime? date,
    int? questionsStudied,
    int? correctAnswers,
    int? studyTimeSec,
    int? newQuestions,
    int? reviewQuestions,
    int? dailyGoal,
    bool? goalAchieved,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => DailyStat(
    id: id ?? this.id,
    date: date ?? this.date,
    questionsStudied: questionsStudied ?? this.questionsStudied,
    correctAnswers: correctAnswers ?? this.correctAnswers,
    studyTimeSec: studyTimeSec ?? this.studyTimeSec,
    newQuestions: newQuestions ?? this.newQuestions,
    reviewQuestions: reviewQuestions ?? this.reviewQuestions,
    dailyGoal: dailyGoal ?? this.dailyGoal,
    goalAchieved: goalAchieved ?? this.goalAchieved,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  DailyStat copyWithCompanion(DailyStatsCompanion data) {
    return DailyStat(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      questionsStudied: data.questionsStudied.present
          ? data.questionsStudied.value
          : this.questionsStudied,
      correctAnswers: data.correctAnswers.present
          ? data.correctAnswers.value
          : this.correctAnswers,
      studyTimeSec: data.studyTimeSec.present
          ? data.studyTimeSec.value
          : this.studyTimeSec,
      newQuestions: data.newQuestions.present
          ? data.newQuestions.value
          : this.newQuestions,
      reviewQuestions: data.reviewQuestions.present
          ? data.reviewQuestions.value
          : this.reviewQuestions,
      dailyGoal: data.dailyGoal.present ? data.dailyGoal.value : this.dailyGoal,
      goalAchieved: data.goalAchieved.present
          ? data.goalAchieved.value
          : this.goalAchieved,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyStat(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('questionsStudied: $questionsStudied, ')
          ..write('correctAnswers: $correctAnswers, ')
          ..write('studyTimeSec: $studyTimeSec, ')
          ..write('newQuestions: $newQuestions, ')
          ..write('reviewQuestions: $reviewQuestions, ')
          ..write('dailyGoal: $dailyGoal, ')
          ..write('goalAchieved: $goalAchieved, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    date,
    questionsStudied,
    correctAnswers,
    studyTimeSec,
    newQuestions,
    reviewQuestions,
    dailyGoal,
    goalAchieved,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyStat &&
          other.id == this.id &&
          other.date == this.date &&
          other.questionsStudied == this.questionsStudied &&
          other.correctAnswers == this.correctAnswers &&
          other.studyTimeSec == this.studyTimeSec &&
          other.newQuestions == this.newQuestions &&
          other.reviewQuestions == this.reviewQuestions &&
          other.dailyGoal == this.dailyGoal &&
          other.goalAchieved == this.goalAchieved &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DailyStatsCompanion extends UpdateCompanion<DailyStat> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<int> questionsStudied;
  final Value<int> correctAnswers;
  final Value<int> studyTimeSec;
  final Value<int> newQuestions;
  final Value<int> reviewQuestions;
  final Value<int> dailyGoal;
  final Value<bool> goalAchieved;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const DailyStatsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.questionsStudied = const Value.absent(),
    this.correctAnswers = const Value.absent(),
    this.studyTimeSec = const Value.absent(),
    this.newQuestions = const Value.absent(),
    this.reviewQuestions = const Value.absent(),
    this.dailyGoal = const Value.absent(),
    this.goalAchieved = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  DailyStatsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    this.questionsStudied = const Value.absent(),
    this.correctAnswers = const Value.absent(),
    this.studyTimeSec = const Value.absent(),
    this.newQuestions = const Value.absent(),
    this.reviewQuestions = const Value.absent(),
    this.dailyGoal = const Value.absent(),
    this.goalAchieved = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : date = Value(date);
  static Insertable<DailyStat> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<int>? questionsStudied,
    Expression<int>? correctAnswers,
    Expression<int>? studyTimeSec,
    Expression<int>? newQuestions,
    Expression<int>? reviewQuestions,
    Expression<int>? dailyGoal,
    Expression<bool>? goalAchieved,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (questionsStudied != null) 'questions_studied': questionsStudied,
      if (correctAnswers != null) 'correct_answers': correctAnswers,
      if (studyTimeSec != null) 'study_time_sec': studyTimeSec,
      if (newQuestions != null) 'new_questions': newQuestions,
      if (reviewQuestions != null) 'review_questions': reviewQuestions,
      if (dailyGoal != null) 'daily_goal': dailyGoal,
      if (goalAchieved != null) 'goal_achieved': goalAchieved,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  DailyStatsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<int>? questionsStudied,
    Value<int>? correctAnswers,
    Value<int>? studyTimeSec,
    Value<int>? newQuestions,
    Value<int>? reviewQuestions,
    Value<int>? dailyGoal,
    Value<bool>? goalAchieved,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return DailyStatsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      questionsStudied: questionsStudied ?? this.questionsStudied,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      studyTimeSec: studyTimeSec ?? this.studyTimeSec,
      newQuestions: newQuestions ?? this.newQuestions,
      reviewQuestions: reviewQuestions ?? this.reviewQuestions,
      dailyGoal: dailyGoal ?? this.dailyGoal,
      goalAchieved: goalAchieved ?? this.goalAchieved,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (questionsStudied.present) {
      map['questions_studied'] = Variable<int>(questionsStudied.value);
    }
    if (correctAnswers.present) {
      map['correct_answers'] = Variable<int>(correctAnswers.value);
    }
    if (studyTimeSec.present) {
      map['study_time_sec'] = Variable<int>(studyTimeSec.value);
    }
    if (newQuestions.present) {
      map['new_questions'] = Variable<int>(newQuestions.value);
    }
    if (reviewQuestions.present) {
      map['review_questions'] = Variable<int>(reviewQuestions.value);
    }
    if (dailyGoal.present) {
      map['daily_goal'] = Variable<int>(dailyGoal.value);
    }
    if (goalAchieved.present) {
      map['goal_achieved'] = Variable<bool>(goalAchieved.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyStatsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('questionsStudied: $questionsStudied, ')
          ..write('correctAnswers: $correctAnswers, ')
          ..write('studyTimeSec: $studyTimeSec, ')
          ..write('newQuestions: $newQuestions, ')
          ..write('reviewQuestions: $reviewQuestions, ')
          ..write('dailyGoal: $dailyGoal, ')
          ..write('goalAchieved: $goalAchieved, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $UserSettingsTable extends UserSettings
    with TableInfo<$UserSettingsTable, UserSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  UserSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserSetting(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserSettingsTable createAlias(String alias) {
    return $UserSettingsTable(attachedDatabase, alias);
  }
}

class UserSetting extends DataClass implements Insertable<UserSetting> {
  /// 설정 키 (Primary Key)
  final String key;

  /// 설정 값 (문자열, JSON 등)
  final String? value;

  /// 마지막 수정 시간
  final DateTime updatedAt;
  const UserSetting({required this.key, this.value, required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<String>(value);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserSettingsCompanion toCompanion(bool nullToAbsent) {
    return UserSettingsCompanion(
      key: Value(key),
      value: value == null && nullToAbsent
          ? const Value.absent()
          : Value(value),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserSetting(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String?>(json['value']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String?>(value),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserSetting copyWith({
    String? key,
    Value<String?> value = const Value.absent(),
    DateTime? updatedAt,
  }) => UserSetting(
    key: key ?? this.key,
    value: value.present ? value.value : this.value,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserSetting copyWithCompanion(UserSettingsCompanion data) {
    return UserSetting(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserSetting(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserSetting &&
          other.key == this.key &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt);
}

class UserSettingsCompanion extends UpdateCompanion<UserSetting> {
  final Value<String> key;
  final Value<String?> value;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const UserSettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserSettingsCompanion.insert({
    required String key,
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : key = Value(key);
  static Insertable<UserSetting> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserSettingsCompanion copyWith({
    Value<String>? key,
    Value<String?>? value,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return UserSettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserSettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $StudyRecordsTable studyRecords = $StudyRecordsTable(this);
  late final $WrongAnswersTable wrongAnswers = $WrongAnswersTable(this);
  late final $DailyStatsTable dailyStats = $DailyStatsTable(this);
  late final $UserSettingsTable userSettings = $UserSettingsTable(this);
  late final StudyRecordsDao studyRecordsDao = StudyRecordsDao(
    this as AppDatabase,
  );
  late final UserSettingsDao userSettingsDao = UserSettingsDao(
    this as AppDatabase,
  );
  late final DailyStatsDao dailyStatsDao = DailyStatsDao(this as AppDatabase);
  late final WrongAnswersDao wrongAnswersDao = WrongAnswersDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    studyRecords,
    wrongAnswers,
    dailyStats,
    userSettings,
  ];
}

typedef $$StudyRecordsTableCreateCompanionBuilder =
    StudyRecordsCompanion Function({
      Value<int> id,
      required String questionId,
      required String topicId,
      required String levelId,
      Value<int> level,
      Value<int> correctCount,
      Value<int> wrongCount,
      Value<DateTime?> lastStudiedAt,
      Value<DateTime?> nextReviewAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$StudyRecordsTableUpdateCompanionBuilder =
    StudyRecordsCompanion Function({
      Value<int> id,
      Value<String> questionId,
      Value<String> topicId,
      Value<String> levelId,
      Value<int> level,
      Value<int> correctCount,
      Value<int> wrongCount,
      Value<DateTime?> lastStudiedAt,
      Value<DateTime?> nextReviewAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$StudyRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $StudyRecordsTable> {
  $$StudyRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get questionId => $composableBuilder(
    column: $table.questionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get topicId => $composableBuilder(
    column: $table.topicId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get levelId => $composableBuilder(
    column: $table.levelId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wrongCount => $composableBuilder(
    column: $table.wrongCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastStudiedAt => $composableBuilder(
    column: $table.lastStudiedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get nextReviewAt => $composableBuilder(
    column: $table.nextReviewAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StudyRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $StudyRecordsTable> {
  $$StudyRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get questionId => $composableBuilder(
    column: $table.questionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get topicId => $composableBuilder(
    column: $table.topicId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get levelId => $composableBuilder(
    column: $table.levelId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wrongCount => $composableBuilder(
    column: $table.wrongCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastStudiedAt => $composableBuilder(
    column: $table.lastStudiedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get nextReviewAt => $composableBuilder(
    column: $table.nextReviewAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StudyRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudyRecordsTable> {
  $$StudyRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get questionId => $composableBuilder(
    column: $table.questionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get topicId =>
      $composableBuilder(column: $table.topicId, builder: (column) => column);

  GeneratedColumn<String> get levelId =>
      $composableBuilder(column: $table.levelId, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get wrongCount => $composableBuilder(
    column: $table.wrongCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastStudiedAt => $composableBuilder(
    column: $table.lastStudiedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get nextReviewAt => $composableBuilder(
    column: $table.nextReviewAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$StudyRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudyRecordsTable,
          StudyRecord,
          $$StudyRecordsTableFilterComposer,
          $$StudyRecordsTableOrderingComposer,
          $$StudyRecordsTableAnnotationComposer,
          $$StudyRecordsTableCreateCompanionBuilder,
          $$StudyRecordsTableUpdateCompanionBuilder,
          (
            StudyRecord,
            BaseReferences<_$AppDatabase, $StudyRecordsTable, StudyRecord>,
          ),
          StudyRecord,
          PrefetchHooks Function()
        > {
  $$StudyRecordsTableTableManager(_$AppDatabase db, $StudyRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudyRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudyRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudyRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> questionId = const Value.absent(),
                Value<String> topicId = const Value.absent(),
                Value<String> levelId = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int> correctCount = const Value.absent(),
                Value<int> wrongCount = const Value.absent(),
                Value<DateTime?> lastStudiedAt = const Value.absent(),
                Value<DateTime?> nextReviewAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => StudyRecordsCompanion(
                id: id,
                questionId: questionId,
                topicId: topicId,
                levelId: levelId,
                level: level,
                correctCount: correctCount,
                wrongCount: wrongCount,
                lastStudiedAt: lastStudiedAt,
                nextReviewAt: nextReviewAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String questionId,
                required String topicId,
                required String levelId,
                Value<int> level = const Value.absent(),
                Value<int> correctCount = const Value.absent(),
                Value<int> wrongCount = const Value.absent(),
                Value<DateTime?> lastStudiedAt = const Value.absent(),
                Value<DateTime?> nextReviewAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => StudyRecordsCompanion.insert(
                id: id,
                questionId: questionId,
                topicId: topicId,
                levelId: levelId,
                level: level,
                correctCount: correctCount,
                wrongCount: wrongCount,
                lastStudiedAt: lastStudiedAt,
                nextReviewAt: nextReviewAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StudyRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudyRecordsTable,
      StudyRecord,
      $$StudyRecordsTableFilterComposer,
      $$StudyRecordsTableOrderingComposer,
      $$StudyRecordsTableAnnotationComposer,
      $$StudyRecordsTableCreateCompanionBuilder,
      $$StudyRecordsTableUpdateCompanionBuilder,
      (
        StudyRecord,
        BaseReferences<_$AppDatabase, $StudyRecordsTable, StudyRecord>,
      ),
      StudyRecord,
      PrefetchHooks Function()
    >;
typedef $$WrongAnswersTableCreateCompanionBuilder =
    WrongAnswersCompanion Function({
      Value<int> id,
      required String questionId,
      required String topicId,
      required String levelId,
      Value<int> wrongCount,
      Value<String?> lastWrongAnswer,
      required DateTime wrongAt,
      Value<DateTime?> correctedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$WrongAnswersTableUpdateCompanionBuilder =
    WrongAnswersCompanion Function({
      Value<int> id,
      Value<String> questionId,
      Value<String> topicId,
      Value<String> levelId,
      Value<int> wrongCount,
      Value<String?> lastWrongAnswer,
      Value<DateTime> wrongAt,
      Value<DateTime?> correctedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$WrongAnswersTableFilterComposer
    extends Composer<_$AppDatabase, $WrongAnswersTable> {
  $$WrongAnswersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get questionId => $composableBuilder(
    column: $table.questionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get topicId => $composableBuilder(
    column: $table.topicId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get levelId => $composableBuilder(
    column: $table.levelId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wrongCount => $composableBuilder(
    column: $table.wrongCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastWrongAnswer => $composableBuilder(
    column: $table.lastWrongAnswer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get wrongAt => $composableBuilder(
    column: $table.wrongAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get correctedAt => $composableBuilder(
    column: $table.correctedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WrongAnswersTableOrderingComposer
    extends Composer<_$AppDatabase, $WrongAnswersTable> {
  $$WrongAnswersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get questionId => $composableBuilder(
    column: $table.questionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get topicId => $composableBuilder(
    column: $table.topicId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get levelId => $composableBuilder(
    column: $table.levelId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wrongCount => $composableBuilder(
    column: $table.wrongCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastWrongAnswer => $composableBuilder(
    column: $table.lastWrongAnswer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get wrongAt => $composableBuilder(
    column: $table.wrongAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get correctedAt => $composableBuilder(
    column: $table.correctedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WrongAnswersTableAnnotationComposer
    extends Composer<_$AppDatabase, $WrongAnswersTable> {
  $$WrongAnswersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get questionId => $composableBuilder(
    column: $table.questionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get topicId =>
      $composableBuilder(column: $table.topicId, builder: (column) => column);

  GeneratedColumn<String> get levelId =>
      $composableBuilder(column: $table.levelId, builder: (column) => column);

  GeneratedColumn<int> get wrongCount => $composableBuilder(
    column: $table.wrongCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastWrongAnswer => $composableBuilder(
    column: $table.lastWrongAnswer,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get wrongAt =>
      $composableBuilder(column: $table.wrongAt, builder: (column) => column);

  GeneratedColumn<DateTime> get correctedAt => $composableBuilder(
    column: $table.correctedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$WrongAnswersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WrongAnswersTable,
          WrongAnswer,
          $$WrongAnswersTableFilterComposer,
          $$WrongAnswersTableOrderingComposer,
          $$WrongAnswersTableAnnotationComposer,
          $$WrongAnswersTableCreateCompanionBuilder,
          $$WrongAnswersTableUpdateCompanionBuilder,
          (
            WrongAnswer,
            BaseReferences<_$AppDatabase, $WrongAnswersTable, WrongAnswer>,
          ),
          WrongAnswer,
          PrefetchHooks Function()
        > {
  $$WrongAnswersTableTableManager(_$AppDatabase db, $WrongAnswersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WrongAnswersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WrongAnswersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WrongAnswersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> questionId = const Value.absent(),
                Value<String> topicId = const Value.absent(),
                Value<String> levelId = const Value.absent(),
                Value<int> wrongCount = const Value.absent(),
                Value<String?> lastWrongAnswer = const Value.absent(),
                Value<DateTime> wrongAt = const Value.absent(),
                Value<DateTime?> correctedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => WrongAnswersCompanion(
                id: id,
                questionId: questionId,
                topicId: topicId,
                levelId: levelId,
                wrongCount: wrongCount,
                lastWrongAnswer: lastWrongAnswer,
                wrongAt: wrongAt,
                correctedAt: correctedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String questionId,
                required String topicId,
                required String levelId,
                Value<int> wrongCount = const Value.absent(),
                Value<String?> lastWrongAnswer = const Value.absent(),
                required DateTime wrongAt,
                Value<DateTime?> correctedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => WrongAnswersCompanion.insert(
                id: id,
                questionId: questionId,
                topicId: topicId,
                levelId: levelId,
                wrongCount: wrongCount,
                lastWrongAnswer: lastWrongAnswer,
                wrongAt: wrongAt,
                correctedAt: correctedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WrongAnswersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WrongAnswersTable,
      WrongAnswer,
      $$WrongAnswersTableFilterComposer,
      $$WrongAnswersTableOrderingComposer,
      $$WrongAnswersTableAnnotationComposer,
      $$WrongAnswersTableCreateCompanionBuilder,
      $$WrongAnswersTableUpdateCompanionBuilder,
      (
        WrongAnswer,
        BaseReferences<_$AppDatabase, $WrongAnswersTable, WrongAnswer>,
      ),
      WrongAnswer,
      PrefetchHooks Function()
    >;
typedef $$DailyStatsTableCreateCompanionBuilder =
    DailyStatsCompanion Function({
      Value<int> id,
      required DateTime date,
      Value<int> questionsStudied,
      Value<int> correctAnswers,
      Value<int> studyTimeSec,
      Value<int> newQuestions,
      Value<int> reviewQuestions,
      Value<int> dailyGoal,
      Value<bool> goalAchieved,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$DailyStatsTableUpdateCompanionBuilder =
    DailyStatsCompanion Function({
      Value<int> id,
      Value<DateTime> date,
      Value<int> questionsStudied,
      Value<int> correctAnswers,
      Value<int> studyTimeSec,
      Value<int> newQuestions,
      Value<int> reviewQuestions,
      Value<int> dailyGoal,
      Value<bool> goalAchieved,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$DailyStatsTableFilterComposer
    extends Composer<_$AppDatabase, $DailyStatsTable> {
  $$DailyStatsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get questionsStudied => $composableBuilder(
    column: $table.questionsStudied,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correctAnswers => $composableBuilder(
    column: $table.correctAnswers,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get studyTimeSec => $composableBuilder(
    column: $table.studyTimeSec,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get newQuestions => $composableBuilder(
    column: $table.newQuestions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reviewQuestions => $composableBuilder(
    column: $table.reviewQuestions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dailyGoal => $composableBuilder(
    column: $table.dailyGoal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get goalAchieved => $composableBuilder(
    column: $table.goalAchieved,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyStatsTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyStatsTable> {
  $$DailyStatsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get questionsStudied => $composableBuilder(
    column: $table.questionsStudied,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correctAnswers => $composableBuilder(
    column: $table.correctAnswers,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get studyTimeSec => $composableBuilder(
    column: $table.studyTimeSec,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get newQuestions => $composableBuilder(
    column: $table.newQuestions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reviewQuestions => $composableBuilder(
    column: $table.reviewQuestions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dailyGoal => $composableBuilder(
    column: $table.dailyGoal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get goalAchieved => $composableBuilder(
    column: $table.goalAchieved,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyStatsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyStatsTable> {
  $$DailyStatsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get questionsStudied => $composableBuilder(
    column: $table.questionsStudied,
    builder: (column) => column,
  );

  GeneratedColumn<int> get correctAnswers => $composableBuilder(
    column: $table.correctAnswers,
    builder: (column) => column,
  );

  GeneratedColumn<int> get studyTimeSec => $composableBuilder(
    column: $table.studyTimeSec,
    builder: (column) => column,
  );

  GeneratedColumn<int> get newQuestions => $composableBuilder(
    column: $table.newQuestions,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reviewQuestions => $composableBuilder(
    column: $table.reviewQuestions,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dailyGoal =>
      $composableBuilder(column: $table.dailyGoal, builder: (column) => column);

  GeneratedColumn<bool> get goalAchieved => $composableBuilder(
    column: $table.goalAchieved,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DailyStatsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyStatsTable,
          DailyStat,
          $$DailyStatsTableFilterComposer,
          $$DailyStatsTableOrderingComposer,
          $$DailyStatsTableAnnotationComposer,
          $$DailyStatsTableCreateCompanionBuilder,
          $$DailyStatsTableUpdateCompanionBuilder,
          (
            DailyStat,
            BaseReferences<_$AppDatabase, $DailyStatsTable, DailyStat>,
          ),
          DailyStat,
          PrefetchHooks Function()
        > {
  $$DailyStatsTableTableManager(_$AppDatabase db, $DailyStatsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyStatsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyStatsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyStatsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> questionsStudied = const Value.absent(),
                Value<int> correctAnswers = const Value.absent(),
                Value<int> studyTimeSec = const Value.absent(),
                Value<int> newQuestions = const Value.absent(),
                Value<int> reviewQuestions = const Value.absent(),
                Value<int> dailyGoal = const Value.absent(),
                Value<bool> goalAchieved = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => DailyStatsCompanion(
                id: id,
                date: date,
                questionsStudied: questionsStudied,
                correctAnswers: correctAnswers,
                studyTimeSec: studyTimeSec,
                newQuestions: newQuestions,
                reviewQuestions: reviewQuestions,
                dailyGoal: dailyGoal,
                goalAchieved: goalAchieved,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                Value<int> questionsStudied = const Value.absent(),
                Value<int> correctAnswers = const Value.absent(),
                Value<int> studyTimeSec = const Value.absent(),
                Value<int> newQuestions = const Value.absent(),
                Value<int> reviewQuestions = const Value.absent(),
                Value<int> dailyGoal = const Value.absent(),
                Value<bool> goalAchieved = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => DailyStatsCompanion.insert(
                id: id,
                date: date,
                questionsStudied: questionsStudied,
                correctAnswers: correctAnswers,
                studyTimeSec: studyTimeSec,
                newQuestions: newQuestions,
                reviewQuestions: reviewQuestions,
                dailyGoal: dailyGoal,
                goalAchieved: goalAchieved,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyStatsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyStatsTable,
      DailyStat,
      $$DailyStatsTableFilterComposer,
      $$DailyStatsTableOrderingComposer,
      $$DailyStatsTableAnnotationComposer,
      $$DailyStatsTableCreateCompanionBuilder,
      $$DailyStatsTableUpdateCompanionBuilder,
      (DailyStat, BaseReferences<_$AppDatabase, $DailyStatsTable, DailyStat>),
      DailyStat,
      PrefetchHooks Function()
    >;
typedef $$UserSettingsTableCreateCompanionBuilder =
    UserSettingsCompanion Function({
      required String key,
      Value<String?> value,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$UserSettingsTableUpdateCompanionBuilder =
    UserSettingsCompanion Function({
      Value<String> key,
      Value<String?> value,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$UserSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $UserSettingsTable> {
  $$UserSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserSettingsTable> {
  $$UserSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserSettingsTable> {
  $$UserSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UserSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserSettingsTable,
          UserSetting,
          $$UserSettingsTableFilterComposer,
          $$UserSettingsTableOrderingComposer,
          $$UserSettingsTableAnnotationComposer,
          $$UserSettingsTableCreateCompanionBuilder,
          $$UserSettingsTableUpdateCompanionBuilder,
          (
            UserSetting,
            BaseReferences<_$AppDatabase, $UserSettingsTable, UserSetting>,
          ),
          UserSetting,
          PrefetchHooks Function()
        > {
  $$UserSettingsTableTableManager(_$AppDatabase db, $UserSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String?> value = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserSettingsCompanion(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                Value<String?> value = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserSettingsCompanion.insert(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserSettingsTable,
      UserSetting,
      $$UserSettingsTableFilterComposer,
      $$UserSettingsTableOrderingComposer,
      $$UserSettingsTableAnnotationComposer,
      $$UserSettingsTableCreateCompanionBuilder,
      $$UserSettingsTableUpdateCompanionBuilder,
      (
        UserSetting,
        BaseReferences<_$AppDatabase, $UserSettingsTable, UserSetting>,
      ),
      UserSetting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$StudyRecordsTableTableManager get studyRecords =>
      $$StudyRecordsTableTableManager(_db, _db.studyRecords);
  $$WrongAnswersTableTableManager get wrongAnswers =>
      $$WrongAnswersTableTableManager(_db, _db.wrongAnswers);
  $$DailyStatsTableTableManager get dailyStats =>
      $$DailyStatsTableTableManager(_db, _db.dailyStats);
  $$UserSettingsTableTableManager get userSettings =>
      $$UserSettingsTableTableManager(_db, _db.userSettings);
}
