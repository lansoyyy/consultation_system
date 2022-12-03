import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:intl/intl.dart';

Future addMessage(
  String myYear,
  String instructorProfile,
  String instructorName,
  String instructorEmail,
  String course,
  String message,
  String name,
  String email,
  String receiverId,
  String concern,
  int to,
  int from,
) async {
  final docUser = FirebaseFirestore.instance
      .collection(receiverId)
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('Messages')
      .doc();

  final docUser1 = FirebaseFirestore.instance
      .collection(receiverId)
      .doc(FirebaseAuth.instance.currentUser!.uid);

  String tdata = DateFormat("hh:mm a").format(DateTime.now());

  final json = {
    'yearLevel': myYear,
    'profilePicture': instructorProfile,
    'course': course,
    'message': message,
    'name': name,
    'email': email,
    'time': tdata,
    'status': 'Unread',
    'myProfile': 'Unread',
    'id': docUser.id,
    'dateTime': DateTime.now(),
    'concern': concern
  };

  final json1 = {
    'yearLevel': myYear,
    'profilePicture': instructorProfile,
    'instructorName': instructorName,
    'instructorEmail': instructorEmail,
    'dateTime': DateTime.now(),
    'time': tdata,
    'status': 'Unread',
    'concern': concern,
    'to': to,
    'from': from
  };

  await docUser1.set(json1);

  await docUser.set(json);
}

Future addMessage2(
  String myYear,
  String myProfile,
  String instructorName,
  String instructorEmail,
  String course,
  String message,
  String name,
  String email,
  String receiverId,
  String concern,
) async {
  final docUser = FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser!.uid)
      .doc(receiverId)
      .collection('Messages')
      .doc();

  String tdata = DateFormat("hh:mm a").format(DateTime.now());

  final json = {
    'yearLevel': myYear,
    'profilePicture': myProfile,
    'course': course,
    'message': message,
    'name': instructorName,
    'email': email,
    'time': tdata,
    'id': docUser.id,
    'status': 'Unread',
    'dateTime': DateTime.now(),
    'concern': concern
  };

  final json1 = {
    'yearLevel': myYear,
    'name': name,
    'profilePicture': myProfile,
    'email': email,
    'dateTime': DateTime.now(),
    'time': tdata,
    'status': 'Unread',
    'concern': concern
  };

  final docUser1 = FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser!.uid)
      .doc(receiverId);

  await docUser1.set(json1);

  await docUser.set(json);
}
