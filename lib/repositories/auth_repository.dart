import 'package:consultation_system/repositories/auth_repository_interface.dart';
import 'package:consultation_system/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository implements AuthRepositoryInterface {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<List<void>?> loginOfuser(String email, password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);

    return null;
  }

  @override
  userSignUp(
      String firstName,
      String middleName,
      String surName,
      String contactNumber,
      String email,
      String password,
      String uid,
      String course) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    final user = FirebaseAuth.instance.currentUser!;

    UserRepository().addUser(firstName, middleName, surName, contactNumber,
        email, password, user.uid, course);
  }
}
