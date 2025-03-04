import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/database/database.dart';
import 'package:quiz_app/models/quiz.dart';
import 'package:quiz_app/services/firebase_service.dart';

class DriftService {
  static final DriftService _instance = DriftService._internal();
  factory DriftService() => _instance;
  DriftService._internal();

  final QuizDatabase _database = QuizDatabase();
  final FirebaseService _firebaseService = FirebaseService();

  // Convert from Firebase Quiz to Drift QuizzesTableCompanion
  QuizzesTableCompanion _convertToCompanion(Quiz quiz) {
    return QuizzesTableCompanion(
      id: Value(quiz.id),
      name: Value(quiz.name),
      thumbnailUrl: Value(quiz.thumbnailUrl),
      parentId: Value(quiz.parentId),
      timer: Value(quiz.timer),
      quizTime: Value(quiz.quizTime),
      description: Value(quiz.description),
      questionCount: Value(quiz.questionCount),
      pointsRequired: Value(quiz.pointsRequired),
      questionOrder: Value(quiz.questionOrder),
      index: Value(quiz.index),
    );
  }

  // Convert from Drift QuizzesTableData to Firebase Quiz
  Quiz _convertToDomainModel(QuizzesTableData data) {
    return Quiz(
      name: data.name ?? '',
      id: data.id ?? '',
      thumbnailUrl: data.thumbnailUrl ?? '',
      parentId: data.parentId ?? '',
      timer: data.timer ?? false,
      quizTime: data.quizTime,
      description: data.description ?? '',
      questionCount: data.questionCount,
      pointsRequired: data.pointsRequired,
      questionOrder: data.questionOrder,
      index: data.index,
    );
  }

  // Fetch quizzes from Firestore and save to local database
  Future<List<Quiz>> syncAndGetAllQuizzes() async {
    try {
      // Fetch quizzes from Firebase
      debugPrint('Fetching quizzes from Firebase...');
      List<Quiz> firebaseQuizzes = await _firebaseService.getQuizes();

      // Convert and save all quizzes to the local database
      debugPrint('Converting and saving ${firebaseQuizzes.length} quizzes to local database...');
      List<QuizzesTableCompanion> companions =
      firebaseQuizzes.map((quiz) => _convertToCompanion(quiz)).toList();

      await _database.insertQuizzes(companions);

      // Fetch all quizzes from local database
      debugPrint('Retrieving quizzes from local database...');
      List<QuizzesTableData> localQuizzesData = await _database.getAllQuizzes();
      List<Quiz> localQuizzes = localQuizzesData.map(_convertToDomainModel).toList();

      debugPrint('Synced ${firebaseQuizzes.length} quizzes to local database');
      debugPrint('Total quizzes in local database: ${localQuizzes.length}');

      // Print all quizzes for debugging
      for (var quiz in localQuizzes) {
        debugPrint('- Name: ${quiz.name}, ID: ${quiz.id}, Parent ID: ${quiz.parentId}');
      }

      return localQuizzes;
    } catch (e) {
      debugPrint('Error syncing quizzes: $e');
      return [];
    }
  }

  // Get all quizzes from local database
  Future<List<Quiz>> getAllQuizzes() async {
    try {
      List<QuizzesTableData> data = await _database.getAllQuizzes();
      return data.map(_convertToDomainModel).toList();
    } catch (e) {
      debugPrint('Error getting quizzes from local database: $e');
      return [];
    }
  }

  // Close the database
  void close() {
    _database.close();
  }
}