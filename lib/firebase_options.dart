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
    apiKey: 'AIzaSyDfK8MwfKJUyblKj6hehPy93JWMmYXNxNw',
    appId: '1:705335153334:web:29d3d6688891bde4c8cc17',
    messagingSenderId: '705335153334',
    projectId: 'tranquil-gasket-442909-i2',
    authDomain: 'tranquil-gasket-442909-i2.firebaseapp.com',
    storageBucket: 'tranquil-gasket-442909-i2.firebasestorage.app',
    measurementId: 'G-JJZTQVYY4D',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAsLritoG1imuu7cjjDd4UymPRV_gVCzcc',
    appId: '1:705335153334:android:d36a2ba80827d40ec8cc17',
    messagingSenderId: '705335153334',
    projectId: 'tranquil-gasket-442909-i2',
    storageBucket: 'tranquil-gasket-442909-i2.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBueHjOUNKnSxdL2fsS94FXWnkw6ETtZhk',
    appId: '1:705335153334:ios:80525cc10efc4fd3c8cc17',
    messagingSenderId: '705335153334',
    projectId: 'tranquil-gasket-442909-i2',
    storageBucket: 'tranquil-gasket-442909-i2.firebasestorage.app',
    androidClientId: '705335153334-mnop4njgqkaf2j6ltbbgf1d1u1todl5p.apps.googleusercontent.com',
    iosClientId: '705335153334-87641m1946fei8q0icjh9dj51roth6u8.apps.googleusercontent.com',
    iosBundleId: 'com.example.foodPlan',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBueHjOUNKnSxdL2fsS94FXWnkw6ETtZhk',
    appId: '1:705335153334:ios:80525cc10efc4fd3c8cc17',
    messagingSenderId: '705335153334',
    projectId: 'tranquil-gasket-442909-i2',
    storageBucket: 'tranquil-gasket-442909-i2.firebasestorage.app',
    androidClientId: '705335153334-mnop4njgqkaf2j6ltbbgf1d1u1todl5p.apps.googleusercontent.com',
    iosClientId: '705335153334-87641m1946fei8q0icjh9dj51roth6u8.apps.googleusercontent.com',
    iosBundleId: 'com.example.foodPlan',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDfK8MwfKJUyblKj6hehPy93JWMmYXNxNw',
    appId: '1:705335153334:web:0d09911cfc006ac8c8cc17',
    messagingSenderId: '705335153334',
    projectId: 'tranquil-gasket-442909-i2',
    authDomain: 'tranquil-gasket-442909-i2.firebaseapp.com',
    storageBucket: 'tranquil-gasket-442909-i2.firebasestorage.app',
    measurementId: 'G-V9W73BHD3K',
  );
}