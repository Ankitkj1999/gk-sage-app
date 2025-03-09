import 'package:flutter/material.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/services/drift_service.dart';

class EndlessQuizBloc extends ChangeNotifier {
  final DriftService _driftService = DriftService();
  final int batchSize = 10;
  final int prefetchThreshold = 8; // When to load next batch

  List<Question> _questionQueue = [];
  List<String> _shownQuestionIds = [];
  bool _isLoading = true;
  int _currentQuestionIndex = 0;

  EndlessQuizBloc() {
    initialize();
  }

  bool get isLoading => _isLoading;
  List<Question> get questionQueue => _questionQueue;
  int get currentQuestionIndex => _currentQuestionIndex;

  Question? get currentQuestion {
    if (_questionQueue.isEmpty || _currentQuestionIndex >= _questionQueue.length) {
      return null;
    }
    return _questionQueue[_currentQuestionIndex];
  }

  // Initialize with first batch
  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    _questionQueue = await _driftService.getRandomQuestions(count: batchSize);
    _shownQuestionIds = _questionQueue.map((q) => q.id ?? '').where((id) => id.isNotEmpty).toList();
    _currentQuestionIndex = 0;

    _isLoading = false;
    notifyListeners();
  }

  // Move to next question
  void nextQuestion() {
    if (_currentQuestionIndex < _questionQueue.length - 1) {
      _currentQuestionIndex++;
      notifyListeners();

      // Check if we need to load more questions
      if (_currentQuestionIndex >= _questionQueue.length - prefetchThreshold) {
        _loadNextBatch();
      }
    }
  }

  // Load next batch of questions
  Future<void> _loadNextBatch() async {
    if (_isLoading) return;

    debugPrint('Loading next batch of questions...');
    _isLoading = true;
    // We don't notify here to avoid UI flicker - just load in background

    final newQuestions = await _driftService.getRandomQuestions(
        count: batchSize,
        excludeIds: _shownQuestionIds
    );

    if (newQuestions.isNotEmpty) {
      _questionQueue.addAll(newQuestions);
      _shownQuestionIds.addAll(
          newQuestions.map((q) => q.id ?? '').where((id) => id.isNotEmpty).toList()
      );
      debugPrint('Added ${newQuestions.length} new questions, total: ${_questionQueue.length}');
    } else {
      debugPrint('No new questions found');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Reset the quiz
  void reset() {
    _currentQuestionIndex = 0;
    notifyListeners();
  }
}