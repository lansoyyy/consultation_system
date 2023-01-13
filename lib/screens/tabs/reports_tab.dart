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

  String cdate2 = DateFormat("MMMM, dd, yyyy").format(DateTime.now());

  var name = [];
  var email = [];
  var courseStud = [];
  var yearLevel = [];
  var concern = [];
  var status = [];
  var classCodes = [];
  var sections = [];

  void _loggedin() async {
    /// for using an image from assets
    final image = await imageFromAssetBundle('assets/images/bsu.png');
    final image1 = await imageFromAssetBundle('assets/images/dean.jpg');

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            margin: const pw.EdgeInsets.all(20),
            child: pw.Column(children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Image(image, height: 50, width: 50),
                  pw.SizedBox(width: 25),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Text('BUKIDNON STATE UNIVERSITY',
                          style: const pw.TextStyle(fontSize: 12)),
                      pw.Text('COLLEGE OF TECHNOLOGIES',
                          style: const pw.TextStyle(fontSize: 12)),
                      pw.Text('Sayre Hwy, Malaybalay, 8700 Bukidnon',
                          style: const pw.TextStyle(fontSize: 8)),
                      pw.Text(
                          'Tel (088) 813-5661 to 5663; TeleFax (088) 813-2717, www.buksu.edu.ph',
                          style: const pw.TextStyle(fontSize: 8)),
                    ],
                  ),
                  pw.SizedBox(width: 25),
                  pw.Image(image1, height: 50, width: 50),
                ],
              ),
              pw.SizedBox(height: 50),
              pw.Text("STUDENT'S CONSULTATION LOG BOOK",
                  style: const pw.TextStyle(fontSize: 10)),
              pw.SizedBox(height: 10),
              pw.Table(
                  border: pw.TableBorder.all(color: PdfColors.black),
                  children: [
                    pw.TableRow(children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text('Name of Faculty',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.fromLTRB(50, 2, 50, 2),
                        child: pw.Text('                   ',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text('Semester & School Year',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.fromLTRB(50, 2, 50, 2),
                        child: pw.Text('                   ',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                    ]),
                    pw.TableRow(children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text('Department',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.fromLTRB(50, 2, 50, 2),
                        child:
                            pw.Text('', style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.fromLTRB(50, 2, 50, 2),
                        child: pw.Text('                   ',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.fromLTRB(50, 2, 50, 2),
                        child: pw.Text('                   ',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                    ])
                  ]),
              pw.SizedBox(height: 20),
              pw.Table(
                  border: pw.TableBorder.all(color: PdfColors.black),
                  children: [
                    pw.TableRow(children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text('Class Code',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text('Name',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text('Email',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text('Section',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text('Course',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text('Year Level',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text('Concern',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text('Status',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                    ]),
                    for (int i = 0; i < name.length; i++)
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(classCodes[i],
                              style: const pw.TextStyle(fontSize: 6)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(name[i],
                              style: const pw.TextStyle(fontSize: 6)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(email[i],
                              style: const pw.TextStyle(fontSize: 6)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(sections[i],
                              style: const pw.TextStyle(fontSize: 6)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(courseStud[i],
                              style: const pw.TextStyle(fontSize: 6)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(yearLevel[i],
                              style: const pw.TextStyle(fontSize: 6)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(concern[i],
                              style: const pw.TextStyle(fontSize: 6)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(status[i],
                              style: const pw.TextStyle(fontSize: 6)),
                        ),
                      ])
                  ]),
              pw.Expanded(
                child: pw.SizedBox(height: 50),
              ),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
                pw.Text('Consolidated by: ',
                    style: const pw.TextStyle(fontSize: 6)),
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Text('______________'),
                      pw.Text('Academic Adviser',
                          style: pw.TextStyle(
                              fontSize: 6, fontStyle: pw.FontStyle.italic)),
                    ]),
                pw.Expanded(
                  child: pw.SizedBox(height: 50),
                ),
                pw.Text('Reviewed and Approved by: ',
                    style: const pw.TextStyle(fontSize: 6)),
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.Text('______________'),
                      pw.Text('Program Coordinator/Chairperson',
                          style: pw.TextStyle(
                              fontSize: 6, fontStyle: pw.FontStyle.italic)),
                    ]),
              ]),
              pw.SizedBox(height: 20),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Document Code: OVPAA-F-INS-060B',
                            style: const pw.TextStyle(fontSize: 6)),
                        pw.Text('Uncontrolled document once printed',
                            style: pw.TextStyle(
                                fontSize: 4, fontStyle: pw.FontStyle.italic)),
                      ]),
                  pw.Text('Revision No.:0',
                      style: const pw.TextStyle(fontSize: 6)),
                  pw.Text('Issue No.:1',
                      style: const pw.TextStyle(fontSize: 6)),
                  pw.Text('Issue Date: $cdate2',
                      style: const pw.TextStyle(fontSize: 6)),
                ],
              ),
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

  String sort = 'name';

  getFilter() {
    if (course == 'All' && year == 'All') {
      return FirebaseFirestore.instance.collection('Concerns').snapshots();
    } else if (course == 'All') {
      return FirebaseFirestore.instance
          .collection('Concerns')
          .where('yearLevel', isEqualTo: year)
          .orderBy(sort)
          .snapshots();
    } else if (year == 'All') {
      return FirebaseFirestore.instance
          .collection('Concerns')
          .where('course', isEqualTo: course)
          .orderBy(sort)
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection('Concerns')
          .where('yearLevel', isEqualTo: year)
          .where('course', isEqualTo: course)
          .orderBy(sort)
          .snapshots();
    }
  }

  int _dropdownValue2 = 0;

  @override
  Widget build(BuildContext context) {
    print(sort);
    return Scaffold(
      appBar: appbarWidget(widget.page),
      body: Container(
        color: greyAccent,
        child: Padding(
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
                          color: primary,
                          borderRadius: BorderRadius.circular(5)),
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
                        child: DropdownButton(
                          underline: Container(color: Colors.transparent),
                          iconEnabledColor: Colors.black,
                          isExpanded: true,
                          style: const TextStyle(color: Colors.white),
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
                          style: const TextStyle(color: Colors.white),
                          value: _dropdownValue2,
                          items: [
                            DropdownMenuItem(
                              onTap: () {
                                setState(() {
                                  sort = 'name';
                                });
                              },
                              value: 0,
                              child: DropDownItem(label: 'Sort by: Names'),
                            ),
                            DropdownMenuItem(
                              onTap: () {
                                setState(() {
                                  sort = 'dateTime';
                                });
                              },
                              value: 1,
                              child: DropDownItem(label: 'Sort by: Date'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _dropdownValue2 = int.parse(value.toString());
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
                            itemCount: data.size == 0 ? 0 : 1,
                            itemBuilder: ((context, index) {
                              classCodes.add(data.docs[index]['classCode']);
                              sections.add(data.docs[index]['section']);
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
                                child: Container(
                                  height: 500,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 3, color: Colors.grey[200]!)),
                                  child: SingleChildScrollView(
                                    child: DataTable(
                                      headingRowColor: MaterialStateProperty
                                          .resolveWith<Color?>(
                                              (Set<MaterialState> states) {
                                        return Colors.blue[400];
                                        // Use the default value.
                                      }),
                                      border: TableBorder.all(
                                        color: Colors.white,
                                      ),
                                      // datatable widget
                                      columns: [
                                        // column to set the name
                                        DataColumn(
                                            label: BoldText(
                                                label: 'ID',
                                                fontSize: 12,
                                                color: Colors.white)),
                                        DataColumn(
                                            label: BoldText(
                                                label: 'Student\nName',
                                                fontSize: 14,
                                                color: Colors.white)),
                                        DataColumn(
                                            label: BoldText(
                                                label: 'Time of\nConsultation',
                                                fontSize: 14,
                                                color: Colors.white)),
                                        DataColumn(
                                            label: BoldText(
                                                label: 'Date of\nConsultation',
                                                fontSize: 14,
                                                color: Colors.white)),
                                        DataColumn(
                                            label: BoldText(
                                                label: 'Course',
                                                fontSize: 14,
                                                color: Colors.white)),
                                        DataColumn(
                                            label: BoldText(
                                                label: 'Year\nLevel',
                                                fontSize: 14,
                                                color: Colors.white)),
                                        DataColumn(
                                            label: BoldText(
                                                label:
                                                    'Purpose of\nConsultation',
                                                fontSize: 14,
                                                color: Colors.white)),
                                        DataColumn(
                                            label: BoldText(
                                                label: 'Ticket\nStatus',
                                                fontSize: 14,
                                                color: Colors.white)),
                                      ],

                                      rows: [
                                        // row to set the values
                                        for (int i = 1;
                                            i < snapshot.data!.size;
                                            i++)
                                          DataRow(
                                              color: MaterialStateProperty
                                                  .resolveWith<Color?>(
                                                      (Set<MaterialState>
                                                          states) {
                                                if (i.floor().isEven) {
                                                  return Colors.blueGrey[100];
                                                } else {
                                                  return Colors.grey[200];
                                                }
                                              }),
                                              cells: [
                                                DataCell(
                                                  NormalText(
                                                      label: i.toString(),
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                                DataCell(
                                                  NormalText(
                                                      label: data.docs[i]
                                                          ['name'],
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                                DataCell(
                                                  NormalText(
                                                      label: data.docs[i]
                                                          ['time'],
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                                DataCell(
                                                  NormalText(
                                                      label: formattedTime
                                                          .toString(),
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                                DataCell(
                                                  NormalText(
                                                      label: data.docs[i]
                                                          ['course'],
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
                                                      label: data.docs[i]
                                                          ['type'],
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                              ]),
                                      ],
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
      ),
    );
  }
}
