import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_project_app/apis/api.dart';
import 'package:main_project_app/main.dart';
import 'package:main_project_app/screens/home_screen.dart';

class login_page extends StatefulWidget {
  const login_page({super.key});

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: mq.height * 0.04,
            ),
            Center(
              child: Image.asset(
                "assets/images/login.jpg",
                height: 350,
                width: 350,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text(
                "Login",
                style: GoogleFonts.poppins(
                    fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text(
                "Please SignIn to continue.",
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: mq.height * 0.04,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelStyle: GoogleFonts.poppins(color: Colors.black54),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 3.0, color: Colors.black)),
                  contentPadding: const EdgeInsets.all(25),
                  prefixIcon: const Icon(
                    Icons.mail,
                    color: Colors.black,
                  ),
                  label: Text(
                    "Email",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                  hintText: "Email",
                  hintStyle: GoogleFonts.poppins(color: Colors.grey.shade400),
                ),
              ),
            ),
            SizedBox(
              height: mq.height * 0.02,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(25),
                  prefixIcon: const Icon(
                    Icons.password_rounded,
                    color: Colors.black,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(width: 3.0, color: Colors.black)),
                  label: Text(
                    "Password",
                    style: GoogleFonts.poppins(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  hintText: "Password",
                  hintStyle: GoogleFonts.poppins(color: Colors.grey.shade400),
                ),
              ),
            ),
            SizedBox(
              height: mq.height * 0.08,
            ),
            InkWell(
              onTap: () {
                loginFunction();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Container(
                  height: 50,
                  width: 400,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Login",
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future loginFunction() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await APIs.auth
          .signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      )
          .then(
        (value) async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const home_screen(),
            ),
          );
        },
      );
      // ignore: nullable_type_in_catch_clause
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e);
    }
    // navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
