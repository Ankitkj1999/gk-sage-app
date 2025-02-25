import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/pages/quiz_complete.dart';
import '../../blocs/temp_bloc.dart';
import '../../blocs/user_bloc.dart';
import '../../services/firebase_service.dart';
import '../../utils/next_screen.dart';

class TimerCountDown extends StatefulWidget {
  const TimerCountDown({super.key, required this.quizTime, required this.qList, required this.selfChallengeMode});

  final int quizTime;
  final List<Question> qList;
  final bool selfChallengeMode;

  @override
  State<TimerCountDown> createState() => TimerCountDownState();
}

class TimerCountDownState extends State<TimerCountDown> {
  late DateTime _endTime;

  @override
  void initState() {
    _endTime = DateTime.now().add(Duration(minutes: widget.quizTime));
    super.initState();
  }

  _onEnd() async {
    final ub = context.read<UserBloc>();
    final tb = context.read<TempBloc>();
    if (widget.selfChallengeMode == false) {
      await FirebaseService().updateUserPoints(context.read<UserBloc>().userData!.uid!, context.read<TempBloc>().points);
      await ub.updateUserPointsToBloc(tb.points);
    }
    if (!mounted) return;
    NextScreen().nextScreenReplace(
      context,
      QuizComplete(
        qList: widget.qList,
        isTimeOver: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(20)),
        child: TimerCountdown(
            onEnd: () => _onEnd(),
            format: CountDownTimerFormat.minutesSeconds,
            enableDescriptions: false,
            spacerWidth: 4,
            colonsTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            timeTextStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
            endTime: _endTime));
  }
}
