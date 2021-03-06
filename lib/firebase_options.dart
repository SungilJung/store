// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
  DefaultFirebaseOptions._();

  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static final FirebaseOptions android = FirebaseOptions(
    apiKey: dotenv.env['android_apiKey']!,
    appId: dotenv.env['android_appId']!,
    messagingSenderId: dotenv.env['android_messagingSenderId']!,
    projectId: dotenv.env['android_projectId']!,
    storageBucket: dotenv.env['android_storageBucket']!,
  );

  static final FirebaseOptions ios = FirebaseOptions(
    apiKey: dotenv.env['ios_apiKey']!,
    appId: dotenv.env['ios_appId']!,
    messagingSenderId: dotenv.env['ios_messagingSenderId']!,
    projectId: dotenv.env['ios_projectId']!,
    storageBucket: dotenv.env['ios_storageBucket']!,
    iosClientId: dotenv.env['ios_iosClientId']!,
    iosBundleId: 'com.nannepyun.store',
  );
}
