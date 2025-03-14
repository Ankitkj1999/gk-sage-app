import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ionicons/ionicons.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/blocs/audio_controller.dart';
import 'package:quiz_app/blocs/settings_bloc.dart';
import 'package:quiz_app/blocs/user_bloc.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/models/user.dart';
import 'package:quiz_app/pages/quiz_screen/control_dialog.dart';
import 'package:quiz_app/services/firebase_service.dart';
import 'package:quiz_app/utils/cached_image.dart';
import 'package:quiz_app/utils/next_screen.dart';
import 'package:quiz_app/utils/image_preview.dart';
import 'package:quiz_app/configs/feature_config.dart';
import 'package:quiz_app/utils/icon_utils.dart';

import '../blocs/endlessQuiz_bloc.dart';
import '../blocs/tab_controller.dart';
import '../configs/color_config.dart';
import '../models/category.dart';
import '../models/quiz.dart';

import '../services/drift_service.dart';
import '../services/point_service.dart';
import '../services/sp_service.dart';
import '../utils/prefetched_image.dart';
import '../widgets/custom_chip.dart';
import 'leaderboard_tab.dart';

class RunTab extends StatefulWidget {
  const RunTab({super.key});

  @override
  State<RunTab> createState() => _RunTabState();
}

class _RunTabState extends State<RunTab> {
  late EndlessQuizBloc _endlessQuizBloc;
  int? _selectedOptionIndex;
  // Point tracking variables
  int _sessionPoints = 0;
  int _correctAnswers = 0;
  int _incorrectAnswers = 0;
  bool _pointsAdded = false;

  final DriftService _driftService = DriftService();
  bool _isSyncing = false;
  List<Quiz> _localQuizzes = [];
  List<Category> _localCategorys = [];
  List<Question> _localQuestions = [];
  UserModel? _localUser;



  @override
  void initState() {
    super.initState();
    _endlessQuizBloc = EndlessQuizBloc();

    // Initialize PointsService for background syncing
    final pointsService = PointsService();
    pointsService.initialize();

    _syncData();
  }

  Future<void> _syncData() async {
    setState(() {
      _isSyncing = true;
    });

    try {
      // First sync user data (this is important and relatively quick)
      final String? uid = await SPService().getUidFromLocal();
      if (uid != null) {
        _localUser = await _driftService.syncAndGetUserData(uid);
        // Immediately update UserBloc if we have user data
        if (_localUser != null) {
          context.read<UserBloc>().setUserData(_localUser!);
        }
      }

      // First sync categories and quizzes (this is quick)
      _localCategorys = await _driftService.syncAndGetAllCategories();
      _localQuizzes = await _driftService.syncAndGetAllQuizzes();

      setState(() {
        _isSyncing = false;
      });

      // Then sync questions in the background (can take longer)
      // This runs after setting isSyncing to false so the UI is responsive
      _startBackgroundQuestionSync();
    } catch (e) {
      setState(() {
        _isSyncing = false;
      });
      debugPrint('Error syncing data: $e');
    }
  }

  void _startBackgroundQuestionSync() {
    // This doesn't block the UI since it's not awaited
    _driftService.syncQuestionsForAllQuizzes().then((_) {
      // Optionally update state if needed when sync completes
      if (mounted) {
        setState(() {
          // You could set a flag to show sync is complete
        });
      }
    });
  }



  @override
  void dispose() {
    _driftService.close();

    // Force sync any remaining updates before disposing
    PointsService().forceSyncNow();
    PointsService().dispose();

    _endlessQuizBloc.dispose();
    super.dispose();
  }

  void _onOptionSelected(int index) {
    if (_selectedOptionIndex != null) return; // Prevent multiple selections

    setState(() {
      _selectedOptionIndex = index;
      _pointsAdded = false; // Reset for new selection
    });

    // Update points based on correct/incorrect answer
    _updatePoints(index);

    // Play sound if enabled
    if (context.read<SoundControllerBloc>().audioEnabled) {
      context
          .read<SoundControllerBloc>()
          .playSound(context.read<SoundControllerBloc>().clickSoundId);
    }
  }



  void _updatePoints(int selectedIndex) {
    // Get settings for point rewards/penalties
    final SettingsBloc sb = context.read<SettingsBloc>();
    final Question? currentQuestion = _endlessQuizBloc.currentQuestion;
    final UserModel? user = context.read<UserBloc>().userData;

    if (currentQuestion == null || user?.uid == null) return;

    int pointsToAdd = 0;
    String reason = "";
    bool isCorrect = false;

    if (selectedIndex == currentQuestion.correctAnswerIndex) {
      // Correct answer
      pointsToAdd = sb.correctAnsReward;
      reason = "Correct answer";
      isCorrect = true;
      setState(() {
        _sessionPoints += pointsToAdd;
        _correctAnswers++;
        _pointsAdded = true;
      });
    } else {
      // Incorrect answer
      pointsToAdd = -sb.incorrectAnsPenalty; // Negative for penalty
      reason = "Incorrect answer";
      isCorrect = false;
      setState(() {
        _sessionPoints += pointsToAdd; // Adding negative points
        _incorrectAnswers++;
        _pointsAdded = true;
      });
    }

    // Update points locally in user bloc first for immediate UI feedback
    int currentPoints = user?.points ?? 0;
    int newTotalPoints = currentPoints + pointsToAdd;
    context.read<UserBloc>().updateUserPointsToBloc(newTotalPoints);

    // Use the PointsService to handle background sync of points
    final pointsService = PointsService();
    pointsService.addPoints(user!.uid!, pointsToAdd, reason);

    // Also update the quiz stats in the background
    _driftService.updateUserQuizStats(user.uid!, isCorrect: isCorrect);
  }



  void _onNextQuestion() {
    // No need to wait for Firebase updates!
    // Just move to the next question immediately
    _endlessQuizBloc.nextQuestion();
    setState(() {
      _selectedOptionIndex = null;
    });
  }

  Future<void> _savePointsToFirebase() async {
    try {
      final UserModel? user = context.read<UserBloc>().userData;
      if (user != null && user.uid != null) {
        // Get current user points from UserBloc
        final int currentPoints = user.points ?? 0;

        // Calculate new total (add session points to existing total)
        final int newTotalPoints = currentPoints + _sessionPoints;

        // Update points in Firebase
        await FirebaseService().updateUserPoints(user.uid!, newTotalPoints);

        // Update points in UserBloc
        await context.read<UserBloc>().updateUserPointsToBloc(newTotalPoints);

        // Update points history
        String newHistory = '';
        if (_sessionPoints.isNegative) {
          newHistory = 'Run Quiz $_sessionPoints at ${DateTime.now()}';
        } else {
          newHistory = 'Run Quiz +$_sessionPoints at ${DateTime.now()}';
        }
        await FirebaseService().updateUserPointHistory(user.uid!, newHistory);

        // Reset session points tracking after saving
        setState(() {
          _pointsAdded = false;
          _sessionPoints = 0; // Reset after updating Firebase
        });
      }
    } catch (e) {
      debugPrint('Error saving points: $e');
    }
  }

  Future _handleAddToBookmark() async {
    final Question? question = _endlessQuizBloc.currentQuestion;
    if (question != null && question.id != null) {
      await FirebaseService().addToBookmark(question.id!).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('bookmark-message'.tr())),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error on adding bookmark')),
      );
    }
  }


  PreferredSizeWidget _buildRunAppBar() {
    // Get user data
    final user = context.watch<UserBloc>().userData;
    final int rank = context.watch<UserBloc>().userRank;

    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      // Keep progress indicator but as a bottom line
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4),
        child: LinearPercentIndicator(
          animation: true,
          lineHeight: 4.0,
          padding: EdgeInsets.zero,
          percent: _endlessQuizBloc.questionQueue.isNotEmpty
              ? (_endlessQuizBloc.currentQuestionIndex + 1) /
                  _endlessQuizBloc.questionQueue.length
              : 0.0,
          progressColor: Colors.amber,
          backgroundColor: Colors.white.withOpacity(0.2),
          barRadius: const Radius.circular(2),
          animateFromLastPercent: true,
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Session points indicator (for this run)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                '${_sessionPoints >= 0 ? "+" : ""}$_sessionPoints',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Row of action items
            Row(
              children: [
                // Total user points
                InkWell(
                  child: CustomChip1(
                    label: user?.points.toString() ?? "0",
                    icon: IconUtils.coins,
                    bgColor: ColorConfig.chip1,
                  ),
                  onTap: () => context.read<TabControllerBloc>().controlTab(2),
                ),
                const SizedBox(width: 10),
                // User rank
                InkWell(
                  child: CustomChip1(
                    label: '#$rank',
                    icon: IconUtils.leaderboard1,
                    bgColor: ColorConfig.chip2,
                  ),
                  onTap: () => NextScreen.nextScreenNormal(
                      context, const LeaderboardTab()),
                ),
                const SizedBox(width: 10),
                // Bookmark button (replaced notification button)
                Visibility(
                  visible: FeatureConfig.bookmarkQuestionEnabled,
                  child: InkWell(
                    onTap: () => _handleAddToBookmark(),
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: ColorConfig.iconBg,
                      child: const Icon(
                        IconUtils.addBookmark,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Settings toggle (replaced settings button)
                InkWell(
                  onTap: () => openControlDialog(context),
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: ColorConfig.iconBg,
                    child: const Icon(
                      Ionicons.options,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildQuestionTitle(Question question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 3,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(30)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Question ${_endlessQuizBloc.currentQuestionIndex + 1}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.blueGrey[800]),
                    ),
                    Text(
                      question.questionTitle ?? 'No question text',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.blueGrey.shade900,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Visibility(
          visible: question.questionImageUrl != null &&
              question.questionImageUrl!.isNotEmpty,
          child: InkWell(
            onTap: () => NextScreen().nextScreenPopup(
                context,
                FullImagePreview(
                    imageUrl: question.questionImageUrl.toString())),
            child: SizedBox(
              height: 150,
              width: double.infinity,
              child: PrefetchedImages(
                imageUrl: question.questionImageUrl,
                radius: 5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Options widget
  Widget _buildOptions(Question question) {
    final bool hasSelectedOption = _selectedOptionIndex != null;
    final int correctAnswerIndex = question.correctAnswerIndex ?? 0;

    // Determine if the selected option is correct
    final bool isCorrect =
        hasSelectedOption && _selectedOptionIndex == correctAnswerIndex;

    // Get correct answer text if needed
    String? correctAnswerText;
    if (hasSelectedOption && !isCorrect && question.options != null) {
      if (correctAnswerIndex >= 0 &&
          correctAnswerIndex < question.options!.length) {
        correctAnswerText = question.options![correctAnswerIndex];
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.grey[200]!,
                      blurRadius: 10,
                      offset: const Offset(0, 5))
                ]),
            child: LiveList(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: question.options?.length ?? 0,
              itemBuilder: (context, optionIndex, animation) {
                final String option =
                    question.options?[optionIndex] ?? 'No option';
                bool isSelected = _selectedOptionIndex != null &&
                    _selectedOptionIndex == optionIndex;

                return FadeTransition(
                  opacity: Tween<double>(begin: 0, end: 1).animate(animation),
                  child: SlideTransition(
                    position: Tween<Offset>(
                            begin: const Offset(0, -0.1), end: Offset.zero)
                        .animate(animation),
                    child: InkWell(
                      onTap: _selectedOptionIndex == null
                          ? () => _onOptionSelected(optionIndex)
                          : null,
                      child: OptionCard(
                        optionTitle: option,
                        isSelected: isSelected,
                        isCorrect: hasSelectedOption
                            ? optionIndex == correctAnswerIndex
                            : null,
                        isIncorrect: hasSelectedOption &&
                            isSelected &&
                            optionIndex != correctAnswerIndex,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Show explanation when an option is selected
          if (_selectedOptionIndex != null &&
              question.explaination != null &&
              question.explaination!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: ExplanationWidget(
                explanation: question.explaination,
                isCorrect: isCorrect,
                correctAnswer: correctAnswerText,
              ),
            ),
        ],
      ),
    );
  }

  // Next button widget
  Widget _buildNextButton() {
    return Container(
      margin: const EdgeInsets.all(20),
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: _selectedOptionIndex != null ? _onNextQuestion : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Next Question',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (_endlessQuizBloc.isLoading)
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: _buildRunAppBar(),
      body: AnimatedBuilder(
        animation: _endlessQuizBloc,
        builder: (context, _) {
          if (_endlessQuizBloc.isLoading &&
              _endlessQuizBloc.questionQueue.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final Question? currentQuestion = _endlessQuizBloc.currentQuestion;

          if (currentQuestion == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No questions available',
                      style: TextStyle(fontSize: 18)),
                  ElevatedButton(
                    onPressed: () => _endlessQuizBloc.initialize(),
                    child: Text('Retry'),
                  )
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildQuestionTitle(currentQuestion),
                      _buildOptions(currentQuestion),
                    ],
                  ),
                ),
              ),
              if (_isSyncing)
                Container(
                  color: Colors.black.withOpacity(0.3),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              _buildNextButton(),
            ],
          );
        },
      ),
    );
  }
}

// Option card for displaying options
class OptionCard extends StatelessWidget {
  final String optionTitle;
  final bool isSelected;
  final bool? isCorrect;
  final bool? isIncorrect;

  const OptionCard({
    super.key,
    required this.optionTitle,
    required this.isSelected,
    this.isCorrect,
    this.isIncorrect,
  });

  @override
  Widget build(BuildContext context) {
    Color optionBgColor = Colors.transparent;
    Color borderColor = Colors.grey[300]!;

    if (isCorrect == true) {
      optionBgColor = Colors.green.withOpacity(0.1);
      borderColor = Colors.green;
    } else if (isIncorrect == true) {
      optionBgColor = Colors.red.withOpacity(0.1);
      borderColor = Colors.red;
    } else if (isSelected) {
      optionBgColor = Theme.of(context).primaryColor.withOpacity(0.1);
      borderColor = Theme.of(context).primaryColor;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: optionBgColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            height: 28,
            width: 28,
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).primaryColor
                  : Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: isSelected
                ? const Icon(Icons.check, color: Colors.white, size: 18)
                : null,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              optionTitle,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.blueGrey[800],
              ),
            ),
          ),
          if (isCorrect == true)
            const Icon(Icons.check_circle, color: Colors.green),
          if (isIncorrect == true) const Icon(Icons.cancel, color: Colors.red),
        ],
      ),
    );
  }
}

// Explanation widget for showing explanations
class ExplanationWidget extends StatelessWidget {
  final String? explanation;
  final bool isCorrect;
  final String? correctAnswer;

  const ExplanationWidget({
    super.key,
    this.explanation,
    required this.isCorrect,
    this.correctAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isCorrect
            ? Colors.green.withOpacity(0.1)
            : Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isCorrect ? Colors.green : Colors.red,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isCorrect ? Icons.check_circle : Icons.cancel,
                color: isCorrect ? Colors.green : Colors.red,
              ),
              const SizedBox(width: 10),
              Text(
                isCorrect ? 'Correct!' : 'Incorrect',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isCorrect ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
          if (!isCorrect && correctAnswer != null) ...[
            const SizedBox(height: 10),
            Text(
              'Correct answer: $correctAnswer',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
          if (explanation != null && explanation!.isNotEmpty) ...[
            const SizedBox(height: 10),
            const Text(
              'Explanation:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(explanation!),
          ],
        ],
      ),
    );
  }
}
