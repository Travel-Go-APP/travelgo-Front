import 'package:get/get.dart';

class attractInfo extends GetxController {
  int percentValue = 0;

  Future<void> updateValue() async {
    percentValue = 83;
  }

  Future<void> updateValue2() async {
    percentValue += 5;
  }
}
