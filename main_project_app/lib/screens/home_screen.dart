import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_project_app/Controllers/home_controller.dart';
import 'package:main_project_app/apis/api.dart';
import 'package:main_project_app/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController controller = Get.put(HomeController());
  final DatabaseReference ref = Get.put(FirebaseDatabase.instance.ref());

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Obx(
      () => Scaffold(
          backgroundColor: !controller.faultOccured.value
              ? const Color(0xff11ab1c)
              : const Color(0xffb91f15),
          appBar: AppBar(
            backgroundColor: !controller.faultOccured.value
                ? const Color(0xff11ab1c)
                : const Color(0xffb91f15),
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
                                builder: (_) => const LoginPage()))
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
                    width: mq.width / 2.4,
                    child: Obx(() => Image.asset(controller.getImage))),
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
                Container(
                  alignment: Alignment.center,
                  height: 100,
                  width: 200,
                  decoration: BoxDecoration(
                      color: !controller.faultOccured.value
                          ? const Color(0xff11ab1c)
                          : const Color(0xffb91f15),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: !controller.faultOccured.value
                              ? const Color(0xff175d1b)
                              : const Color(0xff590e0a),
                          offset: const Offset(10, 10),
                          blurRadius: 20,
                          // spreadRadius: 1,
                        ),
                        BoxShadow(
                          color: !controller.faultOccured.value
                              ? const Color(0xff35d741)
                              : const Color(0xffee392e),
                          offset: const Offset(-10, -10),
                          blurRadius: 20,
                          // spreadRadius: 5,
                        ),
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() => Text(
                            "X: ${controller.x.value}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          )),
                      Obx(() => Text(
                            "Y: ${controller.y.value}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ))
                    ],
                  ),
                ),
                // FilledButton(
                //     onPressed: controller.flipFaultOccured,
                //     child: Text("Switch")),
              ],
            ),
          )),
    );
  }
}