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
    apiKey: 'AIzaSyC23jUnTTDoCx2Wo7slZdqKOS3FFe9QGek',
    appId: '1:254528540069:web:153da799fdb169c2d52c4c',
    messagingSenderId: '254528540069',
    projectId: 'assign-e1f7c',
    authDomain: 'assign-e1f7c.firebaseapp.com',
    storageBucket: 'assign-e1f7c.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDmOT-xGX8o_8OyCp44otZbTrnn1E9Zgfs',
    appId: '1:254528540069:android:309dac922a7ddd1dd52c4c',
    messagingSenderId: '254528540069',
    projectId: 'assign-e1f7c',
    storageBucket: 'assign-e1f7c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC-bDuJpfKauqxvjnkPG4oitMvX9RbYYOk',
    appId: '1:254528540069:ios:bf47d1b0709717afd52c4c',
    messagingSenderId: '254528540069',
    projectId: 'assign-e1f7c',
    storageBucket: 'assign-e1f7c.appspot.com',
    iosBundleId: 'com.example.assignment',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC-bDuJpfKauqxvjnkPG4oitMvX9RbYYOk',
    appId: '1:254528540069:ios:bf47d1b0709717afd52c4c',
    messagingSenderId: '254528540069',
    projectId: 'assign-e1f7c',
    storageBucket: 'assign-e1f7c.appspot.com',
    iosBundleId: 'com.example.assignment',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC23jUnTTDoCx2Wo7slZdqKOS3FFe9QGek',
    appId: '1:254528540069:web:7e7efd9ea9a4834fd52c4c',
    messagingSenderId: '254528540069',
    projectId: 'assign-e1f7c',
    authDomain: 'assign-e1f7c.firebaseapp.com',
    storageBucket: 'assign-e1f7c.appspot.com',
  );
}
