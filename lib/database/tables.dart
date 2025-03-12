import 'package:drift/drift.dart';

class QuizzesTable extends Table {
  TextColumn get id => text().nullable()();
  TextColumn get name => text().nullable()();
  TextColumn get thumbnailUrl => text().named('image_url').nullable()();
  TextColumn get parentId => text().named('parent_id').nullable().references(CategoriesTable, #id)();
  BoolColumn get timer => boolean().nullable()();
  IntColumn get quizTime => integer().named('quiz_time').nullable()();
  TextColumn get description => text().nullable()();
  IntColumn get questionCount => integer().named('question_count').nullable()();
  IntColumn get pointsRequired => integer().named('points_required').nullable()();
  TextColumn get questionOrder => text().named('question_order').nullable()();
  IntColumn get index => integer().nullable().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}


class CategoriesTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().nullable()();
  TextColumn get thumbnailUrl => text().named('image_url').nullable()();
  IntColumn get quizCount => integer().named('quiz_count').nullable()();
  BoolColumn get featured => boolean().nullable().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}


class QuestionsTable extends Table {
  TextColumn get id => text()();
  TextColumn get quizId => text().references(QuizzesTable, #id)();
  TextColumn get catId => text().nullable()();
  TextColumn get questionTitle => text().nullable()();
  // Store serialized JSON for options list
  TextColumn get options => text().nullable()();
  IntColumn get correctAnswerIndex => integer().nullable()();
  BoolColumn get hasFourOptions => boolean().nullable()();
  TextColumn get questionType => text().nullable()();
  TextColumn get questionImageUrl => text().nullable()();
  TextColumn get questionAudioUrl => text().nullable()();
  TextColumn get questionVideoUrl => text().nullable()();
  TextColumn get explaination => text().nullable()();
  TextColumn get optionsType => text().nullable()();
  // Store timestamp as milliseconds
  IntColumn get createdAt => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class UsersTable extends Table {
  TextColumn get uid => text()();
  TextColumn get name => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get avatarString => text().nullable()();
  IntColumn get createdAt => integer().nullable()(); // Store Timestamp as milliseconds
  IntColumn get updatedAt => integer().nullable()(); // Store Timestamp as milliseconds
  IntColumn get points => integer().withDefault(const Constant(0))();
  BoolColumn get disabled => boolean().withDefault(const Constant(false))();
  TextColumn get savedItems => text().nullable()(); // Store as JSON string
  IntColumn get totalQuizPlayed => integer().withDefault(const Constant(0))();
  IntColumn get totalQuestionAnswered => integer().withDefault(const Constant(0))();
  IntColumn get totalCorrectAns => integer().withDefault(const Constant(0))();
  IntColumn get totalIncorrectAns => integer().withDefault(const Constant(0))();
  RealColumn get strength => real().nullable()();
  TextColumn get imageUrl => text().nullable()();
  TextColumn get pointsHistory => text().nullable()(); // Store as JSON string
  TextColumn get bookmarkedQuestions => text().nullable()(); // Store as JSON string
  TextColumn get completedQuizzes => text().nullable()(); // Store as JSON string

  @override
  Set<Column> get primaryKey => {uid};
}