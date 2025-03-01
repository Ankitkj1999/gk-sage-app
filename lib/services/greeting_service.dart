import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class GreetingService {
  /// Returns a time-appropriate greeting based on the current time of day
  static String getGreeting(BuildContext context) {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return 'good-morning'.tr();
    } else if (hour >= 12 && hour < 17) {
      return 'good-afternoon'.tr();
    } else if (hour >= 17 && hour < 22) {
      return 'good-evening'.tr();
    } else {
      return 'good-night'.tr();
    }
  }
}
