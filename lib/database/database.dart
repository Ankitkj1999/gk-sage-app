import 'package:drift/drift.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:drift/native.dart';
import 'tables.dart';

part 'database.g.dart'; // This will be generated

@DriftDatabase(tables: [CategoriesTable, QuizzesTable, QuestionsTable])

class QuizDatabase extends _$QuizDatabase {
  QuizDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    // Called when the database is created for the first time
    onCreate: (Migrator m) async {
      await m.createAll();
    },
    // Called when the database needs to be upgraded
    onUpgrade: (Migrator m, int from, int to) async {
      if (from == 1) {
        // If upgrading from version 1, create both new tables
        await m.createTable(categoriesTable);
        await m.createTable(questionsTable);
      }
    },
    // Called after migrations have run
    beforeOpen: (details) async {
      // You can add any validation or cleanup here
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  // Methods for Categories
  Future<int> insertOrUpdateCategory(CategoriesTableCompanion category) async {
    return await into(categoriesTable).insertOnConflictUpdate(category);
  }

  Future<void> insertCategories(List<CategoriesTableCompanion> categories) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(categoriesTable, categories);
    });
  }

  Future<List<CategoriesTableData>> getAllCategories() async {
    return await select(categoriesTable).get();
  }

  // Advanced query: Get a category with all its quizzes
  Future<CategoryWithQuizzes> getCategoryWithQuizzes(String categoryId) async {
    final category = await (select(categoriesTable)..where((c) => c.id.equals(categoryId))).getSingle();
    final quizzes = await (select(quizzesTable)..where((q) => q.parentId.equals(categoryId))).get();
    return CategoryWithQuizzes(category, quizzes);
  }

  // Get all categories with their quizzes
  Future<List<CategoryWithQuizzes>> getAllCategoriesWithQuizzes() async {
    final categories = await select(categoriesTable).get();
    List<CategoryWithQuizzes> result = [];

    for (var category in categories) {
      final quizzes = await (select(quizzesTable)..where((q) => q.parentId.equals(category.id))).get();
      result.add(CategoryWithQuizzes(category, quizzes));
    }

    return result;
  }

  // Insert a quiz or update if already exists
  Future<int> insertOrUpdateQuiz(QuizzesTableCompanion quiz) async {
    return await into(quizzesTable).insertOnConflictUpdate(quiz);
  }

  // Insert multiple quizzes
  Future<void> insertQuizzes(List<QuizzesTableCompanion> quizzes) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(quizzesTable, quizzes);
    });
  }

  // Get all quizzes
  Future<List<QuizzesTableData>> getAllQuizzes() async {
    return await select(quizzesTable).get();
  }

  // Clear all quizzes
  Future<int> clearAllQuizzes() async {
    return await delete(quizzesTable).go();
  }

// Method for Questions

  Future<int> insertOrUpdateQuestion(QuestionsTableCompanion question) async {
    return await into(questionsTable).insertOnConflictUpdate(question);
  }

  Future<void> insertQuestions(List<QuestionsTableCompanion> questions) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(questionsTable, questions);
    });
  }

  Future<List<QuestionsTableData>> getQuestionsForQuiz(String quizId) async {
    return await (select(questionsTable)
      ..where((q) => q.quizId.equals(quizId)))
        .get();
  }

  Future<List<QuestionsTableData>> getAllQuestions() async {
    return await select(questionsTable).get();
  }

  // Get random questions from the database
  // Future<List<QuestionsTableData>> getRandomQuestions({
  //   int count = 10,
  //   List<String>? excludeIds,
  //   String? categoryId
  // }) async {
  //   // Start building the query
  //   var query = select(questionsTable)
  //     ..orderBy([(t) => OrderingTerm.random()])
  //     ..limit(count);
  //
  //   // Add exclusion filter if needed
  //   if (excludeIds != null && excludeIds.isNotEmpty) {
  //     query.where((tbl) => tbl.id.isNotIn(excludeIds));
  //   }
  //
  //   // Add category filter if needed
  //   if (categoryId != null) {
  //     query.where((tbl) => tbl.catId.equals(categoryId));
  //   }
  //
  //   // Execute the query
  //   return query.get();
  // }

// the random questions method
  Future<List<QuestionsTableData>> getRandomQuestionsFromDb({
    int count = 10,
    List<String>? excludeIds,
    String? categoryId
  }) async {
    // Build the query conditions
    String query = 'SELECT * FROM questions_table';
    final List<Variable> variables = [];

    // Add WHERE clause for excluded IDs
    if (excludeIds != null && excludeIds.isNotEmpty) {
      query += ' WHERE id NOT IN (${excludeIds.map((_) => '?').join(', ')})';
      variables.addAll(excludeIds.map((id) => Variable.withString(id)));
    }

    // Add category filter
    if (categoryId != null && categoryId.isNotEmpty) {
      if (excludeIds != null && excludeIds.isNotEmpty) {
        query += ' AND cat_id = ?';
      } else {
        query += ' WHERE cat_id = ?';
      }
      variables.add(Variable.withString(categoryId));
    }

    // Add ordering and limit
    query += ' ORDER BY RANDOM() LIMIT ?';
    variables.add(Variable.withInt(count));

    // Execute the query
    final rows = await customSelect(
      query,
      variables: variables,
      readsFrom: {questionsTable},
    ).get();

    // Convert the rows to QuestionsTableData objects - manually mapping
    return rows.map((row) => QuestionsTableData(
      id: row.read<String>('id'),
      quizId: row.read<String>('quiz_id'),
      catId: row.read<String>('cat_id'),
      questionTitle: row.read<String>('question_title'),
      options: row.read<String?>('options'),
      correctAnswerIndex: row.read<int?>('correct_answer_index'),
      hasFourOptions: row.read<bool?>('has_four_options'),
      questionType: row.read<String?>('question_type'),
      questionImageUrl: row.read<String?>('question_image_url'),
      questionAudioUrl: row.read<String?>('question_audio_url'),
      questionVideoUrl: row.read<String?>('question_video_url'),
      explaination: row.read<String?>('explaination'),
      optionsType: row.read<String?>('options_type'),
      createdAt: row.read<int?>('created_at'),
    )).toList();
  }

}



LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'quiz_app.sqlite'));
    return NativeDatabase(file);
  });
}




// Data class to represent a category with its quizzes
class CategoryWithQuizzes {
  final CategoriesTableData category;
  final List<QuizzesTableData> quizzes;

  CategoryWithQuizzes(this.category, this.quizzes);
}