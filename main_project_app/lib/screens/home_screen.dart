import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_project_app/apis/api.dart';
import 'package:main_project_app/screens/login_screen.dart';

class home_screen extends StatelessWidget {
  const home_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: Text(
            "Home Page",
            style:
                GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Center(
              child: ElevatedButton(
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
                  child: const Text("Logout")),
            ),
          ],
        ));
  }
}
