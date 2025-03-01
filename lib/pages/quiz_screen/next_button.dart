import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/blocs/question_bloc.dart';
import 'package:quiz_app/configs/color_config.dart';
import '../../widgets/loading_widget.dart';

class NextButton extends StatelessWidget {
  const NextButton(
      {super.key, required this.isLoading, required this.onPressed});

  final bool isLoading;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    final int questionIndex = context.watch<QuestionBloc>().pageIndex;
    return BottomAppBar(
      color: ColorConfig.bgColor,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 3),
        child: TextButton(
          onPressed: () {
            // Retrieve and print the question info from QuestionBloc
            final questionBloc = context.read<QuestionBloc>();
            final questionInfo = questionBloc.question?.explaination;
            debugPrint("Next Button Pressed");
            debugPrint(
                "Question Info: ${questionInfo != null ? questionInfo.toString() : 'No question available'}");
            debugPrint("Drag Target Text: ${questionBloc.dragTargetText}");

            onPressed(questionIndex);
          },
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor,
          ),
          child: isLoading
              ? const LoadingIndicatorWidget(
                  color: Colors.white,
                )
              : Text(
                  'next',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ).tr(),
        ),
      ),
    );
  }
}
