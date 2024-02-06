import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:main_project_app/firebase_options.dart';
import 'package:main_project_app/screens/login_screen.dart';
import 'package:main_project_app/screens/splash_Screen.dart';

late Size mq;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: splash_Screen(),
    );
  }
}
