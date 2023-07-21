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
        return ios;
      case TargetPlatform.macOS:
        return macos;
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
    apiKey: 'AIzaSyAWW5fGssMYrr37EQsyNJO8N1VGaLU3na0',
    appId: '1:446300397474:web:4b0b488bde1c1eda0fdcfb',
    messagingSenderId: '446300397474',
    projectId: 'lilactest-7d199',
    authDomain: 'lilactest-7d199.firebaseapp.com',
    storageBucket: 'lilactest-7d199.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA7MjO5nnbHlt3QBNY29JuxoApANYlZq4w',
    appId: '1:446300397474:android:9817e5f6ab587ad50fdcfb',
    messagingSenderId: '446300397474',
    projectId: 'lilactest-7d199',
    storageBucket: 'lilactest-7d199.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDleKa8fxEVWRBL9feH1FUbJFbozOs18_k',
    appId: '1:446300397474:ios:8c8623e3f0af3ffb0fdcfb',
    messagingSenderId: '446300397474',
    projectId: 'lilactest-7d199',
    storageBucket: 'lilactest-7d199.appspot.com',
    iosClientId: '446300397474-69vlragl1064vvrseeoegg14940r5ut8.apps.googleusercontent.com',
    iosBundleId: 'com.example.fluttertest',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDleKa8fxEVWRBL9feH1FUbJFbozOs18_k',
    appId: '1:446300397474:ios:c056bd7416f753420fdcfb',
    messagingSenderId: '446300397474',
    projectId: 'lilactest-7d199',
    storageBucket: 'lilactest-7d199.appspot.com',
    iosClientId: '446300397474-3phik008v949v912ea2dqe3f8ne11cb5.apps.googleusercontent.com',
    iosBundleId: 'com.example.fluttertest.RunnerTests',
  );
}