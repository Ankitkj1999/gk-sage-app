import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/blocs/settings_bloc.dart';
import 'package:quiz_app/blocs/user_bloc.dart';
import 'package:quiz_app/configs/app_config.dart';
import 'package:quiz_app/constants/constant.dart';
import 'package:quiz_app/models/quiz.dart';
import 'package:quiz_app/pages/quiz_screen/quiz_screen.dart';
import 'package:quiz_app/services/firebase_service.dart';
import 'package:quiz_app/utils/animation_dialog.dart';
import 'package:quiz_app/utils/next_screen.dart';
import 'package:quiz_app/widgets/custom_chip.dart';
import 'package:quiz_app/widgets/html_body.dart';
import 'package:quiz_app/widgets/loading_widget.dart';

import '../blocs/temp_bloc.dart';
import '../models/question.dart';
import '../models/user.dart';
import '../services/point_service.dart';

class QuizInfo extends StatefulWidget {
  const QuizInfo({super.key, required this.quiz, required this.heroTag});

  final Quiz quiz;
  final String heroTag;

  @override
  State<QuizInfo> createState() => _QuizInfoState();
}

class _QuizInfoState extends State<QuizInfo> {
  bool _isLoading = false;


  Future _checkEligibility() async {
    debugPrint("Point: Checking the eligibility ${DateTime.now().toIso8601String()}");

    // Get user data and required points
    final UserModel? userData = context.read<UserBloc>().userData;
    final int pointsRequired = widget.quiz.pointsRequired!;

    // Check if user has enough points
    if (userData!.points! < pointsRequired) {
      openAnimationDialog(
        context,
        Config.emptyBoxAnimation,
        'not-enough-points'.tr(),
        'minimum-points-count'.tr(args: [pointsRequired.toString()]),
      );
      return;
    }

    // Start loading state
    setState(() => _isLoading = true);

    try {
      debugPrint("Point: Getting the questions ${DateTime.now().toIso8601String()}");

      // Get questions from Firebase
      final List<Question> qList = await FirebaseService().getQuestions(widget.quiz.id!);

      // Check if we have questions
      if (qList.isEmpty) {
        setState(() => _isLoading = false);
        openAnimationDialog(
          context,
          Config.emptyBoxAnimation,
          'not-enough-questions-title'.tr(),
          'not-enough-questions-subtitle'.tr(),
        );
        return;
      }

      debugPrint("Point: The list of questions is not empty ${DateTime.now().toIso8601String()}");

      // Sort/shuffle questions based on quiz settings
      if (widget.quiz.questionOrder == Constants.questionOrders[0]) {
        qList.shuffle();
      } else if (widget.quiz.questionOrder == Constants.questionOrders[1]) {
        qList.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
      } else {
        qList.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
      }

      debugPrint("Point: Shuffling the questions ${DateTime.now().toIso8601String()}");

      // Update points locally first
      final int currentPoints = userData!.points!;
      final int newPoints = currentPoints - pointsRequired;

      // Update UserBloc (UI updates immediately)
      await context.read<UserBloc>().updateUserPointsToBloc(newPoints);

      // Use PointsService to handle background sync
      final pointsService = PointsService();
      pointsService.addPoints(
          userData.uid!,
          -pointsRequired,
          "Played A Quiz"
      );

      // Initialize temp data with updated points
      await context.read<TempBloc>().intializeTempData(newPoints);

      // Stop loading spinner
      setState(() => _isLoading = false);

      // Navigate to the quiz screen immediately
      debugPrint("Point: Navigating to the quiz screen ${DateTime.now().toIso8601String()}");
      NextScreen().nextScreenReplace(
        context,
        QuizScreen(
          qList: qList,
          hasTimer: widget.quiz.timer!,
          quizTime: widget.quiz.quizTime!,
          selfChallengeMode: false,
        ),
      );

    } catch (e) {
      // Handle errors
      debugPrint("Error in _checkEligibility: $e");
      setState(() => _isLoading = false);

      // Show error dialog
      openAnimationDialog(
        context,
        Config.quitAnimation,
        'error-title'.tr(),
        'error-message'.tr(),
      );

    }
  }


  @override
  Widget build(BuildContext context) {
    final SettingsBloc sb = context.read<SettingsBloc>();
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: InkWell(
        onTap: (() async => await _checkEligibility()),
        child: Container(
          alignment: Alignment.center,
          height: 60,
          color: Theme.of(context).primaryColor,
          child: _isLoading == true
              ? const LoadingIndicatorWidget(
                  color: Colors.white,
                )
              : Text(
                  'start-quiz',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ).tr(),
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar.large(
              elevation: 0.5,
              titleSpacing: 0,
              stretch: true,
              pinned: true,
              centerTitle: false,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsetsDirectional.only(
                    bottom: 16, start: 50, end: 20),
                title: Text(
                  'quiz-overview-count',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.white),
                ).tr(args: [widget.quiz.name!]),
                centerTitle: false,
                background: Hero(
                  tag: widget.heroTag,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                              widget.quiz.thumbnailUrl!,
                            ))),
                  ),
                ),
              )),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        CustomChip(
                            label: 'points-required-count'.tr(
                                args: [widget.quiz.pointsRequired.toString()]),
                            bgColor: Colors.blueGrey),
                        CustomChip(
                            label: 'reward/question-count'
                                .tr(args: [sb.correctAnsReward.toString()]),
                            bgColor: Colors.pink),
                        CustomChip(
                            label: 'penalty/question-count'
                                .tr(args: [sb.incorrectAnsPenalty.toString()]),
                            bgColor: Colors.orange),
                        Visibility(
                            visible: widget.quiz.timer!,
                            child: CustomChip(
                                label: 'time-count'.tr(
                                    args: [widget.quiz.quizTime.toString()]),
                                bgColor: Colors.green)),
                      ],
                    ),
                  ),
                  HtmlBody(description: widget.quiz.description ?? '')
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
