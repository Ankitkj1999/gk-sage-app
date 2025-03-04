import 'package:drift/drift.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:drift/native.dart';
import 'tables.dart';

part 'database.g.dart'; // This will be generated

@DriftDatabase(tables: [QuizzesTable])
class QuizDatabase extends _$QuizDatabase {
  QuizDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

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
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'quiz_app.sqlite'));
    return NativeDatabase(file);
  });
}