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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCQTcPHQ9KB7XhJlJ18p8Voo15l04rJrNk',
    appId: '1:1004979445134:android:c2c2c6564732d4e6a7d8df',
    messagingSenderId: '1004979445134',
    projectId: 'quicknoms-1b088',
    databaseURL: 'https://quicknoms-1b088-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'quicknoms-1b088.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCZH1oMPsjaZh7HCIa6J9hiqCczWJJ2hvU',
    appId: '1:1004979445134:ios:2548b5ecb3bc1798a7d8df',
    messagingSenderId: '1004979445134',
    projectId: 'quicknoms-1b088',
    databaseURL: 'https://quicknoms-1b088-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'quicknoms-1b088.appspot.com',
    iosBundleId: 'com.example.quicknoms',
  );
}
