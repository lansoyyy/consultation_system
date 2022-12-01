import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation_system/constant/colors.dart';
import 'package:consultation_system/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                NormalText(label: 'Reports', fontSize: 24, color: primary),
                const Expanded(child: SizedBox()),
                Container(
                  decoration: BoxDecoration(
                      color: blueAccent,
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: NormalText(
                        label: 'Export', fontSize: 15, color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: blueAccent,
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: NormalText(
                        label: 'By year lvl',
                        fontSize: 15,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Container(
                color: greenAccent,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NormalText(
                              label: 'No.', fontSize: 12, color: Colors.white),
                        ],
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NormalText(
                              label: 'Student Name',
                              fontSize: 12,
                              color: Colors.white),
                        ],
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NormalText(
                              label: 'Time of\nConsultation',
                              fontSize: 12,
                              color: Colors.white),
                        ],
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NormalText(
                              label: 'Date of\nConsultation',
                              fontSize: 12,
                              color: Colors.white),
                        ],
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NormalText(
                              label: 'Course',
                              fontSize: 12,
                              color: Colors.white),
                        ],
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NormalText(
                              label: 'Year Level',
                              fontSize: 12,
                              color: Colors.white),
                        ],
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NormalText(
                              label: 'Purpose of\nConsultation',
                              fontSize: 12,
                              color: Colors.white),
                        ],
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NormalText(
                              label: 'Ticket Status',
                              fontSize: 12,
                              color: Colors.white),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot?>(
                stream: FirebaseFirestore.instance
                    .collection('Concerns')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: NormalText(
                            label: 'No Saved Data',
                            color: Colors.white,
                            fontSize: 20),
                      );
                    }

                    return Expanded(
                      child: SizedBox(
                        child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: ((context, index) {
                              Map data =
                                  snapshot.data!.docs[index].data() as Map;
                              DateTime created = data['dateTime'].toDate();

                              String formattedTime =
                                  DateFormat.yMMMd().add_jm().format(created);
                              return Padding(
                                padding: const EdgeInsets.only(right: 25),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey[200]!, width: 1)),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 2, 20, 2),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            NormalText(
                                                label: index.toString(),
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            NormalText(
                                                label: data['name'],
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            NormalText(
                                                label: data['time'],
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            NormalText(
                                                label: formattedTime,
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            NormalText(
                                                label: data['course'],
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            NormalText(
                                                label: data['yearLevel'],
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            NormalText(
                                                label: data['concern'],
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            NormalText(
                                                label: 'SOLVED',
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            })),
                      ),
                    );
                  } else {
                    return Center(
                      child: NormalText(
                          label: 'Loading...',
                          color: Colors.white,
                          fontSize: 20),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
