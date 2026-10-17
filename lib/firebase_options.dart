// Firebase project: percalculator (console.firebase.google.com/project/percalculator)
// Regenerate with `flutterfire configure --project=percalculator` if apps change.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD4q8HRKR_Dgxr1a3obCO1X1mhyAnOKZvc',
    appId: '1:552365310755:android:4165313badd2a9888ac296',
    messagingSenderId: '552365310755',
    projectId: 'percalculator',
    storageBucket: 'percalculator.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBbINimdVuE9WwfNsz44VfYJAuyCXeUH1w',
    appId: '1:552365310755:ios:868a8595c11c8d9a8ac296',
    messagingSenderId: '552365310755',
    projectId: 'percalculator',
    storageBucket: 'percalculator.firebasestorage.app',
    iosBundleId: 'com.techoveride.percentagecalculator',
  );
}
