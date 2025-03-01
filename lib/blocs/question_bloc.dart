import 'package:flutter/material.dart';
import 'package:quiz_app/models/question.dart';

class QuestionBloc extends ChangeNotifier {
  PageController pageController = PageController(initialPage: 0);

  Question? _question;
  Question? get question => _question;

  String? _dragTargetText;
  String? get dragTargetText => _dragTargetText;

  updateDragTargetText(String? value) {
    _dragTargetText = value;
    notifyListeners();
  }

  updateQuestion(Question newQuestion) {
    _question = newQuestion;
    notifyListeners();
  }

  int _pageIndex = 0;
  int get pageIndex => _pageIndex;

  controlPage(int newPage) {
    _pageIndex = newPage;
    pageController.animateToPage(newPage,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    notifyListeners();
  }

  intPageIndex() {
    _pageIndex = 0;
    notifyListeners();
  }
}
