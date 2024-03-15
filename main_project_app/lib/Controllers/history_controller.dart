import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class XValue {
  int index = 0;
  double value = 0;
}

class HistoryController extends GetxController {
  final FirebaseFirestore db = Get.find();
  List<XValue> xValues = [];
  List<double> yValues = [];

  @override
  onInit() {
    super.onInit();
    print("here");
    getHistoryData();
  }

  getHistoryData() {
    final docRef = db.collection("Real_Time_Data");
    docRef.get().then(
      (QuerySnapshot doc) {
        var dataList = doc.docs.first;
        // for(Map<String, dynamic> x in dataList) {
        //
        // }
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }
}
