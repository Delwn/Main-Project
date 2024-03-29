// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCky7oQiQBKmyU5wEBunNCdePiuNogfAeQ',
    appId: '1:1074799079289:web:cdee96b5580dc06b4f09a8',
    messagingSenderId: '1074799079289',
    projectId: 'mainproject-db4ff',
    authDomain: 'mainproject-db4ff.firebaseapp.com',
    storageBucket: 'mainproject-db4ff.appspot.com',
    measurementId: 'G-1G7B2L8DPH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBCdfZ_ZNSiPzSMsLgiZKntrNH9RQga4fg',
    appId: '1:1074799079289:android:c6e2ceb6318d3e614f09a8',
    messagingSenderId: '1074799079289',
    projectId: 'mainproject-db4ff',
    storageBucket: 'mainproject-db4ff.appspot.com',
  );
}
