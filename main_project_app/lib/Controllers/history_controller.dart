import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class XValue {
  int index = 0;
  double value = 0;

  XValue({required this.index, required this.value});
}

class HistoryController extends GetxController {
  final FirebaseFirestore db = Get.find();
  List<XValue> xValues = <XValue>[];
  List<double> yValues = [];
  RxList<LineSeries<XValue, int>> XLineSeries = <LineSeries<XValue, int>>[].obs;
  late ChartSeriesController _chartSeriesController;

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
        var dataList = doc.docs;
        for (var i = 0; i < dataList.length; i++) {
          xValues.add(XValue(value: dataList[i]['x'], index: i));
        }
        for (var x in xValues) {
          print("X: ${x.value}");
        }
        XLineSeries.add(LineSeries<XValue, int>(
            onRendererCreated: (ChartSeriesController controller) {
              _chartSeriesController = controller;
            },
            dataSource: xValues,
            xValueMapper: (XValue xIndexValues, _) => xIndexValues.index,
            yValueMapper: (XValue xVibValues, _) => xVibValues.value));
        update();
        connectToRealTimeDB();
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  connectToRealTimeDB() {
    final db = Get.put(FirebaseFirestore.instance);
    final docRef = db.collection("vibdata").doc("realtimedata");
    docRef.snapshots().listen(
          onFirebaseEvent,
          onError: (error) => print("Listen failed: $error"),
        );
  }

  onFirebaseEvent(event) {
    final data = event.data();
    print(xValues.length);
    xValues.add(XValue(value: data['x'], index: xValues.last.index + 1));
    xValues.removeAt(0);
    _chartSeriesController.updateDataSource(
      addedDataIndex: xValues.length - 1,
      removedDataIndex: 0,
    );
    xValues.forEach((e) {
      print("value: ${e.value} index: ${e.index}");
    });
    print("New value added ${xValues.last.value} index ${xValues.length}");
  }
}
