import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation_system/constant/colors.dart';
import 'package:consultation_system/widgets/appabr_widget.dart';
import 'package:consultation_system/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class FeedbackTab extends StatelessWidget {
  PageController page = PageController();

  FeedbackTab({required this.page});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarWidget(page),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 20, bottom: 20),
                child: NormalText(
                    label: 'Feedbacks', fontSize: 32, color: primary),
              ),
              SingleChildScrollView(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Feedbacks')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                        return const Center(child: Text('Error'));
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        print('waiting');
                        return const Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Center(
                              child: CircularProgressIndicator(
                            color: Colors.black,
                          )),
                        );
                      }

                      final data = snapshot.requireData;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Container(
                                height: 500,
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: primary, width: 2),
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white),
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 0),
                                    child: DataTable(
                                      // datatable widget
                                      columns: [
                                        // column to set the name
                                        DataColumn(
                                            label: NormalText(
                                                label: 'No.',
                                                fontSize: 16,
                                                color: primary)),
                                        DataColumn(
                                            label: NormalText(
                                                label: 'Student\nProfile',
                                                fontSize: 16,
                                                color: primary)),
                                        DataColumn(
                                            label: NormalText(
                                                label: 'Student\nName',
                                                fontSize: 16,
                                                color: primary)),
                                        DataColumn(
                                            label: NormalText(
                                                label: 'Email',
                                                fontSize: 16,
                                                color: primary)),
                                        DataColumn(
                                            label: NormalText(
                                                label: 'Course',
                                                fontSize: 16,
                                                color: primary)),
                                        DataColumn(
                                            label: NormalText(
                                                label: 'Year\nLevel',
                                                fontSize: 16,
                                                color: primary)),
                                        DataColumn(
                                            label: NormalText(
                                                label: 'Feedback',
                                                fontSize: 16,
                                                color: primary)),
                                      ],

                                      rows: [
                                        // row to set the values
                                        for (int i = 0;
                                            i < snapshot.data!.size;
                                            i++)
                                          DataRow(cells: [
                                            DataCell(
                                              NormalText(
                                                  label: i.toString(),
                                                  fontSize: 14,
                                                  color: Colors.black),
                                            ),
                                            DataCell(Container(
                                              color: Colors.transparent,
                                              height: 40,
                                              width: 50,
                                              child: Image.network(
                                                data.docs[i]['profilePicture'],
                                                fit: BoxFit.cover,
                                              ),
                                            )),
                                            DataCell(
                                              NormalText(
                                                  label: data.docs[i]['name'],
                                                  fontSize: 14,
                                                  color: Colors.black),
                                            ),
                                            DataCell(
                                              NormalText(
                                                  label: data.docs[i]['email'],
                                                  fontSize: 14,
                                                  color: Colors.black),
                                            ),
                                            DataCell(
                                              NormalText(
                                                  label: data.docs[i]['course'],
                                                  fontSize: 14,
                                                  color: Colors.black),
                                            ),
                                            DataCell(
                                              NormalText(
                                                  label: data.docs[i]
                                                      ['yearLevel'],
                                                  fontSize: 14,
                                                  color: Colors.black),
                                            ),
                                            DataCell(
                                              NormalText(
                                                  label: data.docs[i]
                                                      ['feedback'],
                                                  fontSize: 14,
                                                  color: Colors.black),
                                            ),
                                          ]),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                        ],
                      );
                    }),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ));
  }
}
