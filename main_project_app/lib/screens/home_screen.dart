import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_project_app/Controllers/homeController.dart';
import 'package:main_project_app/apis/api.dart';
import 'package:main_project_app/screens/login_screen.dart';

class home_screen extends StatelessWidget {
  home_screen({super.key});
  HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Obx(
      () => Scaffold(
          backgroundColor: !controller.faultOccured.value
              ? Color(0xff11ab1c)
              : Color(0xffb91f15),
          appBar: AppBar(
            backgroundColor: !controller.faultOccured.value
                ? Color(0xff11ab1c)
                : Color(0xffb91f15),
            automaticallyImplyLeading: false,
            title: Text(
              "Fault Detection",
              style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () async {
                  await APIs.auth.signOut().then((value) async => {
                        FirebaseAuth.instance.signOut(),
                        APIs.auth = FirebaseAuth.instance,
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const login_page()))
                      });
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          body: Center(
            child: Column(
              children: [
                SizedBox(
                  height: mq.height / 6,
                ),
                SizedBox(
                    child: Obx(() => Image.asset(controller.getImage)),
                    width: mq.width / 2.4),
                SizedBox(
                  height: mq.height / 10,
                ),
                Obx(() => Text(
                      controller.getFaultText,
                      style: GoogleFonts.rubik(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    )),
                SizedBox(
                  height: mq.height / 10,
                ),
                Column(
                  children: [Text("DE - 0.00012"), Text("DE - 0.00012")],
                ),
                FilledButton(
                    onPressed: controller.flipFaultOccured,
                    child: Text("Switch")),
              ],
            ),
          )),
    );
  }
}
