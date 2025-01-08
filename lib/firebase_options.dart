
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
    apiKey: 'AIzaSyDj17nDGj1aMzaq5Jd2XRsuV1k_urAjQlE',
    appId: '1:491360243985:web:5811f2891a0ca33427fcb0',
    messagingSenderId: '491360243985',
    projectId: 'bus-buddy-7cedb',
    authDomain: 'bus-buddy-7cedb.firebaseapp.com',
    databaseURL: 'https://bus-buddy-7cedb-default-rtdb.firebaseio.com',
    storageBucket: 'bus-buddy-7cedb.firebasestorage.app',
    measurementId: 'G-KNLEEBC217',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCaRLXXh_26f4VDDh_PEhuLai5lfespZTs',
    appId: '1:491360243985:android:2227908e3ad1651b27fcb0',
    messagingSenderId: '491360243985',
    projectId: 'bus-buddy-7cedb',
    databaseURL: 'https://bus-buddy-7cedb-default-rtdb.firebaseio.com',
    storageBucket: 'bus-buddy-7cedb.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCk4fz6B5tdmvkgN0978FP-bCLf-qtu6BA',
    appId: '1:491360243985:ios:3f86bcd430cd9f9e27fcb0',
    messagingSenderId: '491360243985',
    projectId: 'bus-buddy-7cedb',
    databaseURL: 'https://bus-buddy-7cedb-default-rtdb.firebaseio.com',
    storageBucket: 'bus-buddy-7cedb.firebasestorage.app',
    iosBundleId: 'com.example.busbuddy',
  );
}
