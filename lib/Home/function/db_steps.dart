import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pedometer/pedometer.dart';

class dbSteps extends GetxController {
  late Stream<StepCount> _stepCountStream; // pedometer
  Box<int> stepsBox = Hive.box('steps'); // steps 데이터베이스
  RxInt steps = 0.obs; // 걸음수
  int w = 0; // 가중치

  void onlnit() {
    super.onInit();
    ever(steps, (callback) => print("걸음수가 변동되었습니다."));
  }

  void initPlatformState(BuildContext context) {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (context.mounted) return;
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
  }

  // 걸음수 카운팅
  void onStepCount(StepCount event) {
    int savedStepsCountKey = 999999;
    int? savedStepsCount = stepsBox.get(savedStepsCountKey, defaultValue: 0);
    int todayDayNo = DateTime.now().year * 10000 +
        DateTime.now().month * 100 +
        DateTime.now().day; //millisecond값으로 쓰고 백엔드에 post할때는 string

    // 재부팅 했을때
    if (event.steps < savedStepsCount!) {
      savedStepsCount = 0;
      print("conunt key: $savedStepsCountKey");
      print("conunt: $savedStepsCount");
      stepsBox.put(savedStepsCountKey, savedStepsCount);
      w = stepsBox.get(todayDayNo, defaultValue: 0)!;
    }

    int lastDaySavedKey = 888888;
    int? lastDaySaved = stepsBox.get(lastDaySavedKey, defaultValue: 0);

    // 일일 걸음수 초기화 (00:00)
    if (lastDaySaved! < todayDayNo) {
      lastDaySaved = todayDayNo;
      savedStepsCount = event.steps;
      w = 0;

      stepsBox
        ..put(lastDaySavedKey, lastDaySaved)
        ..put(savedStepsCountKey, savedStepsCount);
    }

    int tdayStep = event.steps - savedStepsCount + w;

    putNumber(tdayStep); // 카운팅 (상태관리)

    stepsBox.put(todayDayNo, tdayStep);
  }

  // 카운팅 (상태관리)
  void putNumber(int value) {
    steps(value);
  }
}
