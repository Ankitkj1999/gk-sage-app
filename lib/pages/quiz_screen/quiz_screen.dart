import 'dart:async';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/blocs/ads_bloc.dart';
import 'package:quiz_app/blocs/audio_controller.dart';
import 'package:quiz_app/blocs/question_bloc.dart';
import 'package:quiz_app/blocs/temp_bloc.dart';
import 'package:quiz_app/blocs/user_bloc.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/models/user.dart';
import 'package:quiz_app/pages/quiz_screen/close_dialog.dart';
import 'package:quiz_app/pages/quiz_screen/next_button.dart';
import 'package:quiz_app/pages/quiz_screen/progress_bar.dart';
import 'package:quiz_app/pages/quiz_screen/quiz_options.dart';
import 'package:quiz_app/services/firebase_service.dart';
import 'package:quiz_app/utils/banner_ad.dart';
import 'package:quiz_app/utils/snackbars.dart';
import '../../blocs/settings_bloc.dart';
import '../../constants/constant.dart';
import '../../utils/next_screen.dart';
import '../quiz_complete.dart';
import 'question_title.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({
    super.key,
    required this.qList,
    required this.hasTimer,
    required this.quizTime,
    required this.selfChallengeMode,
  });
  final List<Question> qList;
  final bool hasTimer;
  final int quizTime;
  final bool selfChallengeMode;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int? _selectedOptionIndex;
  bool _isLoading = false;

  _initInterstitalAds() {
    Future.delayed(const Duration(seconds: 1)).then((value) {
      if (context.read<AdsBloc>().isInterstitialEnabled) {
        context.read<AdsBloc>().createInterstitialAd();
      }
    });
  }

  // @override
  // void initState() {
  //   Future.microtask(() {
  //     context.read<QuestionBloc>().intPageIndex();
  //     context.read<QuestionBloc>().updateQuestion(widget.qList[0]);
  //     context.read<TempBloc>().setParcentage(0, widget.qList.length);
  //     context.read<QuestionBloc>().updateDragTargetText(null);
  //     _initInterstitalAds();
  //   });
  //   super.initState();
  // }

  @override
  void initState() {
    Future.microtask(() {
      context.read<QuestionBloc>().intPageIndex();
      context.read<QuestionBloc>().updateQuestion(widget.qList[0]);
      context.read<TempBloc>().setParcentage(0, widget.qList.length);
      context.read<QuestionBloc>().updateDragTargetText(null);
      _initInterstitalAds();

      // Add a short delay before prefetching to avoid UI jank during initialization
      Future.delayed(const Duration(milliseconds: 300), () {
        _prefetchQuestionImages(widget.qList);
      });
    });
    super.initState();
  }


  void _prefetchQuestionImages(List<Question> questions, [int startIndex = 0, int count = 3]) {
    debugPrint('🔍 PREFETCH: Starting image prefetch for quiz images');

    int imagesToPrefetch = 0;
    for (int i = startIndex; i < questions.length && i < startIndex + count; i++) {
      Question question = questions[i];
      if (question.questionType == Constants.questionTypes.keys.elementAt(1) &&
          question.questionImageUrl != null &&
          question.questionImageUrl!.isNotEmpty) {
        imagesToPrefetch++;
      }
    }

    if (imagesToPrefetch == 0) {
      debugPrint('🔍 PREFETCH: No question images to prefetch in this range');
      return;
    }

    debugPrint('🔍 PREFETCH: Found $imagesToPrefetch images to prefetch');

    for (int i = startIndex; i < questions.length && i < startIndex + count; i++) {
      Question question = questions[i];
      if (question.questionType == Constants.questionTypes.keys.elementAt(1) &&
          question.questionImageUrl != null &&
          question.questionImageUrl!.isNotEmpty) {

        debugPrint('🔍 PREFETCH: Prefetching image for question ${i}: ${question.questionImageUrl}');

        precacheImage(
            NetworkImage(question.questionImageUrl!),
            context
        ).then((_) {
          debugPrint('✅ PREFETCH: Successfully prefetched image for question ${i}');
        }).catchError((e) {
          debugPrint('❌ PREFETCH: Error prefetching image: $e');
        });
      }
    }
  }


  _updatePointsHistory() async {
    final String userId = context.read<UserBloc>().userData!.uid!;
    String newHistory = '';
    final int rewardAmount = (context.read<TempBloc>().pointsEarned -
        context.read<TempBloc>().pointLoss);
    if (rewardAmount.isNegative) {
      newHistory = 'Completed A Quiz $rewardAmount at ${DateTime.now()}';
    } else {
      newHistory = 'Completed A Quiz +$rewardAmount at ${DateTime.now()}';
    }
    await FirebaseService().updateUserPointHistory(userId, newHistory);
  }

  // Future _onNextButtonPressed(int questionIndex) async {
  //   final UserModel user = context.read<UserBloc>().userData!;
  //   if (_selectedOptionIndex != null) {
  //     _updateTempData(questionIndex);
  //
  //     if (widget.qList.length == (questionIndex + 1)) {
  //       setState(() => _isLoading = true);
  //       if (widget.selfChallengeMode == false) {
  //         //not for self challenge mode
  //         await FirebaseService()
  //             .updateUserPoints(user.uid!, context.read<TempBloc>().points);
  //         // ignore: use_build_context_synchronously
  //         await context
  //             .read<UserBloc>()
  //             .updateUserPointsToBloc(context.read<TempBloc>().points);
  //         await _updateUserStat();
  //         await _updatePointsHistory();
  //         await FirebaseService().updateCompletedQuizzes(
  //             widget.qList[questionIndex].quizId!, user);
  //         // ignore: use_build_context_synchronously
  //         await context.read<UserBloc>().getUserData();
  //       }
  //       setState(() => _isLoading = false);
  //       _showAd();
  //       // ignore: use_build_context_synchronously
  //       NextScreen().nextScreenReplace(
  //           context, QuizComplete(qList: widget.qList, isTimeOver: false));
  //     } else {
  //       context
  //           .read<QuestionBloc>()
  //           .updateQuestion(widget.qList[questionIndex + 1]);
  //       context
  //           .read<TempBloc>()
  //           .setParcentage(questionIndex + 1, widget.qList.length);
  //       if (context.read<SoundControllerBloc>().audioEnabled) {
  //         context
  //             .read<SoundControllerBloc>()
  //             .playSound(context.read<SoundControllerBloc>().optionSoundId);
  //       }
  //     }
  //
  //     setState(() => _selectedOptionIndex = null);
  //     // ignore: use_build_context_synchronously
  //     context.read<QuestionBloc>().updateDragTargetText(null);
  //
  //     // ignore: use_build_context_synchronously
  //     context.read<QuestionBloc>().controlPage(questionIndex + 1);
  //   } else {
  //     openSnackbar(context, "Select an option to continue");
  //   }
  // }

  Future _onNextButtonPressed(int questionIndex) async {
    final UserModel user = context.read<UserBloc>().userData!;
    if (_selectedOptionIndex != null) {
      _updateTempData(questionIndex);

      if (widget.qList.length == (questionIndex + 1)) {
        // Handle last question
        setState(() => _isLoading = true);
        if (widget.selfChallengeMode == false) {
          // Not for self challenge mode
          await FirebaseService()
              .updateUserPoints(user.uid!, context.read<TempBloc>().points);
          // ignore: use_build_context_synchronously
          await context
              .read<UserBloc>()
              .updateUserPointsToBloc(context.read<TempBloc>().points);
          await _updateUserStat();
          await _updatePointsHistory();
          await FirebaseService().updateCompletedQuizzes(
              widget.qList[questionIndex].quizId!, user);
          // ignore: use_build_context_synchronously
          await context.read<UserBloc>().getUserData();
        }
        setState(() => _isLoading = false);
        _showAd();
        // ignore: use_build_context_synchronously
        NextScreen().nextScreenReplace(
            context, QuizComplete(qList: widget.qList, isTimeOver: false));
      } else {
        // If not on the last question, prefetch next images and continue
        _prefetchQuestionImages(widget.qList, questionIndex + 1, 3);

        context
            .read<QuestionBloc>()
            .updateQuestion(widget.qList[questionIndex + 1]);
        context
            .read<TempBloc>()
            .setParcentage(questionIndex + 1, widget.qList.length);
        if (context.read<SoundControllerBloc>().audioEnabled) {
          context
              .read<SoundControllerBloc>()
              .playSound(context.read<SoundControllerBloc>().optionSoundId);
        }
      }

      setState(() => _selectedOptionIndex = null);
      // ignore: use_build_context_synchronously
      context.read<QuestionBloc>().updateDragTargetText(null);

      // ignore: use_build_context_synchronously
      context.read<QuestionBloc>().controlPage(questionIndex + 1);
    } else {
      openSnackbar(context, "Select an option to continue");
    }
  }

  // Future _onNextButtonPressed(int questionIndex) async {
  //   final UserModel user = context.read<UserBloc>().userData!;
  //   if (_selectedOptionIndex != null) {
  //     _updateTempData(questionIndex);
  //
  //     // If not on the last question, prefetch next images
  //     if (widget.qList.length != (questionIndex + 1)) {
  //       _prefetchQuestionImages(widget.qList, questionIndex + 1, 3);
  //
  //       context
  //           .read<QuestionBloc>()
  //           .updateQuestion(widget.qList[questionIndex + 1]);
  //       context
  //           .read<TempBloc>()
  //           .setParcentage(questionIndex + 1, widget.qList.length);
  //       if (context.read<SoundControllerBloc>().audioEnabled) {
  //         context
  //             .read<SoundControllerBloc>()
  //             .playSound(context.read<SoundControllerBloc>().optionSoundId);
  //       }
  //     } else {
  //       // Rest of your existing code for last question
  //       setState(() => _isLoading = true);
  //       // ...
  //     }
  //
  //     // Rest of your existing code
  //     setState(() => _selectedOptionIndex = null);
  //     context.read<QuestionBloc>().updateDragTargetText(null);
  //     context.read<QuestionBloc>().controlPage(questionIndex + 1);
  //   } else {
  //     openSnackbar(context, "Select an option to continue");
  //   }
  // }

  _showAd() {
    if (context.read<AdsBloc>().isInterstitialEnabled &&
        context.read<AdsBloc>().isInterstitialAdLoaded) {
      context.read<AdsBloc>().showInterstitialAd();
    }
  }

  _updateUserStat() async {
    final user = context.read<UserBloc>().userData;
    final tb = context.read<TempBloc>();
    await FirebaseService().updateUserStatToDatabase(
        user!.uid!,
        user.totalQuizPlayed! + 1,
        user.totalQuestionAnswered! + tb.selectedIndexList.length,
        user.totalCorrectAns! + tb.currentAnsCount,
        user.totalIncorrectAns! + tb.incorrectAnsCount);
  }

  _updateTempData(int questionIndex) {
    TempBloc tb = context.read<TempBloc>();
    SettingsBloc sb = context.read<SettingsBloc>();
    if (_selectedOptionIndex ==
        widget.qList[questionIndex].correctAnswerIndex) {
      int newPoints = tb.points + context.read<SettingsBloc>().correctAnsReward;
      tb.updateTempData(_selectedOptionIndex!, newPoints,
          widget.selfChallengeMode ? 0 : sb.correctAnsReward, true, 0);
    } else {
      int newPoints =
          tb.points - context.read<SettingsBloc>().incorrectAnsPenalty;
      tb.updateTempData(_selectedOptionIndex!, newPoints, 0, false,
          widget.selfChallengeMode ? 0 : sb.incorrectAnsPenalty);
    }
  }

  _onOptionPressed(int optionIndex) async {
    final questionBloc = context.read<QuestionBloc>();
    final currentQuestion = questionBloc.question;

    final String? explanation = currentQuestion?.explaination;
    final String? correctAnswer =
        currentQuestion?.options?[currentQuestion.correctAnswerIndex!];

    debugPrint(
        "Option selected: $optionIndex and the correct answer is $correctAnswer");
    debugPrint(
        "Explanation: ${explanation ?? 'No explanation available and the correct answer is $correctAnswer'}");

    setState(() => _selectedOptionIndex = optionIndex);
    if (context.read<SoundControllerBloc>().audioEnabled) {
      context
          .read<SoundControllerBloc>()
          .playSound(context.read<SoundControllerBloc>().clickSoundId);
    }

    if (context.read<SoundControllerBloc>().vibrationEnabled) {
      if (optionIndex == currentQuestion?.correctAnswerIndex) {
        if (Platform.isAndroid) {
          HapticFeedback.mediumImpact();
        } else if (Platform.isIOS) {
          HapticFeedback.mediumImpact();
        }
      } else {
        if (Platform.isAndroid) {
          HapticFeedback.heavyImpact();
        } else if (Platform.isIOS) {
          HapticFeedback.heavyImpact();
        }
      }
    }
  }

  _handleAddToBookmark() async {
    final Question? question = context.read<QuestionBloc>().question;
    if (question != null) {
      await FirebaseService().addToBookmark(question.id!).then((value) {
        openSnackbar(context, 'bookmark-message'.tr());
      });
    } else {
      openSnackbar(context, 'Error on adding bookmark');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, result) {
        if (didPop) {
          return;
        }
        openQuizCloseDialog(context: context);
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        bottomNavigationBar: Wrap(
          alignment: WrapAlignment.center,
          children: [
            Visibility(
                visible: context.read<AdsBloc>().isBannerAdEnabled,
                child: const BannerAdWidget()),
            NextButton(
                isLoading: _isLoading,
                onPressed: (int questionIndex) =>
                    _onNextButtonPressed(questionIndex)),
          ],
        ),
        appBar: progessAppBar(
          context: context,
          hasTimer: widget.hasTimer,
          qList: widget.qList,
          quizTime: widget.quizTime,
          selfChallengeMode: widget.selfChallengeMode,
          handleAddToBookmark: _handleAddToBookmark,
        ),
        body: PageView.builder(
          pageSnapping: true,
          physics: const NeverScrollableScrollPhysics(),
          padEnds: true,
          reverse: false,
          controller: context.read<QuestionBloc>().pageController,
          itemCount: widget.qList.length,
          itemBuilder: (context, questionIndex) {
            final Question question = widget.qList[questionIndex];
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  QuestionTitle(question: question, qList: widget.qList),
                  QuizOptions(
                    question: question,
                    selectedOptionIndex: _selectedOptionIndex,
                    onOptionPressed: (int optionIndex) =>
                        _onOptionPressed(optionIndex),
                    showExplanation: _selectedOptionIndex != null,
                    correctAnswerIndex: question.correctAnswerIndex ?? 0,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
