//global object for accessing device screen size
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:main_project_app/main.dart';
import 'package:main_project_app/screens/home_screen.dart';
import 'package:main_project_app/screens/login_screen.dart';

// statefull widget as we are dynamically changing it
class splash_Screen extends StatefulWidget {
  const splash_Screen({super.key});

  @override
  State<splash_Screen> createState() => _splash_ScreenState();
}

class _splash_ScreenState extends State<splash_Screen> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    super.initState();
    Future.delayed(
      const Duration(seconds: 4),
      () {
        //exit fullscreen
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
              systemNavigationBarColor: Colors.transparent,
              statusBarColor: Colors.transparent),
        );
        if (FirebaseAuth.instance.currentUser != null) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const home_screen()));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const login_page()));
        }
      },
    ); // after one and half a second
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: mq.height * 0.3),
            Image.asset(
              'assets/images/logo.png',
              color: Colors.black,
              // height: 200,
              width: mq.width * 0.65,
            ),
            SizedBox(
              height: mq.height * 0.4,
            ),
            Image.asset(
              "assets/images/loading.gif",
              color: Colors.black,
              height: mq.height * 0.1,
            ),
          ],
        ),
      ),
    );
  }
}
