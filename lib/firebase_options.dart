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
    apiKey: 'AIzaSyAm1bnhwKajBDmtQi1tR9VykQxVe9a7dLI',
    appId: '1:335781661890:web:c26909e866222ee123bf5b',
    messagingSenderId: '335781661890',
    projectId: 'gym-app-dcad9',
    authDomain: 'gym-app-dcad9.firebaseapp.com',
    storageBucket: 'gym-app-dcad9.appspot.com',
    measurementId: 'G-7GQJC8W49Y',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAzXMa3Rj1ll1tIlXSOSIxWU9eAVj0m7uQ',
    appId: '1:335781661890:android:cf3d3b3d1dc8394a23bf5b',
    messagingSenderId: '335781661890',
    projectId: 'gym-app-dcad9',
    storageBucket: 'gym-app-dcad9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAUp8Dy5v_9aenhDNe-OoOwxDNADMRJkGA',
    appId: '1:335781661890:ios:8da0e3132f80d9ad23bf5b',
    messagingSenderId: '335781661890',
    projectId: 'gym-app-dcad9',
    storageBucket: 'gym-app-dcad9.appspot.com',
    iosBundleId: 'com.example.gymapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAUp8Dy5v_9aenhDNe-OoOwxDNADMRJkGA',
    appId: '1:335781661890:ios:8da0e3132f80d9ad23bf5b',
    messagingSenderId: '335781661890',
    projectId: 'gym-app-dcad9',
    storageBucket: 'gym-app-dcad9.appspot.com',
    iosBundleId: 'com.example.gymapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAm1bnhwKajBDmtQi1tR9VykQxVe9a7dLI',
    appId: '1:335781661890:web:55f955d328b5aa5c23bf5b',
    messagingSenderId: '335781661890',
    projectId: 'gym-app-dcad9',
    authDomain: 'gym-app-dcad9.firebaseapp.com',
    storageBucket: 'gym-app-dcad9.appspot.com',
    measurementId: 'G-PP0455D5J6',
  );
}
