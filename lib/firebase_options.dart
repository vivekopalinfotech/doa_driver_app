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
    apiKey: 'AIzaSyADJ9lKpuv4fVvrqOGxGjGeDcDGxkhk9cI',
    appId: '1:203281484288:web:9026614a0a1d02797826e5',
    messagingSenderId: '203281484288',
    projectId: 'royal-kush---doa',
    authDomain: 'royal-kush---doa.firebaseapp.com',
    storageBucket: 'royal-kush---doa.appspot.com',
    measurementId: 'G-NBS5XBGMXJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDREuv26IohD_qvBPRi6N44KagKdRgSrjE',
    appId: '1:203281484288:android:120727e454f819f87826e5',
    messagingSenderId: '203281484288',
    projectId: 'royal-kush---doa',
    storageBucket: 'royal-kush---doa.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC_KABzMJwe4EO3KUlx5xtKsDi13PVlKgE',
    appId: '1:203281484288:ios:c6a6302dba6505677826e5',
    messagingSenderId: '203281484288',
    projectId: 'royal-kush---doa',
    storageBucket: 'royal-kush---doa.appspot.com',
    iosBundleId: 'com.opal.royalkushdriverappdata',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC_KABzMJwe4EO3KUlx5xtKsDi13PVlKgE',
    appId: '1:203281484288:ios:4c0781e2a4e017e97826e5',
    messagingSenderId: '203281484288',
    projectId: 'royal-kush---doa',
    storageBucket: 'royal-kush---doa.appspot.com',
    iosBundleId: 'com.opal.royalkushdriverapp',
  );
}
