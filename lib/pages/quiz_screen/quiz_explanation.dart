import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ExplanationWidget extends StatelessWidget {
  const ExplanationWidget({
    super.key,
    required this.explanation,
    required this.isCorrect,
    required this.correctAnswer,
  });

  final String? explanation;
  final bool isCorrect;
  final String? correctAnswer;

  @override
  Widget build(BuildContext context) {
    if (explanation == null && correctAnswer == null) return const SizedBox.shrink();

    return AnimatedOpacity(
      opacity: 1.0,
      duration: const Duration(milliseconds: 300),
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isCorrect ? Colors.green.shade50 : Colors.red.shade50,
          border: Border.all(
            color: isCorrect ? Colors.green.shade200 : Colors.red.shade200,
            width: 1.5,
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
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  isCorrect ? 'correct'.tr() : 'incorrect'.tr(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: isCorrect ? Colors.green.shade800 : Colors.red.shade800,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            if (!isCorrect && correctAnswer != null) ...[
              const SizedBox(height: 8),
              Text(
                '${'correct-answer'.tr()}: $correctAnswer',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.green.shade800,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
            if (explanation != null && explanation!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                'explanation'.tr(),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                explanation!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}