import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/database/database.dart';
import 'package:quiz_app/models/quiz.dart';
import 'package:quiz_app/services/firebase_service.dart';

import '../models/category.dart';

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





  // CATEGORY METHODS
  // Convert from Firebase Category to Drift CategoriesTableCompanion
  CategoriesTableCompanion _convertCategoryToCompanion(Category category) {
    return CategoriesTableCompanion(
      id: Value(category.id ?? ''),
      name: Value(category.name),
      thumbnailUrl: Value(category.thumbnailUrl),
      quizCount: Value(category.quizCount),
      featured: Value(category.featured),
    );
  }

  // Convert from Drift CategoriesTableData to Firebase Category
  Category _convertCategoryToDomainModel(CategoriesTableData data) {
    return Category(
      name: data.name ?? '',
      id: data.id,
      thumbnailUrl: data.thumbnailUrl,
      quizCount: data.quizCount,
      featured: data.featured,
    );
  }

  // Fetch categories from Firestore and save to local database
  Future<List<Category>> syncAndGetAllCategories() async {
    try {
      // Fetch categories from Firebase
      debugPrint('Fetching categories from Firebase...');
      List<Category> firebaseCategories = await _firebaseService.getCategories();

      // Convert and save all categories to the local database
      debugPrint('Converting and saving ${firebaseCategories.length} categories to local database...');
      List<CategoriesTableCompanion> companions =
      firebaseCategories.map((category) => _convertCategoryToCompanion(category)).toList();

      await _database.insertCategories(companions);

      // Fetch all categories from local database
      debugPrint('Retrieving categories from local database...');
      List<CategoriesTableData> localCategoriesData = await _database.getAllCategories();
      List<Category> localCategories = localCategoriesData.map(_convertCategoryToDomainModel).toList();

      debugPrint('Synced ${firebaseCategories.length} categories to local database');
      debugPrint('Total categories in local database: ${localCategories.length}');

      // Print all categories for debugging
      for (var category in localCategories) {
        debugPrint('- Name: ${category.name}, ID: ${category.id}, Quiz Count: ${category.quizCount}');
      }

      return localCategories;
    } catch (e) {
      debugPrint('Error syncing categories: $e');
      return [];
    }
  }

  // Get all categories from local database
  Future<List<Category>> getAllCategories() async {
    try {
      List<CategoriesTableData> data = await _database.getAllCategories();
      return data.map(_convertCategoryToDomainModel).toList();
    } catch (e) {
      debugPrint('Error getting categories from local database: $e');
      return [];
    }
  }

  // Get a specific category with all its quizzes
  Future<Map<String, dynamic>> getCategoryWithQuizzes(String categoryId) async {
    try {
      CategoryWithQuizzes result = await _database.getCategoryWithQuizzes(categoryId);

      Category category = _convertCategoryToDomainModel(result.category);
      List<Quiz> quizzes = result.quizzes.map(_convertToDomainModel).toList();

      return {
        'category': category,
        'quizzes': quizzes,
      };
    } catch (e) {
      debugPrint('Error getting category with quizzes: $e');
      return {
        'category': null,
        'quizzes': <Quiz>[],
      };
    }
  }



  Future<void> syncAll() async {
    await syncAndGetAllCategories();
    await syncAndGetAllQuizzes();
  }


  // Close the database
  void close() {
    _database.close();
  }
}