import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation_system/constant/colors.dart';
import 'package:consultation_system/widgets/drop_down_button.dart';
import 'package:consultation_system/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportTab extends StatefulWidget {
  @override
  State<ReportTab> createState() => _ReportTabState();
}

class _ReportTabState extends State<ReportTab> {
  int _dropdownValue = 0;

  late String year = 'First Year';

  int _dropdownValue1 = 0;

  late String course = 'IT';

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
                        label: 'Export in PDF',
                        fontSize: 15,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
                      child: DropdownButton(
                        underline: Container(color: Colors.transparent),
                        iconEnabledColor: Colors.black,
                        isExpanded: true,
                        value: _dropdownValue,
                        items: [
                          DropdownMenuItem(
                            onTap: () {
                              year = 'First Year';
                            },
                            value: 0,
                            child: DropDownItem(label: '1st Year'),
                          ),
                          DropdownMenuItem(
                            onTap: () {
                              year = 'Second Year';
                            },
                            value: 1,
                            child: DropDownItem(label: '2nd Year'),
                          ),
                          DropdownMenuItem(
                            onTap: () {
                              year = 'Third Year';
                            },
                            value: 2,
                            child: DropDownItem(label: '3rd Year'),
                          ),
                          DropdownMenuItem(
                            onTap: () {
                              year = 'Fourth Year';
                            },
                            value: 3,
                            child: DropDownItem(label: '4th Year'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _dropdownValue = int.parse(value.toString());
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
                      child: DropdownButton(
                        underline: Container(color: Colors.transparent),
                        iconEnabledColor: Colors.black,
                        isExpanded: true,
                        value: _dropdownValue1,
                        items: [
                          DropdownMenuItem(
                            onTap: () {
                              course = "IT";
                            },
                            value: 0,
                            child: Center(
                                child: Row(children: const [
                              Text("IT",
                                  style: TextStyle(
                                    fontFamily: 'QRegular',
                                    color: Colors.black,
                                  ))
                            ])),
                          ),
                          DropdownMenuItem(
                            onTap: () {
                              course = "Nursing";
                            },
                            value: 1,
                            child: Center(
                                child: Row(children: const [
                              Text("Nursing",
                                  style: TextStyle(
                                    fontFamily: 'QRegular',
                                    color: Colors.black,
                                  ))
                            ])),
                          ),
                          DropdownMenuItem(
                            onTap: () {
                              course = "Educ";
                            },
                            value: 2,
                            child: Center(
                                child: Row(children: const [
                              Text("Educ",
                                  style: TextStyle(
                                    fontFamily: 'QRegular',
                                    color: Colors.black,
                                  ))
                            ])),
                          ),
                          DropdownMenuItem(
                            onTap: () {
                              course = "Public Ad";
                            },
                            value: 3,
                            child: Center(
                                child: Row(children: const [
                              Text("Public Ad",
                                  style: TextStyle(
                                    fontFamily: 'QRegular',
                                    color: Colors.black,
                                  ))
                            ])),
                          ),
                          DropdownMenuItem(
                            onTap: () {
                              course = "Hotel Management";
                            },
                            value: 4,
                            child: Center(
                                child: Row(children: const [
                              Text("Hotel Management",
                                  style: TextStyle(
                                    fontFamily: 'QRegular',
                                    color: Colors.black,
                                  ))
                            ])),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _dropdownValue1 = int.parse(value.toString());
                          });
                        },
                      ),
                    ),
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
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Concerns')
                    .where('yearLevel', isEqualTo: year)
                    .where('course', isEqualTo: course)
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

                  return Expanded(
                    child: SizedBox(
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: ((context, index) {
                            DateTime created =
                                data.docs[index]['dateTime'].toDate();

                            String formattedTime =
                                DateFormat.yMMMd().add_jm().format(created);
                            return Padding(
                              padding: const EdgeInsets.only(right: 25),
                              child: Center(
                                child: Container(
                                  height: 500,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: primary, width: 2),
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white),
                                  child: SingleChildScrollView(
                                    child: DataTable(
                                      // datatable widget
                                      columns: [
                                        // column to set the name
                                        DataColumn(
                                            label: NormalText(
                                                label: 'No.',
                                                fontSize: 12,
                                                color: Colors.black)),
                                        DataColumn(
                                            label: NormalText(
                                                label: 'Student Name',
                                                fontSize: 12,
                                                color: Colors.black)),
                                        DataColumn(
                                            label: NormalText(
                                                label: 'Time of\nConsultation',
                                                fontSize: 12,
                                                color: Colors.black)),
                                        DataColumn(
                                            label: NormalText(
                                                label: 'Date of\nConsultation',
                                                fontSize: 12,
                                                color: Colors.black)),
                                        DataColumn(
                                            label: NormalText(
                                                label: 'Course',
                                                fontSize: 12,
                                                color: Colors.black)),
                                        DataColumn(
                                            label: NormalText(
                                                label: 'Year Level',
                                                fontSize: 12,
                                                color: Colors.black)),
                                        DataColumn(
                                            label: NormalText(
                                                label:
                                                    'Purpose of\nConsultation',
                                                fontSize: 12,
                                                color: Colors.black)),
                                        DataColumn(
                                            label: NormalText(
                                                label: 'Ticket Status',
                                                fontSize: 12,
                                                color: Colors.black)),
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
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                            ),
                                            DataCell(
                                              NormalText(
                                                  label: data.docs[i]['name'],
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                            ),
                                            DataCell(
                                              NormalText(
                                                  label: data.docs[i]['time'],
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                            ),
                                            DataCell(
                                              NormalText(
                                                  label:
                                                      formattedTime.toString(),
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                            ),
                                            DataCell(
                                              NormalText(
                                                  label: data.docs[i]['course'],
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                            ),
                                            DataCell(
                                              NormalText(
                                                  label: data.docs[i]
                                                      ['yearLevel'],
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                            ),
                                            DataCell(
                                              NormalText(
                                                  label: data.docs[i]
                                                      ['concern'],
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                            ),
                                            DataCell(
                                              NormalText(
                                                  label: data.docs[i]['type'],
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                            ),
                                          ]),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          })),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
