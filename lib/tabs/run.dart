import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/blocs/audio_controller.dart';
import 'package:quiz_app/models/question.dart';

import '../blocs/endlessQuiz_bloc.dart';

class RunTab extends StatefulWidget {
  const RunTab({super.key});

  @override
  State<RunTab> createState() => _RunTabState();
}

class _RunTabState extends State<RunTab> {
  late EndlessQuizBloc _endlessQuizBloc;
  int? _selectedOptionIndex;

  @override
  void initState() {
    super.initState();
    _endlessQuizBloc = EndlessQuizBloc();
  }

  @override
  void dispose() {
    _endlessQuizBloc.dispose();
    super.dispose();
  }

  void _onOptionSelected(int index) {
    setState(() {
      _selectedOptionIndex = index;
    });

    // Play sound if enabled
    if (context.read<SoundControllerBloc>().audioEnabled) {
      context.read<SoundControllerBloc>().playSound(
          context.read<SoundControllerBloc>().clickSoundId
      );
    }
  }

  void _onNextQuestion() {
    _endlessQuizBloc.nextQuestion();
    setState(() {
      _selectedOptionIndex = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Run').tr(),
        centerTitle: true,
      ),
      body: AnimatedBuilder(
        animation: _endlessQuizBloc,
        builder: (context, _) {
          if (_endlessQuizBloc.isLoading && _endlessQuizBloc.questionQueue.isEmpty) {
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
                  Text('No questions available', style: TextStyle(fontSize: 18)),
                  ElevatedButton(
                    onPressed: () => _endlessQuizBloc.initialize(),
                    child: Text('Retry'),
                  )
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Question counter and batch info
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Question ${_endlessQuizBloc.currentQuestionIndex + 1}',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      if (_endlessQuizBloc.isLoading)
                        SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2)
                        ),
                    ],
                  ),
                ),

                // Question card
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        if (currentQuestion.questionImageUrl != null &&
                            currentQuestion.questionImageUrl!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Image.network(
                              currentQuestion.questionImageUrl!,
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                            ),
                          ),

                        Text(
                          currentQuestion.questionTitle ?? 'No question text',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Options
                ...List.generate(
                  currentQuestion.options?.length ?? 0,
                      (index) {
                    final bool isSelected = _selectedOptionIndex == index;
                    final bool isCorrect = currentQuestion.correctAnswerIndex == index;
                    final bool showResult = _selectedOptionIndex != null;

                    Color cardColor = Colors.white;
                    if (showResult) {
                      if (isCorrect) {
                        cardColor = Colors.green.shade100;
                      } else if (isSelected && !isCorrect) {
                        cardColor = Colors.red.shade100;
                      }
                    } else if (isSelected) {
                      cardColor = Colors.blue.shade100;
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: InkWell(
                        onTap: _selectedOptionIndex == null
                            ? () => _onOptionSelected(index)
                            : null,
                        child: Card(
                          color: cardColor,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Text(
                                  String.fromCharCode(65 + index), // A, B, C, D
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    currentQuestion.options?[index]?.toString() ?? 'No option',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 10),

                // Explanation (only shown after selection)
                if (_selectedOptionIndex != null &&
                    currentQuestion.explaination != null &&
                    currentQuestion.explaination!.isNotEmpty)
                  Card(
                    color: Colors.amber.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Explanation:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            currentQuestion.explaination!,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 20),

                // Next button
                ElevatedButton(
                  onPressed: _selectedOptionIndex != null ? _onNextQuestion : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Next Question', style: TextStyle(fontSize: 18)),
                      if (_endlessQuizBloc.isLoading)
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              )
                          ),
                        ),
                    ],
                  ),
                ),

                // Debugging info
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Loaded ${_endlessQuizBloc.questionQueue.length} questions in queue',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}