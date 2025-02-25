import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/pages/quiz_screen/close_dialog.dart';
import 'package:quiz_app/pages/quiz_screen/control_dialog.dart';
import '../../blocs/temp_bloc.dart';
import '../../configs/feature_config.dart';
import '../../models/question.dart';
import '../../utils/icon_utils.dart';
import 'timer_countdown.dart';

AppBar progessAppBar({
  required BuildContext context,
  required bool hasTimer,
  required List<Question> qList,
  required int quizTime,
  required bool selfChallengeMode,
  required Function handleAddToBookmark,
}) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    automaticallyImplyLeading: false,
    titleSpacing: 0,
    title: LinearPercentIndicator(
      animation: true,
      animationDuration: 400,
      lineHeight: 20.0,
      leading: IconButton(
          padding: const EdgeInsets.only(left: 10),
          onPressed: () => openQuizCloseDialog(context: context),
          icon: const Icon(
            Icons.close,
            color: Colors.black,
          )),
      trailing: Row(
        children: [
          Visibility(
              visible: hasTimer && quizTime != 0,
              child: TimerCountDown(
                quizTime: quizTime,
                qList: qList,
                selfChallengeMode: selfChallengeMode,
              )),
          Visibility(
            visible: FeatureConfig.bookmarkQuestionEnabled,
            child: InkWell(
              onTap: () => handleAddToBookmark(),
              child: Container(
                  width: 40,
                  height: 30,
                  margin: const EdgeInsets.only(right: 0, left: 10),
                  decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(20)),
                  child: const Icon(IconUtils.addBookmark)),
            ),
          ),
          InkWell(
            onTap: () => openControlDialog(context),
            child: Container(
              width: 40,
              height: 30,
              margin: const EdgeInsets.only(right: 10, left: 10),
              decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(20)),
              child: const Icon(
                Ionicons.options,
                size: 20,
              ),
            ),
          ),
        ],
      ),
      percent: context.watch<TempBloc>().percentage,
      progressColor: Theme.of(context).primaryColor,
      barRadius: const Radius.circular(30),
      animateFromLastPercent: true,
    ),
  );
}
