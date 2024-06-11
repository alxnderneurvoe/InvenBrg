import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDfVQilvDSTMkIn1219fcEwz3FLJWbQYGQ",
          authDomain: "apk-inventori.firebaseapp.com",
          projectId: "apk-inventori",
          storageBucket: "apk-inventori.appspot.com",
          messagingSenderId: "260841033668",
          appId: "1:260841033668:web:31105c34616cd7d5369e91"),
    );
  } else {
    await Firebase.initializeApp();
  }
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventori Barang',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomePage(),
      },
      theme: ThemeData(),
    );
  }
}
81396758726

