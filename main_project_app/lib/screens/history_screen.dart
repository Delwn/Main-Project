import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main_project_app/Controllers/history_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({Key? key}) : super(key: key);
  final HistoryController controller = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Analysis"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Obx(
              () => SfCartesianChart(
                series: controller.XLineSeries.value,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Obx(() => Text(controller.xValues.last.value.toString())),
          ],
        ),
      ),
    );
  }
}
