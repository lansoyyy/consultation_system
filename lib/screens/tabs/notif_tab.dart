import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation_system/constant/colors.dart';
import 'package:consultation_system/widgets/drop_down_button.dart';
import 'package:consultation_system/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/appabr_widget.dart';

class NotfiTab extends StatefulWidget {
  PageController page = PageController();

  NotfiTab({required this.page});

  @override
  State<NotfiTab> createState() => _NotfiTabState();
}

class _NotfiTabState extends State<NotfiTab> {
  int value1 = 0;
  late int am = 8;

  int value2 = 0;
  late int pm = 1;

  int value3 = 0;
  late String status = 'Active';

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
        .collection('CONSULTATION-USERS')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    return Scaffold(
      appBar: appbarWidget(widget.page),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: StreamBuilder<DocumentSnapshot>(
            stream: userData,
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: Text('Loading'));
              } else if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              dynamic data = snapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NormalText(
                      label: 'Notifications', fontSize: 28, color: primary),
                  const SizedBox(
                    height: 30,
                  ),
                  BoldText(
                      label: 'Status: ${data['status']}',
                      fontSize: 14,
                      color: primary),
                  BoldText(
                      label:
                          'Your scheduled notification: ${data['from']}:00am - ${data['to']}:00pm',
                      fontSize: 14,
                      color: primary),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const VerticalDivider(
                        color: Colors.grey,
                        width: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NormalText(
                                label: 'Schedule a Notification',
                                fontSize: 18,
                                color: primary),
                            NormalText(
                                label:
                                    "You'all only receive notification in the hours you choose. Outside of those times, notifications will be paused.",
                                fontSize: 12,
                                color: primary),
                            const SizedBox(
                              height: 30,
                            ),
                            NormalText(
                                label: "Allow notification:",
                                fontSize: 12,
                                color: Colors.grey),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Container(
                                    width: 150,
                                    decoration: BoxDecoration(
                                      color: greyColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 2, 20, 2),
                                      child: DropdownButton(
                                        underline: Container(
                                            color: Colors.transparent),
                                        iconEnabledColor: Colors.black,
                                        isExpanded: true,
                                        value: value1,
                                        items: [
                                          DropdownMenuItem(
                                            onTap: () {
                                              am = 8;
                                              FirebaseFirestore.instance
                                                  .collection(
                                                      'CONSULTATION-USERS')
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .update({
                                                'from': am,
                                              });
                                            },
                                            value: 0,
                                            child:
                                                DropDownItem(label: '8:00AM'),
                                          ),
                                          DropdownMenuItem(
                                            onTap: () {
                                              am = 9;
                                              FirebaseFirestore.instance
                                                  .collection(
                                                      'CONSULTATION-USERS')
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .update({
                                                'from': am,
                                              });
                                            },
                                            value: 1,
                                            child:
                                                DropDownItem(label: '9:00AM'),
                                          ),
                                          DropdownMenuItem(
                                            onTap: () {
                                              am = 10;
                                              FirebaseFirestore.instance
                                                  .collection(
                                                      'CONSULTATION-USERS')
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .update({
                                                'from': am,
                                              });
                                            },
                                            value: 2,
                                            child:
                                                DropDownItem(label: '10:00AM'),
                                          ),
                                          DropdownMenuItem(
                                            onTap: () {
                                              am = 11;
                                              FirebaseFirestore.instance
                                                  .collection(
                                                      'CONSULTATION-USERS')
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .update({
                                                'from': am,
                                              });
                                            },
                                            value: 3,
                                            child:
                                                DropDownItem(label: '11:00AM'),
                                          ),
                                          DropdownMenuItem(
                                            onTap: () {
                                              am = 12;
                                              FirebaseFirestore.instance
                                                  .collection(
                                                      'CONSULTATION-USERS')
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .update({
                                                'from': am,
                                              });
                                            },
                                            value: 4,
                                            child:
                                                DropDownItem(label: '12:00AM'),
                                          ),
                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            value1 =
                                                int.parse(value.toString());
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Container(
                                    width: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 2, 20, 2),
                                      child: Center(
                                        child: NormalText(
                                            label: 'TO',
                                            fontSize: 14,
                                            color: primary),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Container(
                                    width: 150,
                                    decoration: BoxDecoration(
                                      color: greyColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 2, 20, 2),
                                      child: DropdownButton(
                                        underline: Container(
                                            color: Colors.transparent),
                                        iconEnabledColor: Colors.black,
                                        isExpanded: true,
                                        value: value2,
                                        items: [
                                          DropdownMenuItem(
                                            onTap: () {
                                              pm = 1;
                                              FirebaseFirestore.instance
                                                  .collection(
                                                      'CONSULTATION-USERS')
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .update({
                                                'to': pm,
                                              });
                                            },
                                            value: 0,
                                            child:
                                                DropDownItem(label: '1:00PM'),
                                          ),
                                          DropdownMenuItem(
                                            onTap: () {
                                              pm = 2;
                                              FirebaseFirestore.instance
                                                  .collection(
                                                      'CONSULTATION-USERS')
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .update({
                                                'to': pm,
                                              });
                                            },
                                            value: 1,
                                            child:
                                                DropDownItem(label: '2:00PM'),
                                          ),
                                          DropdownMenuItem(
                                            onTap: () {
                                              pm = 3;
                                              FirebaseFirestore.instance
                                                  .collection(
                                                      'CONSULTATION-USERS')
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .update({
                                                'to': pm,
                                              });
                                            },
                                            value: 2,
                                            child:
                                                DropDownItem(label: '3:00PM'),
                                          ),
                                          DropdownMenuItem(
                                            onTap: () {
                                              pm = 4;
                                              FirebaseFirestore.instance
                                                  .collection(
                                                      'CONSULTATION-USERS')
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .update({
                                                'to': pm,
                                              });
                                            },
                                            value: 3,
                                            child:
                                                DropDownItem(label: '4:00PM'),
                                          ),
                                          DropdownMenuItem(
                                            onTap: () {
                                              pm = 5;
                                              FirebaseFirestore.instance
                                                  .collection(
                                                      'CONSULTATION-USERS')
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .update({
                                                'to': pm,
                                              });
                                            },
                                            value: 4,
                                            child:
                                                DropDownItem(label: '5:00PM'),
                                          ),
                                          DropdownMenuItem(
                                            onTap: () {
                                              pm = 6;
                                              FirebaseFirestore.instance
                                                  .collection(
                                                      'CONSULTATION-USERS')
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .update({
                                                'to': pm,
                                              });
                                            },
                                            value: 5,
                                            child:
                                                DropDownItem(label: '6:00PM'),
                                          ),
                                          DropdownMenuItem(
                                            onTap: () {
                                              pm = 7;
                                              FirebaseFirestore.instance
                                                  .collection(
                                                      'CONSULTATION-USERS')
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .update({
                                                'to': pm,
                                              });
                                            },
                                            value: 6,
                                            child:
                                                DropDownItem(label: '7:00PM'),
                                          ),
                                          DropdownMenuItem(
                                            onTap: () {
                                              pm = 8;
                                              FirebaseFirestore.instance
                                                  .collection(
                                                      'CONSULTATION-USERS')
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .update({
                                                'to': pm,
                                              });
                                            },
                                            value: 7,
                                            child:
                                                DropDownItem(label: '8:00PM'),
                                          ),
                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            value2 =
                                                int.parse(value.toString());
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            NormalText(
                                label: "Set your activity status",
                                fontSize: 12,
                                color: Colors.grey),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 150,
                              decoration: BoxDecoration(
                                color: greyColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 2, 20, 2),
                                child: DropdownButton(
                                  underline:
                                      Container(color: Colors.transparent),
                                  iconEnabledColor: Colors.black,
                                  isExpanded: true,
                                  value: value3,
                                  items: [
                                    DropdownMenuItem(
                                      onTap: () {
                                        status = 'Active';
                                        FirebaseFirestore.instance
                                            .collection('CONSULTATION-USERS')
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .update({
                                          'status': status,
                                        });
                                      },
                                      value: 0,
                                      child: DropDownItem(label: 'Active'),
                                    ),
                                    DropdownMenuItem(
                                      onTap: () {
                                        status = 'Inactive';
                                        FirebaseFirestore.instance
                                            .collection('CONSULTATION-USERS')
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                            .update({
                                          'status': status,
                                        });
                                      },
                                      value: 1,
                                      child: DropDownItem(label: 'Inactive'),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      value3 = int.parse(value.toString());
                                    });
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            NormalText(
                                label:
                                    "You can make your notification status active/inactive",
                                fontSize: 12,
                                color: Colors.grey),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
      ),
    );
  }
}
