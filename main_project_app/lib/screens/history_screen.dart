import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_project_app/Controllers/history_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({Key? key}) : super(key: key);
  final HistoryController controller = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xff181822),
      appBar: AppBar(
        backgroundColor: Color(0xff181822),
        centerTitle: true,
        title: Text("Analysis",
            style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: mq.height / 36,
            ),
            Obx(
              () => SfCartesianChart(
                series: controller.XLineSeries.value,
                // backgroundColor: Colors.black,
                // plotAreaBackgroundColor: Colors.black,
                // plotAreaBorderColor: Colors.cyan,
                // borderColor: Colors.cyan,
              ),
            ),
            SizedBox(
              height: mq.height / 36,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnalysisIconWidget(image: "alltime", text: "All time faults"),
                AnalysisIconWidget(
                    image: "current", text: "Faults in this session"),
              ],
            ),
            SizedBox(
              height: mq.height / 36,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnalysisIconWidget(
                    image: "peak", text: "Peak fault rate (fpm)"),
                AnalysisIconWidget(
                    image: "session", text: "Session fault rate (fpm)"),
              ],
            )
            // Container(
            //   decoration: const BoxDecoration(color: Color(0x11000000)),
            //   padding: EdgeInsets.all(20),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       const Text("Number of faults"),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //         children: [
            //           Obx(() => Text(
            //               "All time: ${controller.allTimeFaults.value} fault(s)")),
            //           Obx(() => Text(
            //               "This session: ${controller.sessionFaults.value} fault(s)")),
            //         ],
            //       )
            //     ],
            //   ),
            // ),
            // Container(
            //   decoration: const BoxDecoration(color: Color(0x11000000)),
            //   padding: EdgeInsets.all(20),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       const Text("Fault rate"),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //         children: [
            //           Obx(() => Text("Peak: ${controller.peakRate.value} fpm")),
            //           Obx(() =>
            //               Text("Current: ${controller.currentRate.value} fpm")),
            //         ],
            //       )
            //     ],
            //   ),
            // ),
            // Obx(() => Text(controller.xValues.last.value.toString())),
          ],
        ),
      ),
    );
  }
}

class AnalysisIconWidget extends StatelessWidget {
  AnalysisIconWidget({super.key, required this.image, required this.text});
  final HistoryController controller = Get.find();
  final String image, text;
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        color: Color(0xff22222e),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      width: mq.width / 2.5,
      height: mq.height / 4.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset("assets/icons/$image.png"),
          const SizedBox(
            height: 10,
          ),
          Obx(() => Text(
                "${controller.allTimeFaults.value}",
                style: const TextStyle(
                    fontSize: 20,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w300),
              )),
          const SizedBox(
            height: 10,
          ),
          Text(
            text,
            style: const TextStyle(color: Colors.white24),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
