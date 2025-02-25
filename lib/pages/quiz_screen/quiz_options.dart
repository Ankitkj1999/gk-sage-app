import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/cards/image_option_card.dart';
import 'package:quiz_app/cards/option_card.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/pages/quiz_screen/draggble_option_card.dart';
import '../../constants/constant.dart';

class QuizOptions extends StatelessWidget {
  const QuizOptions({super.key, required this.question, required this.selectedOptionIndex, required this.onOptionPressed});

  final Question question;
  final int? selectedOptionIndex;
  final Function onOptionPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50, top: 20),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: <BoxShadow>[BoxShadow(color: Colors.grey[200]!, blurRadius: 10, offset: const Offset(0, 5))]),
        child: LiveList(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: question.options!.length,
          itemBuilder: (context, optionIndex, animation) {
            final String option = question.options![optionIndex];
            bool isSelected = selectedOptionIndex != null && selectedOptionIndex == optionIndex;

            return FadeTransition(
              opacity: Tween<double>(begin: 0, end: 1).animate(animation),
              child: SlideTransition(
                position: Tween<Offset>(begin: const Offset(0, -0.1), end: Offset.zero).animate(animation),
                child: _optionCard(option, isSelected, optionIndex),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _optionCard(String option, bool isSelected, int optionIndex) {
    // for fill blanks question types
    if (question.questionType == Constants.questionTypes.keys.elementAt(4)) {
      return DraggableOptionCard(optionTitle: option, onOptionTriggered: () => onOptionPressed(optionIndex));
    } else {
      // for text options
      if (question.optionsType == Constants.optionTypes.keys.elementAt(0) || question.optionsType == Constants.optionTypes.keys.elementAt(1)) {
        return InkWell(child: OptionCard(optionTitle: option, isSelected: isSelected), onTap: () => onOptionPressed(optionIndex));
      } else {
        // for image options
        return InkWell(child: ImageOptionCard(isSelected: isSelected, optionImage: option), onTap: () => onOptionPressed(optionIndex));
      }
    }
  }
}
