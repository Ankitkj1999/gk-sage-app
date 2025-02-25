import 'package:flutter/material.dart';
import 'package:quiz_app/constants/constant.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/utils/icon_utils.dart';
import 'package:quiz_app/utils/image_preview.dart';
import 'package:quiz_app/utils/next_screen.dart';
import 'package:quiz_app/widgets/html_body.dart';

import '../utils/cached_image.dart';

class QuestionExplaination extends StatelessWidget {
  const QuestionExplaination({super.key, required this.q});

  final Question q;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Question Explaination',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(q.questionTitle.toString(), style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        IconUtils.rightAnswerOption,
                        color: Colors.green,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      _correctAnswerWidget(context),
                    ],
                  ),
                ],
              ),
            ),
            HtmlBody(description: q.explaination.toString())
          ],
        ),
      ),
    );
  }

  Widget _correctAnswerWidget(BuildContext context) {
    final String correctAnswer = q.options!.elementAt(q.correctAnswerIndex!);
    if (q.optionsType == Constants.optionTypes.keys.elementAt(2)) {
      // Correct answer with image
      return Expanded(
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          height: 150,
          width: double.infinity,
          child: InkWell(
            onTap: () => NextScreen.nextScreenNormal(context, FullImagePreview(imageUrl: correctAnswer)),
            child: CustomCacheImage(
              imageUrl: correctAnswer,
              radius: 10,
            ),
          ),
        ),
      );
    } else {
      return Expanded(
        child: Text(
          correctAnswer,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
      );
    }
  }
}
