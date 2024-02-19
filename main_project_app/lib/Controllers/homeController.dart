import 'package:get/get.dart';

class HomeController extends GetxController {
  static const faultImgPath = 'assets/images/fault.png';
  static const noFaultImgPath = 'assets/images/no_fault.png';
  static const faultText = 'FAULT DETECTED';
  static const noFaultText = 'NO FAULTS';

  RxInt count = 0.obs;
  RxBool faultOccured = false.obs;

  increment() => count++;
  get getImage => faultOccured.value ? faultImgPath : noFaultImgPath;
  get getFaultText => faultOccured.value ? faultText : noFaultText;

  updateFaultOccured(bool value) {
    faultOccured.value = value;
    update();
  }

  flipFaultOccured() {
    faultOccured.value = !faultOccured.value;
    update();
  }
}
