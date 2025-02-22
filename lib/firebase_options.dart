// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        // throw UnsupportedError(
        //   'DefaultFirebaseOptions have not been configured for android - '
        //   'you can reconfigure this by running the FlutterFire CLI again.',
        // );
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: "AIzaSyBn43iB5jIIMPnd2bSbHo65KfaV2vBp_H8",
    authDomain: "justlikeanimal-28407.firebaseapp.com",
    databaseURL: "https://justlikeanimal-28407-default-rtdb.firebaseio.com",
    projectId: "justlikeanimal-28407",
    storageBucket: "justlikeanimal-28407.appspot.com",
    messagingSenderId: "1020710759774",
    appId: "1:1020710759774:web:0351bb32f29c6bfcc673cf"
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCdyw7k3Gt6QSaAfgo6XNjyFk-ZzuotFJg',
    appId: '1:1020710759774:ios:be56e490c39d385fc673cf',
    messagingSenderId: '1020710759774',
    projectId: 'justlikeanimal-28407',
    storageBucket: 'justlikeanimal-28407.appspot.com',
    iosBundleId: 'com.example.justLikeAnimal',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCdyw7k3Gt6QSaAfgo6XNjyFk-ZzuotFJg',
    appId: '1:1020710759774:ios:be56e490c39d385fc673cf',
    messagingSenderId: '1020710759774',
    projectId: 'justlikeanimal-28407',
    storageBucket: 'justlikeanimal-28407.appspot.com',
    iosBundleId: 'com.example.justLikeAnimal',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: "AIzaSyBn43iB5jIIMPnd2bSbHo65KfaV2vBp_H8",
    authDomain: "justlikeanimal-28407.firebaseapp.com",
    databaseURL: "https://justlikeanimal-28407-default-rtdb.firebaseio.com",
    projectId: "justlikeanimal-28407",
    storageBucket: "justlikeanimal-28407.appspot.com",
    messagingSenderId: "1020710759774",
    appId: "1:1020710759774:web:50c6029398094dccc673cf"
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBn43iB5jIIMPnd2bSbHo65KfaV2vBp_H8',
    appId: '1:1020710759774:android:38614f6c6409b56fc673cf',
    messagingSenderId: '1020710759774',
    projectId: 'justlikeanimal-28407',
    storageBucket: 'justlikeanimal-28407.appspot.com',
    iosBundleId: 'com.example.justLikeAnimal',
  );

}