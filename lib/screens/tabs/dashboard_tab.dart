import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation_system/constant/colors.dart';
import 'package:consultation_system/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashboardTab extends StatefulWidget {
  const DashboardTab({super.key});

  @override
  State<DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab> {
  int total1 = 0;
  getData1() async {
    // Use provider
    var collection = FirebaseFirestore.instance
        .collection('Concerns')
        .where('concern', isEqualTo: 'Grades');

    var querySnapshot = await collection.get();
    if (mounted) {
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          total1 = querySnapshot.size;
        }
      });
    }
  }

  int total2 = 0;
  getData2() async {
    // Use provider
    var collection = FirebaseFirestore.instance
        .collection('Concerns')
        .where('concern', isEqualTo: 'Requirements');

    var querySnapshot = await collection.get();
    if (mounted) {
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          total2 = querySnapshot.size;
        }
      });
    }
  }

  int total3 = 0;
  getData3() async {
    // Use provider
    var collection = FirebaseFirestore.instance
        .collection('Concerns')
        .where('concern', isEqualTo: 'Attendance');

    var querySnapshot = await collection.get();
    if (mounted) {
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          total3 = querySnapshot.size;
        }
      });
    }
  }

  int total4 = 0;
  getData4() async {
    // Use provider
    var collection = FirebaseFirestore.instance
        .collection('Concerns')
        .where('concern', isEqualTo: 'Others');

    var querySnapshot = await collection.get();
    if (mounted) {
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          total4 = querySnapshot.size;
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getData1();
    getData2();
    getData3();
    getData4();
  }

  @override
  Widget build(BuildContext context) {
    String date = DateFormat("MMMM, EEEE, yyyy").format(DateTime.now());

    return Container(
      padding: const EdgeInsets.only(left: 20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          NormalText(label: date, fontSize: 24, color: primary),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 20, top: 10),
                height: 100,
                width: 250,
                color: greyAccent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NormalText(
                        label: 'MESSAGES TODAY',
                        fontSize: 12,
                        color: Colors.grey),
                    const SizedBox(
                      height: 20,
                    ),
                    BoldText(label: '23', fontSize: 32, color: primary),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, top: 10),
                height: 100,
                width: 250,
                color: greyAccent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NormalText(
                        label: 'UNREAD MESSAGES TODAY',
                        fontSize: 12,
                        color: Colors.grey),
                    const SizedBox(
                      height: 20,
                    ),
                    BoldText(label: '23', fontSize: 32, color: primary),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, top: 10),
                height: 100,
                width: 250,
                color: greyAccent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NormalText(
                        label: 'REPLIED MESSAGES TODAY',
                        fontSize: 12,
                        color: Colors.grey),
                    const SizedBox(
                      height: 20,
                    ),
                    BoldText(label: '23', fontSize: 32, color: primary),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Container(
                padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                height: 400,
                width: 600,
                color: greyAccent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NormalText(
                        label: 'TICKETS FOR TODAY',
                        fontSize: 12,
                        color: Colors.grey),
                    const SizedBox(
                      height: 10,
                    ),
                    BoldText(
                        label: 'CONCERNS', fontSize: 12, color: Colors.grey),
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      leading: NormalText(
                          label: 'Grades', fontSize: 12, color: primary),
                      trailing: BoldText(
                          label: total1.toString(),
                          fontSize: 12,
                          color: primary),
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    ListTile(
                      leading: NormalText(
                          label: 'Requirements/Projects',
                          fontSize: 12,
                          color: primary),
                      trailing: BoldText(
                          label: total2.toString(),
                          fontSize: 12,
                          color: primary),
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    ListTile(
                      leading: NormalText(
                          label: 'Attendance', fontSize: 12, color: primary),
                      trailing: BoldText(
                          label: total3.toString(),
                          fontSize: 12,
                          color: primary),
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    ListTile(
                      leading: NormalText(
                          label: 'Other concerns',
                          fontSize: 12,
                          color: primary),
                      trailing: BoldText(
                          label: total4.toString(),
                          fontSize: 12,
                          color: primary),
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
