import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation_system/constant/colors.dart';
import 'package:consultation_system/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FeedbackTab extends StatelessWidget {
  const FeedbackTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30, left: 20, bottom: 20),
          child: BoldText(label: 'Feedbacks', fontSize: 32, color: primary),
        ),
        StreamBuilder<QuerySnapshot?>(
            stream:
                FirebaseFirestore.instance.collection('Feedbacks').snapshots(),
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
                          Map data = snapshot.data!.docs[index].data() as Map;
                          DateTime created = data['dateTime'].toDate();
                          String formattedTime =
                              DateFormat.yMMMd().add_jm().format(created);
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                            child: ExpansionTile(
                              backgroundColor: Colors.white,
                              title: NormalText(
                                  label: data['name'],
                                  fontSize: 24,
                                  color: primary),
                              leading: const CircleAvatar(
                                minRadius: 30,
                                maxRadius: 30,
                                backgroundImage:
                                    AssetImage('assets/images/profile.png'),
                              ),
                              children: [
                                NormalText(
                                    label: 'Feedback',
                                    fontSize: 18,
                                    color: Colors.black),
                                NormalText(
                                    label: data['feedback'],
                                    fontSize: 14,
                                    color: Colors.grey),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          );
                        })),
                  ),
                );
              } else {
                return Center(
                  child: NormalText(
                      label: 'Loading...', color: Colors.white, fontSize: 20),
                );
              }
            }),
        const SizedBox(
          height: 50,
        ),
      ],
    ));
  }
}
