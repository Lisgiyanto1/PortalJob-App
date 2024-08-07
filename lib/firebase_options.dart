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
    apiKey: 'AIzaSyDDc7Kwrtt2J5NwIz_e1AuPTKhb01RQB0c',
    appId: '1:673321402273:web:f8ee258116b91abc3f15e0',
    messagingSenderId: '673321402273',
    projectId: 'sanberflutter-b054e',
    authDomain: 'sanberflutter-b054e.firebaseapp.com',
    storageBucket: 'sanberflutter-b054e.appspot.com',
    measurementId: 'G-5GKK7JRJK8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyChlO492KnQvVUoGB7iH6w-21ErcfyCAe0',
    appId: '1:673321402273:android:7cb4b013abc1aa003f15e0',
    messagingSenderId: '673321402273',
    projectId: 'sanberflutter-b054e',
    storageBucket: 'sanberflutter-b054e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDztfLdJMJ_TV4HAxuEO4tpkrK6xNIs0fA',
    appId: '1:673321402273:ios:996ad2f33409f0d53f15e0',
    messagingSenderId: '673321402273',
    projectId: 'sanberflutter-b054e',
    storageBucket: 'sanberflutter-b054e.appspot.com',
    iosBundleId: 'com.example.flutterApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDztfLdJMJ_TV4HAxuEO4tpkrK6xNIs0fA',
    appId: '1:673321402273:ios:996ad2f33409f0d53f15e0',
    messagingSenderId: '673321402273',
    projectId: 'sanberflutter-b054e',
    storageBucket: 'sanberflutter-b054e.appspot.com',
    iosBundleId: 'com.example.flutterApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDDc7Kwrtt2J5NwIz_e1AuPTKhb01RQB0c',
    appId: '1:673321402273:web:4b3ced1dc7a3c36b3f15e0',
    messagingSenderId: '673321402273',
    projectId: 'sanberflutter-b054e',
    authDomain: 'sanberflutter-b054e.firebaseapp.com',
    storageBucket: 'sanberflutter-b054e.appspot.com',
    measurementId: 'G-MR935EV9J7',
  );
}
