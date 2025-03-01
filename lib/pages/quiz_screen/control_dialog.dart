import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../widgets/control_settings.dart';

openControlDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: ((context) {
        return AlertDialog(
          content: const ControllSettings(),
          title: const Text('settings').tr(),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'))
          ],
        );
      }));
}
