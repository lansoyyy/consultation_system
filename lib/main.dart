import 'package:consultation_system/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAvIORn9r3ylWPdX8auRDSk-fTmPcIyGOo",
          appId: "1:835085732676:web:e3b5d61b6b831d749ce511",
          messagingSenderId: "835085732676",
          projectId: "consultation-system-app"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
