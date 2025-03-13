import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/database/database.dart';
import 'package:quiz_app/models/quiz.dart';
import 'package:quiz_app/services/firebase_service.dart';

import '../models/category.dart';
import '../models/question.dart';
import '../models/user.dart';

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


  // Convert from Firebase UserModel to Drift UsersTableCompanion
  UsersTableCompanion _convertUserToCompanion(UserModel user) {
    return UsersTableCompanion(
      uid: Value(user.uid ?? ''),
      name: Value(user.name),
      email: Value(user.email),
      avatarString: Value(user.avatarString),
      createdAt: Value(user.createdAt?.millisecondsSinceEpoch),
      updatedAt: Value(user.updatedAt?.millisecondsSinceEpoch),
      points: Value(user.points ?? 0),
      disabled: Value(user.disabled ?? false),
      savedItems: Value(user.savedItems != null ? jsonEncode(user.savedItems) : null),
      totalQuizPlayed: Value(user.totalQuizPlayed ?? 0),
      totalQuestionAnswered: Value(user.totalQuestionAnswered ?? 0),
      totalCorrectAns: Value(user.totalCorrectAns ?? 0),
      totalIncorrectAns: Value(user.totalIncorrectAns ?? 0),
      strength: Value(user.strength),
      imageUrl: Value(user.imageUrl),
      pointsHistory: Value(user.pointsHistory != null ? jsonEncode(user.pointsHistory) : null),
      bookmarkedQuestions: Value(user.bookmarkedQuestions != null ? jsonEncode(user.bookmarkedQuestions) : null),
      completedQuizzes: Value(user.completedQuizzes != null ? jsonEncode(user.completedQuizzes) : null),
    );
  }

// Convert from Drift UsersTableData to Firebase UserModel
  UserModel _convertUserToDomainModel(UsersTableData data) {
    return UserModel(
      uid: data.uid,
      name: data.name,
      email: data.email,
      avatarString: data.avatarString,
      createdAt: data.createdAt != null ? Timestamp.fromMillisecondsSinceEpoch(data.createdAt!) : null,
      updatedAt: data.updatedAt != null ? Timestamp.fromMillisecondsSinceEpoch(data.updatedAt!) : null,
      points: data.points,
      disabled: data.disabled,
      savedItems: data.savedItems != null ? jsonDecode(data.savedItems!) : [],
      totalQuizPlayed: data.totalQuizPlayed,
      totalQuestionAnswered: data.totalQuestionAnswered,
      totalCorrectAns: data.totalCorrectAns,
      totalIncorrectAns: data.totalIncorrectAns,
      strength: data.strength,
      imageUrl: data.imageUrl,
      pointsHistory: data.pointsHistory != null ? jsonDecode(data.pointsHistory!) : [],
      bookmarkedQuestions: data.bookmarkedQuestions != null ? jsonDecode(data.bookmarkedQuestions!) : [],
      completedQuizzes: data.completedQuizzes != null ? jsonDecode(data.completedQuizzes!) : [],
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

  // QUESTION METHODS
  // Convert from Firebase Question to Drift QuestionsTableCompanion
  QuestionsTableCompanion _convertQuestionToCompanion(Question question) {
    // Convert the options list to a JSON string
    String? optionsJson;
    if (question.options != null) {
      optionsJson = jsonEncode(question.options);
    }

    // Convert Timestamp to milliseconds since epoch
    int? createdAtMillis;
    if (question.createdAt != null) {
      createdAtMillis = question.createdAt!.millisecondsSinceEpoch;
    }

    return QuestionsTableCompanion(
      id: Value(question.id ?? ''),
      quizId: Value(question.quizId ?? ''),
      catId: Value(question.catId),
      questionTitle: Value(question.questionTitle),
      options: Value(optionsJson),
      correctAnswerIndex: Value(question.correctAnswerIndex),
      hasFourOptions: Value(question.hasFourOptions),
      questionType: Value(question.questionType),
      questionImageUrl: Value(question.questionImageUrl),
      questionAudioUrl: Value(question.questionAudioUrl),
      questionVideoUrl: Value(question.questionVideoUrl),
      explaination: Value(question.explaination),
      optionsType: Value(question.optionsType),
      createdAt: Value(createdAtMillis),
    );
  }

  // Convert from Drift QuestionsTableData to Firebase Question
  Question _convertQuestionToDomainModel(QuestionsTableData data) {
    // Convert JSON string back to list
    List? options;
    if (data.options != null) {
      options = jsonDecode(data.options!);
    }

    // Convert milliseconds to Timestamp
    Timestamp? createdAt;
    if (data.createdAt != null) {
      createdAt = Timestamp.fromMillisecondsSinceEpoch(data.createdAt!);
    }

    return Question(
      id: data.id,
      quizId: data.quizId,
      catId: data.catId,
      questionTitle: data.questionTitle,
      options: options,
      correctAnswerIndex: data.correctAnswerIndex,
      hasFourOptions: data.hasFourOptions,
      questionType: data.questionType,
      questionImageUrl: data.questionImageUrl,
      questionAudioUrl: data.questionAudioUrl,
      questionVideoUrl: data.questionVideoUrl,
      explaination: data.explaination,
      optionsType: data.optionsType,
      createdAt: createdAt,
    );
  }

  // Fetch questions for a quiz from Firebase and save to local database
  Future<List<Question>> syncAndGetQuestionsForQuiz(String quizId) async {
    try {
      debugPrint('Fetching questions for quiz $quizId from Firebase...');
      List<Question> firebaseQuestions = await _firebaseService.getQuestions(quizId);

      debugPrint('Converting and saving ${firebaseQuestions.length} questions to local database...');
      List<QuestionsTableCompanion> companions =
      firebaseQuestions.map(_convertQuestionToCompanion).toList();

      await _database.insertQuestions(companions);

      // Fetch questions from local database to verify
      List<QuestionsTableData> localQuestionsData = await _database.getQuestionsForQuiz(quizId);
      List<Question> localQuestions = localQuestionsData.map(_convertQuestionToDomainModel).toList();

      debugPrint('Synced ${firebaseQuestions.length} questions for quiz $quizId');

      return localQuestions;
    } catch (e) {
      debugPrint('Error syncing questions: $e');
      return [];
    }
  }

  // Get questions for a quiz from local database only
  Future<List<Question>> getQuestionsForQuiz(String quizId) async {
    try {
      List<QuestionsTableData> data = await _database.getQuestionsForQuiz(quizId);
      return data.map(_convertQuestionToDomainModel).toList();
    } catch (e) {
      debugPrint('Error getting questions from local database: $e');
      return [];
    }
  }

  // Sync questions for multiple quizzes with batch processing
  Future<void> syncQuestionsForAllQuizzes({int batchSize = 3}) async {
    try {
      // Get all quizzes from local database
      List<Quiz> quizzes = await getAllQuizzes();
      debugPrint('Starting to sync questions for ${quizzes.length} quizzes');

      // Process in batches to avoid memory issues
      for (int i = 0; i < quizzes.length; i += batchSize) {
        // Calculate end index for current batch
        int end = (i + batchSize < quizzes.length) ? i + batchSize : quizzes.length;
        List<Quiz> batch = quizzes.sublist(i, end);

        // Process each quiz in the batch concurrently
        await Future.wait(
            batch.map((quiz) async {
              debugPrint('Syncing questions for quiz: ${quiz.name} (${quiz.id})');
              await syncAndGetQuestionsForQuiz(quiz.id ?? '');
            })
        );

        // Optionally add a delay between batches to reduce network pressure
        if (end < quizzes.length) {
          await Future.delayed(const Duration(milliseconds: 500));
        }
      }

      debugPrint('Completed syncing questions for all quizzes');
    } catch (e) {
      debugPrint('Error syncing questions for quizzes: $e');
    }
  }

  // Get the count of questions stored locally for a quiz
  Future<int> getLocalQuestionCount(String quizId) async {
    try {
      List<QuestionsTableData> data = await _database.getQuestionsForQuiz(quizId);
      return data.length;
    } catch (e) {
      debugPrint('Error getting question count: $e');
      return 0;
    }
  }

  // Fetch a batch of random questions from local database
// Add this method to your DriftService class (not inside QuizDatabase)

// Inside your DriftService class:
// In your DriftService class
  Future<List<Question>> getRandomQuestions({
    int count = 10,
    List<String>? excludeIds,
    String? categoryId
  }) async {
    try {
      debugPrint('Fetching $count random questions...');
      if (excludeIds != null) {
        debugPrint('Excluding ${excludeIds.length} questions that were already shown');
      }

      // Get the questions from database with appropriate filters
      final List<QuestionsTableData> data = await _database.getRandomQuestionsFromDb(
          count: count,
          excludeIds: excludeIds,
          categoryId: categoryId
      );

      debugPrint('Found ${data.length} random questions');

      // Convert database models to domain models using your existing conversion method
      final List<Question> questions = data.map(_convertQuestionToDomainModel).toList();

      return questions;
    } catch (e) {
      debugPrint('Error getting random questions: $e');
      return <Question>[];
    }
  }


  // Sync user data from Firebase to local database
  Future<UserModel?> syncAndGetUserData(String uid) async {
    try {
      debugPrint('❗ STARTING user data sync for UID: $uid');

      // Step 1: Fetch from Firebase
      debugPrint('❗ Attempting to fetch user data from Firebase...');
      UserModel? firebaseUser = await _firebaseService.getUserData();

      if (firebaseUser == null) {
        debugPrint('❗ ERROR: Firebase returned null user data');
        return null;
      }

      debugPrint('❗ SUCCESS: Firebase user data received: ${firebaseUser.uid}, ${firebaseUser.name}');

      if (firebaseUser.uid == null) {
        debugPrint('❗ ERROR: Firebase user has null UID');
        return null;
      }

      // Step 2: Convert to Drift model
      debugPrint('❗ Converting Firebase user to Drift companion');
      UsersTableCompanion companion;
      try {
        companion = _convertUserToCompanion(firebaseUser);
        debugPrint('❗ SUCCESS: Conversion completed');
      } catch (e) {
        debugPrint('❗ ERROR during model conversion: $e');
        return null;
      }

      // Step 3: Save to Drift
      debugPrint('❗ Attempting to save user data to Drift database');
      try {
        final result = await _database.insertOrUpdateUser(companion);
        debugPrint('❗ Drift insert result: $result');
      } catch (e) {
        debugPrint('❗ ERROR inserting into Drift: $e');
        return null;
      }

      // Step 4: Verify by retrieving from Drift
      debugPrint('❗ Verifying by retrieving user from Drift');
      UsersTableData? localUserData;
      try {
        localUserData = await _database.getUserByUid(uid);
        if (localUserData == null) {
          debugPrint('❗ ERROR: Retrieved null user from Drift after insertion');
          return null;
        }
        debugPrint('❗ SUCCESS: Retrieved user from Drift: ${localUserData.uid}, ${localUserData.name}');
      } catch (e) {
        debugPrint('❗ ERROR retrieving from Drift: $e');
        return null;
      }

      // Step 5: Convert back to domain model
      debugPrint('❗ Converting Drift data back to domain model');
      UserModel localUser;
      try {
        localUser = _convertUserToDomainModel(localUserData);
        debugPrint('❗ SUCCESS: Conversion back to domain model complete');
      } catch (e) {
        debugPrint('❗ ERROR converting back to domain model: $e');
        return null;
      }

      debugPrint('❗ User data sync COMPLETE for UID: $uid');
      return localUser;

    } catch (e) {
      debugPrint('❗ CRITICAL ERROR in syncAndGetUserData: $e');
      return null;
    }
  }

// Get user data from local database
  Future<UserModel?> getUserData(String uid) async {
    try {
      UsersTableData? data = await _database.getUserByUid(uid);
      return data != null ? _convertUserToDomainModel(data) : null;
    } catch (e) {
      debugPrint('Error getting user data from local database: $e');
      return null;
    }
  }

// Update user points locally
  Future<bool> updateUserPoints(String uid, int newPoints) async {
    try {
      return await _database.updateUserPoints(uid, newPoints);
    } catch (e) {
      debugPrint('Error updating user points in local database: $e');
      return false;
    }
  }

// Add point history entry locally
  Future<bool> addPointHistoryEntry(String uid, String entry) async {
    try {
      return await _database.appendToPointHistory(uid, entry);
    } catch (e) {
      debugPrint('Error adding point history in local database: $e');
      return false;
    }
  }

// Add bookmark locally
  Future<bool> addBookmark(String uid, String questionId) async {
    try {
      return await _database.addBookmark(uid, questionId);
    } catch (e) {
      debugPrint('Error adding bookmark in local database: $e');
      return false;
    }
  }


  // Add to DriftService class
  Future<bool> updateUserQuizStats(String uid, {required bool isCorrect}) async {
    try {
      final user = await _database.getUserByUid(uid);
      if (user == null) return false;

      // Update stats based on whether answer was correct
      final rowsAffected = await (_database.update(_database.usersTable)..where((u) => u.uid.equals(uid)))
          .write(UsersTableCompanion(
          totalQuestionAnswered: Value(user.totalQuestionAnswered + 1),
          totalCorrectAns: isCorrect ? Value(user.totalCorrectAns + 1) : Value(user.totalCorrectAns),
          totalIncorrectAns: !isCorrect ? Value(user.totalIncorrectAns + 1) : Value(user.totalIncorrectAns),
          // Recalculate strength
          strength: Value(_calculateStrength(
              user.totalQuestionAnswered + 1,
              isCorrect ? user.totalCorrectAns + 1 : user.totalCorrectAns
          )),
          updatedAt: Value(DateTime.now().millisecondsSinceEpoch)
      ));
      return rowsAffected > 0;
    } catch (e) {
      debugPrint('Error updating user quiz stats: $e');
      return false;
    }
  }

// Helper for calculating strength
  double _calculateStrength(int questionCount, int correctCount) {
    if (questionCount == 0) return 0.0;
    double s = correctCount / questionCount * 100;
    return s.isNaN ? 0.0 : s;
  }


  Future<void> syncAll() async {
    await syncAndGetAllCategories();
    await syncAndGetAllQuizzes();
    // Note: We don't sync all questions at once as that could be too much data
    // Questions are synced on-demand when needed for a specific quiz
  }

  // Close the database
  void close() {
    _database.close();
  }
}