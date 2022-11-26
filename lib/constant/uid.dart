import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthToken {
  final uid = FirebaseAuth.instance.currentUser!.uid;
}
