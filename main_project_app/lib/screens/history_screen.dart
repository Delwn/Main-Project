import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main_project_app/Controllers/history_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({Key? key}) : super(key: key);
  HistoryController controller = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SfCartesianChart(
            series: <LineSeries<XValue, int>>[
              LineSeries<XValue, int>(
                  // dataSource: ,
                  xValueMapper: (XValue xIndexValues, _) => xIndexValues.index,
                  yValueMapper: (XValue xVibValues, _) => xVibValues.value)
            ],
          ),
          FilledButton(
            onPressed: controller.getHistoryData,
            child: const Text("Refresh"),
          ),
        ],
      ),
    );
  }
}
