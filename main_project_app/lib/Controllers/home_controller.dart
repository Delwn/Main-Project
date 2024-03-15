import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static const faultImgPath = 'assets/images/fault.png';
  static const noFaultImgPath = 'assets/images/no_fault.png';
  static const faultText = 'FAULT DETECTED';
  static const noFaultText = 'NO FAULTS';

  RxInt count = 0.obs;
  RxBool faultOccured = false.obs;
  RxDouble x = 0.0.obs;
  RxDouble y = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    initFirebaseConnection();
  }

  increment() => count++;
  get getImage => faultOccured.value ? faultImgPath : noFaultImgPath;
  get getFaultText => faultOccured.value ? faultText : noFaultText;

  updateFaultOccured(bool value) {
    faultOccured.value = value;
    update();
  }

  flipFaultOccured() {
    faultOccured.value = !faultOccured.value;
    initFirebaseConnection();
    update();
  }

  initFirebaseConnection() async {
    final db = Get.put(FirebaseFirestore.instance);
    final docRef = db.collection("vibdata").doc("realtimedata");
    docRef.snapshots().listen(
          onFirebaseEvent,
          onError: (error) => print("Listen failed: $error"),
        );
  }

  onFirebaseEvent(event) {
    final data = event.data();
    if (faultOccured.value != data['status'] ||
        x.value != data['x'] ||
        y.value != data['y']) {
      faultOccured.value = data['status'];
      x.value = data['x'] as double;
      y.value = data['y'] as double;

      update();
    }
  }
}
