import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/blocs/question_bloc.dart';
import 'package:quiz_app/blocs/temp_bloc.dart';
import 'package:quiz_app/utils/next_screen.dart';
import '../../constants/constant.dart';
import '../../models/question.dart';
import '../../services/app_service.dart';
import '../../utils/cached_image.dart';
import '../../utils/image_preview.dart';
import '../../widgets/audio_widget.dart';
import '../../widgets/video_player_widget.dart';

class QuestionTitle extends StatelessWidget {
  const QuestionTitle({
    super.key,
    required this.question,
    required this.qList,
  });

  final List<Question> qList;
  final Question question;

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'question-count-title',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.blueGrey[800]),
                    ).tr(
                      args: [
                        context
                            .watch<TempBloc>()
                            .currentQuestionIndex
                            .toString(),
                        qList.length.toString()
                      ],
                    ),
                    question.questionType ==
                            Constants.questionTypes.keys.elementAt(4)
                        ? DraggableTitle(question: question)
                        : NormalTitle(question: question),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Visibility(
          visible: question.questionType ==
              Constants.questionTypes.keys.elementAt(1),
          child: InkWell(
            onTap: () => NextScreen().nextScreenPopup(
                context,
                FullImagePreview(
                    imageUrl: question.questionImageUrl.toString())),
            child: SizedBox(
              height: 150,
              width: double.infinity,
              child: CustomCacheImage(
                imageUrl: question.questionImageUrl,
                radius: 5,
              ),
            ),
          ),
        ),
        Visibility(
          visible: question.questionType ==
              Constants.questionTypes.keys.elementAt(3),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: VideoPlayerWidget(
                videoUrl: question.questionVideoUrl.toString(),
                videoType: AppService.getVideoType(
                    question.questionVideoUrl.toString()),
              )),
        ),
        Visibility(
          visible: question.questionType ==
              Constants.questionTypes.keys.elementAt(2),
          child: AudioWidget(
            audioUrl: question.questionAudioUrl.toString(),
          ),
        ),
      ],
    );
  }
}

class NormalTitle extends StatelessWidget {
  const NormalTitle({super.key, required this.question});

  final Question question;

  @override
  Widget build(BuildContext context) {
    return Text(
      question.questionTitle.toString(),
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.blueGrey.shade900,
          ),
    );
  }
}

class DraggableTitle extends StatelessWidget {
  const DraggableTitle({super.key, required this.question});

  final Question question;

  @override
  Widget build(BuildContext context) {
    List<String> questionParts = question.questionTitle.toString().split('<_>');
    String questionBefore = questionParts.first;
    String questionAfter = questionParts.length > 1 ? questionParts.last : '';

    final String dragTargetText =
        context.read<QuestionBloc>().dragTargetText ?? '';
    final double width =
        dragTargetText.isEmpty ? 150 : (dragTargetText.length) * 13;

    return DragTarget<String>(
      builder: (BuildContext context, List<String?> candidateData,
          List<dynamic> rejectedData) {
        return Wrap(
          runSpacing: 5,
          children: [
            Text(
              questionBefore,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey.shade900,
                  ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: width,
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide()),
              ),
              child: Center(
                child: Text(
                  dragTargetText,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                ),
              ),
            ),
            Text(
              questionAfter,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey.shade900,
                  ),
            ),
          ],
        );
      },
      onWillAcceptWithDetails: (data) => true,
      onAcceptWithDetails: (data) =>
          context.read<QuestionBloc>().updateDragTargetText(data.data),
    );
  }
}
