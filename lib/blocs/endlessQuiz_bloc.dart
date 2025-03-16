import 'package:flutter/material.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/services/drift_service.dart';

import '../services/navigation_service.dart';

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
  // Future<void> initialize() async {
  //   _isLoading = true;
  //   notifyListeners();
  //
  //   _questionQueue = await _driftService.getRandomQuestions(count: batchSize);
  //   _shownQuestionIds = _questionQueue.map((q) => q.id ?? '').where((id) => id.isNotEmpty).toList();
  //   _currentQuestionIndex = 0;
  //
  //   _isLoading = false;
  //   notifyListeners();
  // }

// In initialize(), delay the prefetching
//   Future<void> initialize() async {
//     _isLoading = true;
//     notifyListeners();
//
//     _questionQueue = await _driftService.getRandomQuestions(count: batchSize);
//     _shownQuestionIds = _questionQueue.map((q) => q.id ?? '').where((id) => id.isNotEmpty).toList();
//     _currentQuestionIndex = 0;
//
//     _isLoading = false;
//     notifyListeners();
//
//     // Delay prefetching to happen after UI is rendered
//     Future.delayed(const Duration(milliseconds: 300), () {
//       _prefetchImages(_questionQueue, 0, 3); // Only prefetch first 3 images
//     });
//   }
  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    _questionQueue = await _driftService.getRandomQuestions(count: batchSize);
    _shownQuestionIds = _questionQueue.map((q) => q.id ?? '').where((id) => id.isNotEmpty).toList();
    _currentQuestionIndex = 0;

    _isLoading = false;
    notifyListeners();

    // Increase delay to ensure UI is fully rendered and context is available
    Future.delayed(const Duration(milliseconds: 500), () {
      debugPrint('🔍 PREFETCH: Attempting initial prefetch after delay');
      _prefetchImages(_questionQueue, 0, 3); // Only prefetch first 3 images
    });
  }


  // Move to next question
  // void nextQuestion() {
  //   if (_currentQuestionIndex < _questionQueue.length - 1) {
  //     _currentQuestionIndex++;
  //     notifyListeners();
  //
  //     // Check if we need to load more questions
  //     if (_currentQuestionIndex >= _questionQueue.length - prefetchThreshold) {
  //       _loadNextBatch();
  //     }
  //   }
  // }

  void nextQuestion() {
    if (_currentQuestionIndex < _questionQueue.length - 1) {
      _currentQuestionIndex++;

      // Prefetch next few images starting after current question
      _prefetchImages(_questionQueue, _currentQuestionIndex + 1);

      notifyListeners();

      if (_currentQuestionIndex >= _questionQueue.length - prefetchThreshold) {
        _loadNextBatch();
      }
    }
  }

  // Load next batch of questions
  // Future<void> _loadNextBatch() async {
  //   if (_isLoading) return;
  //
  //   debugPrint('Loading next batch of questions...');
  //   _isLoading = true;
  //   // We don't notify here to avoid UI flicker - just load in background
  //
  //   final newQuestions = await _driftService.getRandomQuestions(
  //       count: batchSize,
  //       excludeIds: _shownQuestionIds
  //   );
  //
  //   if (newQuestions.isNotEmpty) {
  //     _questionQueue.addAll(newQuestions);
  //     _shownQuestionIds.addAll(
  //         newQuestions.map((q) => q.id ?? '').where((id) => id.isNotEmpty).toList()
  //     );
  //     debugPrint('Added ${newQuestions.length} new questions, total: ${_questionQueue.length}');
  //   } else {
  //     debugPrint('No new questions found');
  //   }
  //
  //   _isLoading = false;
  //   notifyListeners();
  // }

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

      // Prefetch images for new questions
      _prefetchImages(newQuestions);

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

// Enhance _prefetchImages with better logging
  void _prefetchImages(List<Question> questions, [int startIndex = 0, int count = 3]) {
    debugPrint('🔍 PREFETCH: Starting image prefetch for ${count} images from index ${startIndex}');

    // Count images that actually need prefetching
    int imagesToPrefetch = 0;
    for (int i = startIndex; i < startIndex + count && i < questions.length; i++) {
      if (questions[i].questionImageUrl != null && questions[i].questionImageUrl!.isNotEmpty) {
        imagesToPrefetch++;
      }
    }

    if (imagesToPrefetch == 0) {
      debugPrint('🔍 PREFETCH: No images to prefetch in this range');
      return;
    }

    debugPrint('🔍 PREFETCH: Found ${imagesToPrefetch} images to prefetch');

    // Only prefetch 3 images at a time, not 10
    for (int i = startIndex; i < startIndex + count && i < questions.length; i++) {
      final question = questions[i];
      if (question.questionImageUrl != null && question.questionImageUrl!.isNotEmpty) {
        debugPrint('🔍 PREFETCH: Attempting to prefetch image for question ${i}: ${question.questionImageUrl}');

        // Check if context exists before attempting to prefetch
        if (NavigationService.navigatorKey.currentContext != null) {
          debugPrint('🔍 PREFETCH: Context available, starting prefetch');

          precacheImage(
            NetworkImage(question.questionImageUrl!),
            NavigationService.navigatorKey.currentContext!,
          ).then((_) {
            // Successfully prefetched
            debugPrint('✅ PREFETCH: Successfully prefetched image for question ${i}');
          }).catchError((e) {
            debugPrint('❌ PREFETCH: Error prefetching image for question ${i}: $e');
          });
        } else {
          // Queue this for later when context is available
          debugPrint('⚠️ PREFETCH: Context not available for prefetching question ${i}');

          // Try again after a short delay
          Future.delayed(const Duration(milliseconds: 500), () {
            if (NavigationService.navigatorKey.currentContext != null) {
              debugPrint('🔄 PREFETCH: Retrying prefetch after delay for question ${i}');
              precacheImage(
                NetworkImage(question.questionImageUrl!),
                NavigationService.navigatorKey.currentContext!,
              ).catchError((e) => debugPrint('❌ PREFETCH: Retry failed: $e'));
            } else {
              debugPrint('❌ PREFETCH: Context still not available after delay');
            }
          });
        }
      }
    }
  }

}