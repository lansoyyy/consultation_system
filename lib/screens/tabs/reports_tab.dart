import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation_system/constant/colors.dart';
import 'package:consultation_system/widgets/drop_down_button.dart';
import 'package:consultation_system/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../widgets/appabr_widget.dart';

class ReportTab extends StatefulWidget {
  PageController page = PageController();

  ReportTab({required this.page});

  @override
  State<ReportTab> createState() => _ReportTabState();
}

class _ReportTabState extends State<ReportTab> {
  int _dropdownValue = 0;

  late String year = 'All';

  int _dropdownValue1 = 0;

  late String course = 'All';

  final doc = pw.Document();

  var name = [];
  var email = [];
  var courseStud = [];
  var yearLevel = [];
  var concern = [];
  var status = [];

  void _loggedin() async {
    /// for using an image from assets
    // final image = await imageFromAssetBundle('assets/image.png');

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            margin: const pw.EdgeInsets.all(20),
            child: pw.Column(children: [
              pw.Table(children: [
                pw.TableRow(children: [
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text('Name', style: const pw.TextStyle(fontSize: 6)),
                        pw.Divider(thickness: 1)
                      ]),
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text('Email',
                            style: const pw.TextStyle(fontSize: 6)),
                        pw.Divider(thickness: 1)
                      ]),
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text('Course',
                            style: const pw.TextStyle(fontSize: 6)),
                        pw.Divider(thickness: 1)
                      ]),
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text('Year Level',
                            style: const pw.TextStyle(fontSize: 6)),
                        pw.Divider(thickness: 1)
                      ]),
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text('Concern',
                            style: const pw.TextStyle(fontSize: 6)),
                        pw.Divider(thickness: 1)
                      ]),
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text('Status',
                            style: const pw.TextStyle(fontSize: 6)),
                        pw.Divider(thickness: 1)
                      ]),
                ])
              ]),
              pw.SizedBox(
                height: 20,
              ),
              for (int i = 0; i < name.length; i++)
                pw.Table(children: [
                  pw.TableRow(children: [
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(name[i],
                              style: const pw.TextStyle(fontSize: 6)),
                          pw.Divider(thickness: 1)
                        ]),
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(email[i],
                              style: const pw.TextStyle(fontSize: 6)),
                          pw.Divider(thickness: 1)
                        ]),
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(courseStud[i],
                              style: const pw.TextStyle(fontSize: 6)),
                          pw.Divider(thickness: 1)
                        ]),
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(yearLevel[i],
                              style: const pw.TextStyle(fontSize: 6)),
                          pw.Divider(thickness: 1)
                        ]),
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(concern[i],
                              style: const pw.TextStyle(fontSize: 6)),
                          pw.Divider(thickness: 1)
                        ]),
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(status[i],
                              style: const pw.TextStyle(fontSize: 6)),
                          pw.Divider(thickness: 1)
                        ]),
                  ])
                ])
            ]),
          );
        },
      ),
    ); // Page

    /// print the document using the iOS or Android print service:
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());

    /// share the document to other applications:
    await Printing.sharePdf(
        bytes: await doc.save(), filename: 'my-document.pdf');

    /// tutorial for using path_provider: https://www.youtube.com/watch?v=fJtFDrjEvE8
    /// save PDF with Flutter library "path_provider":
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/reports.pdf');
    await file.writeAsBytes(await doc.save());
  }

  getFilter() {
    if (course == 'All' && year == 'All') {
      return FirebaseFirestore.instance.collection('Concerns').snapshots();
    } else if (course == 'All') {
      return FirebaseFirestore.instance
          .collection('Concerns')
          .where('yearLevel', isEqualTo: year)
          .snapshots();
    } else if (year == 'All') {
      return FirebaseFirestore.instance
          .collection('Concerns')
          .where('course', isEqualTo: course)
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection('Concerns')
          .where('yearLevel', isEqualTo: year)
          .where('course', isEqualTo: course)
          .snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(widget.page),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                NormalText(label: 'Reports', fontSize: 24, color: primary),
                const Expanded(child: SizedBox()),
                GestureDetector(
                  onTap: () async {
                    _loggedin();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: primary, borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: NormalText(
                          label: 'Export in PDF',
                          fontSize: 15,
                          color: Colors.white),
                    ),
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
                      color: greyAccent,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
                      child: DropdownButton(
                        underline: Container(color: Colors.transparent),
                        iconEnabledColor: Colors.black,
                        isExpanded: true,
                        style: TextStyle(color: Colors.white),
                        value: _dropdownValue,
                        items: [
                          DropdownMenuItem(
                            onTap: () {
                              year = 'All';
                            },
                            value: 0,
                            child: DropDownItem(label: 'All'),
                          ),
                          DropdownMenuItem(
                            onTap: () {
                              year = 'First Year';
                            },
                            value: 1,
                            child: DropDownItem(label: '1st Year'),
                          ),
                          DropdownMenuItem(
                            onTap: () {
                              year = 'Second Year';
                            },
                            value: 2,
                            child: DropDownItem(label: '2nd Year'),
                          ),
                          DropdownMenuItem(
                            onTap: () {
                              year = 'Third Year';
                            },
                            value: 3,
                            child: DropDownItem(label: '3rd Year'),
                          ),
                          DropdownMenuItem(
                            onTap: () {
                              year = 'Fourth Year';
                            },
                            value: 4,
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
                      color: greyAccent,
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
                              course = "All";
                            },
                            value: 0,
                            child: Center(
                                child: Row(children: const [
                              Text("All",
                                  style: TextStyle(
                                    fontFamily: 'QRegular',
                                    color: primary,
                                  ))
                            ])),
                          ),
                          DropdownMenuItem(
                            onTap: () {
                              course = "Automotive";
                            },
                            value: 1,
                            child: Center(
                                child: Row(children: const [
                              Text("Automotive",
                                  style: TextStyle(
                                    fontFamily: 'QRegular',
                                    color: primary,
                                  ))
                            ])),
                          ),
                          DropdownMenuItem(
                            onTap: () {
                              course = "Food Technology";
                            },
                            value: 2,
                            child: Center(
                                child: Row(children: const [
                              Text("Food Technology",
                                  style: TextStyle(
                                    fontFamily: 'QRegular',
                                    color: primary,
                                  ))
                            ])),
                          ),
                          DropdownMenuItem(
                            onTap: () {
                              course = "Electronic Technology";
                            },
                            value: 3,
                            child: Center(
                                child: Row(children: const [
                              Text("Electronic Technology",
                                  style: TextStyle(
                                    fontFamily: 'QRegular',
                                    color: primary,
                                  ))
                            ])),
                          ),
                          DropdownMenuItem(
                            onTap: () {
                              course =
                                  "Entertainment and\nMultimedia Computing";
                            },
                            value: 4,
                            child: Center(
                                child: Row(children: const [
                              Text("Entertainment and\nMultimedia Computing",
                                  style: TextStyle(
                                    fontFamily: 'QRegular',
                                    color: primary,
                                  ))
                            ])),
                          ),
                          DropdownMenuItem(
                            onTap: () {
                              course = "Information Technology";
                            },
                            value: 5,
                            child: Center(
                                child: Row(children: const [
                              Text("Information Technology",
                                  style: TextStyle(
                                    fontFamily: 'QRegular',
                                    color: primary,
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
                stream: getFilter(),
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
                            name.add(data.docs[index]['name']);
                            email.add(data.docs[index]['email']);
                            courseStud.add(data.docs[index]['course']);
                            yearLevel.add(data.docs[index]['yearLevel']);
                            concern.add(data.docs[index]['concern']);
                            status.add(data.docs[index]['type']);
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
                                                color: primary)),
                                        DataColumn(
                                            label: NormalText(
                                                label: 'Student Name',
                                                fontSize: 12,
                                                color: primary)),
                                        DataColumn(
                                            label: NormalText(
                                                label: 'Time of\nConsultation',
                                                fontSize: 12,
                                                color: primary)),
                                        DataColumn(
                                            label: NormalText(
                                                label: 'Date of\nConsultation',
                                                fontSize: 12,
                                                color: primary)),
                                        DataColumn(
                                            label: NormalText(
                                                label: 'Course',
                                                fontSize: 12,
                                                color: primary)),
                                        DataColumn(
                                            label: NormalText(
                                                label: 'Year Level',
                                                fontSize: 12,
                                                color: primary)),
                                        DataColumn(
                                            label: NormalText(
                                                label:
                                                    'Purpose of\nConsultation',
                                                fontSize: 12,
                                                color: primary)),
                                        DataColumn(
                                            label: NormalText(
                                                label: 'Ticket Status',
                                                fontSize: 12,
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
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            ),
                                            DataCell(
                                              NormalText(
                                                  label: data.docs[i]['name'],
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            ),
                                            DataCell(
                                              NormalText(
                                                  label: data.docs[i]['time'],
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            ),
                                            DataCell(
                                              NormalText(
                                                  label:
                                                      formattedTime.toString(),
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            ),
                                            DataCell(
                                              NormalText(
                                                  label: data.docs[i]['course'],
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            ),
                                            DataCell(
                                              NormalText(
                                                  label: data.docs[i]
                                                      ['yearLevel'],
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            ),
                                            DataCell(
                                              NormalText(
                                                  label: data.docs[i]
                                                      ['concern'],
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            ),
                                            DataCell(
                                              NormalText(
                                                  label: data.docs[i]['type'],
                                                  fontSize: 12,
                                                  color: Colors.black),
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
