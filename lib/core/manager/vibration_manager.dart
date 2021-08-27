import 'package:flutter_vibrate/flutter_vibrate.dart';

class VibrationManager {
  static Future<void> vibrateIfCan() async {
    final bool canVibrate = await Vibrate.canVibrate;
    if (canVibrate) {
      Vibrate.feedback(FeedbackType.heavy);
    }
  }
}
