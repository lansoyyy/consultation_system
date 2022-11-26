import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation_system/constant/uid.dart';
import 'package:consultation_system/repositories/user_repository_interface.dart';

class UserRepository implements UsertRepositoryInterface {
  @override
  Future addUser(
    String firstName,
    String middleName,
    String surName,
    String contactNumber,
    String email,
    String password,
    String uid,
  ) async {
    final docUser =
        FirebaseFirestore.instance.collection('CONSULTATION-USERS').doc(uid);

    final json = {
      'first_name': firstName,
      'middle_name': middleName,
      'sur_name': surName,
      'contact_number': contactNumber,
      'email': email,
      'password': password,
      'id': FirebaseAuthToken().uid,
    };

    await docUser.set(json);
    // await eUser.set(json, {

    // });
  }
}
