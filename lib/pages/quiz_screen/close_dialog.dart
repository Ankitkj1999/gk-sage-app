import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import '../../configs/app_config.dart';

void openQuizCloseDialog({required BuildContext context}) async {
  return Dialogs.materialDialog(
    context: context,
    title: 'quit-quiz-title'.tr(),
    msg: 'quit-quiz-subtitle'.tr(),
    color: Colors.white,
    titleStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    msgAlign: TextAlign.center,
    msgStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    dialogShape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    lottieBuilder: LottieBuilder.asset(
      Config.quitAnimation,
      fit: BoxFit.contain,
    ),
    actionsBuilder: (context) {
      return [
        IconsOutlineButton(
          text: 'no'.tr(),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          onPressed: () => Navigator.pop(context),
        ),
        IconsOutlineButton(
          text: 'yes'.tr(),
          color: Colors.red,
          textStyle: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
      ];
    },
  );
}
