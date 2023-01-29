import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation_system/models/notification_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constant/colors.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({super.key});

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  late Stream<QuerySnapshot<Map<String, dynamic>>> notifData;

  void getData() {
    notifData = FirebaseFirestore.instance
        .collection('CONSULTATION-USERS')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('notifications')
        .snapshots();
  }

  List<NotificationData> _notifications = [];
  int index = 0;
  String? _selectedNotification;
  final FocusNode _focusNode = FocusNode();
  bool dropDownOpen = false;

  @override
  Widget build(BuildContext context) {
    // this listener is used to listen if user taps outside the dropdown
    _focusNode.addListener(() async {
      if (!_focusNode.hasFocus) {
        setState(() {
          dropDownOpen = true;
        });
        return;
      }
      if (dropDownOpen && _focusNode.hasFocus) {
        await FirebaseFirestore.instance
            .collection('CONSULTATION-USERS')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('notifications')
            .where("read", isEqualTo: false)
            .get()
            .then((snapshot) {
          for (DocumentSnapshot ds in snapshot.docs) {
            ds.reference.update({
              'read': true, //True or false
            });
          }
        });
      }
      setState(() {
        dropDownOpen = true;
      });
    });

    return Container(
      color: Colors.grey[100],
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: notifData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.data != null) {
                  _notifications = snapshot.data!.docs.map((e) {
                    Timestamp timestamp = e['date'];
                    return NotificationData(
                        message: e['message'],
                        date: timestamp.toDate(),
                        read: e['read']);
                  }).toList();

                  _notifications.sort((a, b) => b.date.compareTo(a.date));

                  return SizedBox(
                    width: 200,
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        splashColor: Colors.white24,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          focusNode: _focusNode,
                          onChanged: (value) {},
                          itemHeight: 100,
                          focusColor: Colors.white,
                          elevation: 0,
                          icon: const Icon(
                            size: 32,
                            Icons.notifications,
                            color: primary,
                          ),
                          items: _notifications.map((value) {
                            return DropdownMenuItem<String>(
                              value: value.message,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      value.message,
                                      style: TextStyle(
                                          fontWeight: !value.read
                                              ? FontWeight.bold
                                              : FontWeight.normal),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      DateFormat('EEEE, MMM d y, h:mm a')
                                          .format(value.date),
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: !value.read
                                              ? FontWeight.bold
                                              : FontWeight.normal),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                          value: _selectedNotification,
                          isExpanded: true,
                        ),
                      ),
                    ),
                  );
                }
                return Container();
              }),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: notifData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.data != null) {
                  final filteredList = snapshot.data!.docs
                      .where((notification) => notification["read"] == false)
                      .toList();
                  return filteredList.isEmpty
                      ? Container()
                      : Positioned(
                          top: 12,
                          right: 12,
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                            child: Center(
                              child: Text(
                                filteredList.length.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                }
                return Container();
              }),
        ],
      ),
    );
  }
}
