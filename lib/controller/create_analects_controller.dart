import 'dart:async';

import 'package:analects/app/modules/widgets/widget_imports.dart';

class CreateAnalectsController extends GetxController { 
  var isRunning = false.obs;
  var startTime = 0.obs;
  var elapsedTime = 0.obs;
  

  String get displayTime {
    Duration duration = Duration(milliseconds: elapsedTime.value);
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');

    return '$minutes:$seconds';
  }

  void start() {
    if (!isRunning.value) {
      startTime.value =
          DateTime.now().millisecondsSinceEpoch - elapsedTime.value;
      isRunning.value = true;
      update();
      Get.put<CreateAnalectsController>(CreateAnalectsController());
      Timer.periodic(const Duration(seconds: 1), (timer) {
        if (isRunning.value) {
          elapsedTime.value =
              DateTime.now().millisecondsSinceEpoch - startTime.value;
          update();
        }
      });
    }
  }

  void stop() {
    if (isRunning.value) {
      isRunning.value = false;
      update();
    }
  }

  void reset() {
    if (!isRunning.value) {
      elapsedTime.value = 0;
      update();
    }
  }
}
