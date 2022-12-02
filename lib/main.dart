import 'package:consultation_system/auth/login_page.dart';
import 'package:consultation_system/auth/signup_page.dart';
import 'package:consultation_system/constant/routes.dart';
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
          projectId: "consultation-system-app",
          storageBucket: "consultation-system-app.appspot.com"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'STUDCON',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.loginpage,
      routes: {
        Routes.loginpage: (context) => const LoginPage(),
        Routes.homescreen: (context) => const HomeScreen(),
        Routes.signuppage: (context) => SignupPage(),
      },
    );
  }
}
