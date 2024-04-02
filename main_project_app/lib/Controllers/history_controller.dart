import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class VibValue {
  int index = 0;
  double value = 0;

  VibValue({required this.index, required this.value});
}

class HistoryController extends GetxController {
  final FirebaseFirestore db = Get.find();

  RxInt allTimeFaults = 0.obs;
  RxInt sessionFaults = 0.obs;
  RxInt peakRate = 0.obs;
  RxInt currentRate = 0.obs;

  List<VibValue> xValues = <VibValue>[];
  List<VibValue> yValues = <VibValue>[];
  List<VibValue> zValues = <VibValue>[];

  RxList<LineSeries<VibValue, int>> XLineSeries =
      <LineSeries<VibValue, int>>[].obs;
  late ChartSeriesController _xSeriesController;
  late ChartSeriesController _ySeriesController;
  late ChartSeriesController _zSeriesController;

  @override
  onInit() {
    super.onInit();
    getHistoryData();
  }

  getHistoryData() {
    final docRef = db.collection("Real_Time_Data");
    docRef.get().then(
      (QuerySnapshot doc) {
        var dataList = doc.docs;
        for (var i = 0; i < dataList.length; i++) {
          xValues.add(VibValue(value: dataList[i]['x'], index: i));
          yValues.add(VibValue(value: dataList[i]['y'], index: i));
          zValues.add(VibValue(value: dataList[i]['z'], index: i));
        }
        for (var y in yValues) {
          print("Y: ${y.value}");
        }
        XLineSeries.add(LineSeries<VibValue, int>(
            onRendererCreated: (ChartSeriesController controller) {
              _xSeriesController = controller;
            },
            dataSource: xValues,
            xValueMapper: (VibValue xIndexValues, _) => xIndexValues.index,
            yValueMapper: (VibValue xVibValues, _) => xVibValues.value));
        XLineSeries.add(LineSeries<VibValue, int>(
            onRendererCreated: (ChartSeriesController controller) {
              _ySeriesController = controller;
            },
            dataSource: yValues,
            xValueMapper: (VibValue yIndexValues, _) => yIndexValues.index,
            yValueMapper: (VibValue yVibValues, _) => yVibValues.value));
        XLineSeries.add(LineSeries<VibValue, int>(
            onRendererCreated: (ChartSeriesController controller) {
              _zSeriesController = controller;
            },
            dataSource: zValues,
            xValueMapper: (VibValue zIndexValues, _) => zIndexValues.index,
            yValueMapper: (VibValue zVibValues, _) => zVibValues.value));
        update();
        connectToRealTimeDB();
      },
      onError: (e) => print("Error getting document: $e"),
    );

    final analysisRef = db.collection("History").doc("analysis");
    analysisRef.snapshots().listen(
          onAnalysisEvent,
          onError: (error) => print("Listen failed: $error"),
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
    xValues.add(VibValue(value: data['x'], index: xValues.last.index + 1));
    yValues.add(VibValue(value: data['y'], index: yValues.last.index + 1));
    zValues.add(VibValue(value: data['z'], index: zValues.last.index + 1));
    xValues.removeAt(0);
    yValues.removeAt(0);
    zValues.removeAt(0);
    _xSeriesController.updateDataSource(
      addedDataIndex: xValues.length - 1,
      removedDataIndex: 0,
    );
    _ySeriesController.updateDataSource(
      addedDataIndex: yValues.length - 1,
      removedDataIndex: 0,
    );
    _zSeriesController.updateDataSource(
      addedDataIndex: zValues.length - 1,
      removedDataIndex: 0,
    );
    xValues.forEach((e) {
      print("value: ${e.value} index: ${e.index}");
    });
    print("New value added ${xValues.last.value} index ${xValues.length}");
  }

  onAnalysisEvent(event) {
    final data = event.data();
    allTimeFaults.value = data['alltime'] as int ?? 0;
    peakRate.value = data['peak'] as int ?? 0;
    currentRate.value = data['current'] as int ?? 0;
    sessionFaults.value = data['session'] as int ?? 0;
    update();
  }
}
