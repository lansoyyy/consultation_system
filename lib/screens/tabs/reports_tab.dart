import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation_system/constant/colors.dart';
import 'package:consultation_system/widgets/drop_down_button.dart';
import 'package:consultation_system/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  @override
  void initState() {
    getData();

    getData2();
    getData3();
    getData4();
    getData5();
    getTotal();
    getTotal2();
    getTotal3();
    getTotal4();
    getTotal5();
    getAllData();

    super.initState();
  }

  late int year1 = 0;

  late String concern1 = '';

  late String type = '';

  getData() async {
    // Use provider
    if (course != 'All') {
      var collection = FirebaseFirestore.instance
          .collection('Concerns')
          .where('course', isEqualTo: course)
          .where('yearLevel', isEqualTo: 'First Year');

      var querySnapshot = await collection.get();
      if (mounted) {
        setState(() {
          for (var queryDocumentSnapshot in querySnapshot.docs) {
            Map<String, dynamic> data = queryDocumentSnapshot.data();
            year1 = querySnapshot.size;
          }
        });
      }
    } else {
      var collection = FirebaseFirestore.instance.collection('Concerns');

      var querySnapshot = await collection.get();
      if (mounted) {
        setState(() {
          for (var queryDocumentSnapshot in querySnapshot.docs) {
            Map<String, dynamic> data = queryDocumentSnapshot.data();
            year1 = querySnapshot.size;
          }
        });
      }
    }
  }

  var listSections = [];

  List<int> sectionNumber = [];
  List<int> enrolled = [];

  var hasLoaded = false;

  getAllData() async {
    classCodes.clear();
    listSections.clear();
    // Class Code
    if (course == 'All') {
      var collection = FirebaseFirestore.instance.collection('Class Code');

      var querySnapshot = await collection.get();
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          classCodes.add(data['classCode']);
        }
      });

      var collection1 = FirebaseFirestore.instance.collection('Section');

      var querySnapshot1 = await collection1.get();
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot1.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          listSections.add(data['section']);
        }
      });
    } else {
      var collection = FirebaseFirestore.instance
          .collection('Class Code')
          .where('course', isEqualTo: course);

      var querySnapshot = await collection.get();
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          classCodes.add(data['classCode']);
        }
      });

      var collection1 = FirebaseFirestore.instance
          .collection('Section')
          .where('course', isEqualTo: course);

      var querySnapshot1 = await collection1.get();
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot1.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          listSections.add(data['section']);
        }
      });
    }
    enrolled.add(0);
    codeNumber.add(0);
    sectionNumber.add(0);
    codeEnrolled.add(0);

    setState(() {
      hasLoaded = true;
    });
  }

  var classCodes = [];

  var codeNumber = [];
  var codeEnrolled = [];

  getCodes() async {
    // Use provider

    setState(() {
      hasLoaded = true;
    });
  }

  late int year2 = 0;

  getData2() async {
    // Use provider

    if (course != 'All') {
      var collection = FirebaseFirestore.instance
          .collection('Concerns')
          .where('course', isEqualTo: course)
          .where('yearLevel', isEqualTo: 'Second Year');

      var querySnapshot = await collection.get();
      if (mounted) {
        setState(() {
          for (var queryDocumentSnapshot in querySnapshot.docs) {
            Map<String, dynamic> data = queryDocumentSnapshot.data();
            year2 = querySnapshot.size;
          }
        });
      }
    } else {
      var collection = FirebaseFirestore.instance
          .collection('Concerns')
          .where('yearLevel', isEqualTo: 'Second Year');

      var querySnapshot = await collection.get();
      if (mounted) {
        setState(() {
          for (var queryDocumentSnapshot in querySnapshot.docs) {
            Map<String, dynamic> data = queryDocumentSnapshot.data();
            year2 = querySnapshot.size;
          }
        });
      }
    }
  }

  late int year3 = 0;

  getData3() async {
    // Use provider
    if (course != 'All') {
      var collection = FirebaseFirestore.instance
          .collection('Concerns')
          .where('course', isEqualTo: course)
          .where('yearLevel', isEqualTo: 'Third Year');

      var querySnapshot = await collection.get();
      if (mounted) {
        setState(() {
          for (var queryDocumentSnapshot in querySnapshot.docs) {
            Map<String, dynamic> data = queryDocumentSnapshot.data();
            year3 = querySnapshot.size;
          }
        });
      }
    } else {
      var collection = FirebaseFirestore.instance
          .collection('Concerns')
          .where('yearLevel', isEqualTo: 'Third Year');

      var querySnapshot = await collection.get();
      if (mounted) {
        setState(() {
          for (var queryDocumentSnapshot in querySnapshot.docs) {
            Map<String, dynamic> data = queryDocumentSnapshot.data();
            year3 = querySnapshot.size;
          }
        });
      }
    }
  }

  late int year4 = 0;

  getData4() async {
    // Use provider
    if (course != 'All') {
      var collection = FirebaseFirestore.instance
          .collection('Concerns')
          .where('course', isEqualTo: course)
          .where('yearLevel', isEqualTo: 'Fourth Year');

      var querySnapshot = await collection.get();
      if (mounted) {
        setState(() {
          for (var queryDocumentSnapshot in querySnapshot.docs) {
            Map<String, dynamic> data = queryDocumentSnapshot.data();
            year4 = querySnapshot.size;
            concern1 = data['concern'];
            type = data['type'];
          }
        });
      }
    } else {
      var collection = FirebaseFirestore.instance
          .collection('Concerns')
          .where('yearLevel', isEqualTo: 'Fourth Year');

      var querySnapshot = await collection.get();
      if (mounted) {
        setState(() {
          for (var queryDocumentSnapshot in querySnapshot.docs) {
            Map<String, dynamic> data = queryDocumentSnapshot.data();
            year4 = querySnapshot.size;
            concern1 = data['concern'];
            type = data['type'];
          }
        });
      }
    }
  }

  late int year5 = 0;

  getData5() async {
    // Use provider
    if (course != 'All') {
      var collection = FirebaseFirestore.instance
          .collection('Concerns')
          .where('course', isEqualTo: course)
          .where('yearLevel', isEqualTo: 'Fifth Year');

      var querySnapshot = await collection.get();
      if (mounted) {
        setState(() {
          for (var queryDocumentSnapshot in querySnapshot.docs) {
            Map<String, dynamic> data = queryDocumentSnapshot.data();
            year5 = querySnapshot.size;
          }
        });
      }
    } else {
      var collection = FirebaseFirestore.instance
          .collection('Concerns')
          .where('yearLevel', isEqualTo: 'Fifth Year');

      var querySnapshot = await collection.get();
      if (mounted) {
        setState(() {
          for (var queryDocumentSnapshot in querySnapshot.docs) {
            Map<String, dynamic> data = queryDocumentSnapshot.data();
            year5 = querySnapshot.size;
          }
        });
      }
    }
  }

  late int total1 = 0;

  getTotal() async {
    // Use provider
    if (course != 'All') {
      var collection = FirebaseFirestore.instance
          .collection('Users')
          .where('course', isEqualTo: course)
          .where('yearLevel', isEqualTo: 'First Year');

      var querySnapshot = await collection.get();
      if (mounted) {
        setState(() {
          for (var queryDocumentSnapshot in querySnapshot.docs) {
            Map<String, dynamic> data = queryDocumentSnapshot.data();
            total1 = querySnapshot.size;
          }
        });
      }
    } else {
      var collection = FirebaseFirestore.instance
          .collection('Users')
          .where('yearLevel', isEqualTo: 'First Year');

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
  }

  late int total2 = 0;

  getTotal2() async {
    // Use provider
    if (course != 'All') {
      var collection = FirebaseFirestore.instance
          .collection('Users')
          .where('course', isEqualTo: course)
          .where('yearLevel', isEqualTo: 'Second Year');

      var querySnapshot = await collection.get();
      if (mounted) {
        setState(() {
          for (var queryDocumentSnapshot in querySnapshot.docs) {
            Map<String, dynamic> data = queryDocumentSnapshot.data();
            total2 = querySnapshot.size;
          }
        });
      }
    } else {
      var collection = FirebaseFirestore.instance
          .collection('Users')
          .where('yearLevel', isEqualTo: 'Second Year');

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
  }

  late int total3 = 0;

  getTotal3() async {
    // Use provider
    if (course != 'All') {
      var collection = FirebaseFirestore.instance
          .collection('Users')
          .where('course', isEqualTo: course)
          .where('yearLevel', isEqualTo: 'Third Year');

      var querySnapshot = await collection.get();
      if (mounted) {
        setState(() {
          for (var queryDocumentSnapshot in querySnapshot.docs) {
            Map<String, dynamic> data = queryDocumentSnapshot.data();
            total3 = querySnapshot.size;
          }
        });
      }
    } else {
      var collection = FirebaseFirestore.instance
          .collection('Users')
          .where('yearLevel', isEqualTo: 'Third Year');

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
  }

  late int total4 = 0;

  getTotal4() async {
    // Use provider
    if (course != 'All') {
      var collection = FirebaseFirestore.instance
          .collection('Users')
          .where('course', isEqualTo: course)
          .where('yearLevel', isEqualTo: 'Fourth Year');

      var querySnapshot = await collection.get();
      if (mounted) {
        setState(() {
          for (var queryDocumentSnapshot in querySnapshot.docs) {
            Map<String, dynamic> data = queryDocumentSnapshot.data();
            total4 = querySnapshot.size;
            concern1 = data['concern'];
            type = data['type'];
          }
        });
      }
    } else {
      var collection = FirebaseFirestore.instance
          .collection('Users')
          .where('yearLevel', isEqualTo: 'Fourth Year');

      var querySnapshot = await collection.get();
      if (mounted) {
        setState(() {
          for (var queryDocumentSnapshot in querySnapshot.docs) {
            Map<String, dynamic> data = queryDocumentSnapshot.data();
            total4 = querySnapshot.size;
            concern1 = data['concern'];
            type = data['type'];
          }
        });
      }
    }
  }

  late int total5 = 0;

  getTotal5() async {
    // Use provider
    if (course != 'All') {
      var collection = FirebaseFirestore.instance
          .collection('Users')
          .where('course', isEqualTo: course)
          .where('yearLevel', isEqualTo: 'Fifth Year');

      var querySnapshot = await collection.get();
      if (mounted) {
        setState(() {
          for (var queryDocumentSnapshot in querySnapshot.docs) {
            Map<String, dynamic> data = queryDocumentSnapshot.data();
            total5 = querySnapshot.size;
          }
        });
      }
    } else {
      var collection = FirebaseFirestore.instance
          .collection('Users')
          .where('yearLevel', isEqualTo: 'Fifth Year');

      var querySnapshot = await collection.get();
      if (mounted) {
        setState(() {
          for (var queryDocumentSnapshot in querySnapshot.docs) {
            Map<String, dynamic> data = queryDocumentSnapshot.data();
            total5 = querySnapshot.size;
          }
        });
      }
    }
  }

  late String year = 'All';

  int concernValue = 0;

  late String filterConcern = 'All';

  int typeValue = 0;

  late String filterType = 'All';

  int statusValue = 0;

  late String filterStatus = 'All';

  int _dropdownValue1 = 0;
  int _dropdownValue2 = 0;

  late String course = 'All';

  final doc = pw.Document();

  var index = 0;

  String cdate2 = DateFormat("MMMM, dd, yyyy").format(DateTime.now());

  var name = [];
  var email = [];
  var courseStud = [];
  var yearLevel = [];
  var concern = [];
  var status = [];

  void _loggedin() async {
    /// for using an image from assets
    final image = await imageFromAssetBundle('assets/images/bsu.png');
    final image1 = await imageFromAssetBundle('assets/images/dean.jpg');

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.letter.landscape,
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
                          child: pw.Text(listSections[i],
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
    // await Printing.sharePdf(
    //     bytes: await doc.save(), filename: 'my-document.pdf');

    // /// tutorial for using path_provider: https://www.youtube.com/watch?v=fJtFDrjEvE8
    // /// save PDF with Flutter library "path_provider":
    // final output = await getTemporaryDirectory();
    // final file = File('${output.path}/reports.pdf');
    // await file.writeAsBytes(await doc.save());
  }

  void consultationReport() async {
    /// for using an image from assets
    final image = await imageFromAssetBundle('assets/images/bsu.png');
    final image1 = await imageFromAssetBundle('assets/images/dean.jpg');

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.letter.landscape,
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
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Text("CONSOLIDATED STUDENT CONSULTATION REPORT",
                  style: const pw.TextStyle(fontSize: 10)),
              pw.SizedBox(height: 20),
              pw.Text("___________________________________________",
                  style: const pw.TextStyle(fontSize: 10)),
              pw.SizedBox(height: 10),
              pw.Text("(Program)",
                  style: pw.TextStyle(
                      fontSize: 6, fontStyle: pw.FontStyle.italic)),
              pw.SizedBox(height: 20),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text('Semester:___________ ',
                      style: const pw.TextStyle(fontSize: 6)),
                  pw.SizedBox(width: 30),
                  pw.Text('SY:___________ ',
                      style: const pw.TextStyle(fontSize: 6)),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Table(
                  border: pw.TableBorder.all(color: PdfColors.black),
                  children: [
                    pw.TableRow(children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text('Year Level',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text('No. of Students Enrolled',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text('No. of Students Consulted',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text('Percentage of Consultation',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text('Consultation Platform',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                            'Major or Common Issues Encountered by Students',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text('Action Taken and Status',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                    ]),
                    pw.TableRow(children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text('1st',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(total1.toString(),
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(year1.toString(),
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                            year1 == 0
                                ? "0.00%"
                                : "${((year1 / total1) * 100).toStringAsFixed(2)}%",
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text('Studcon Messaging App',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(year1 == 0 ? 'None' : concern1,
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(year1 == 0 ? 'None' : type,
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                    ]),
                    pw.TableRow(children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text('2nd',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(total2.toString(),
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(year2.toString(),
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                            year2 == 0
                                ? "0.00%"
                                : "${((year2 / total2) * 100).toStringAsFixed(2)}%",
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text('Studcon Messaging App',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(year2 == 0 ? 'None' : concern1,
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(year2 == 0 ? 'None' : type,
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                    ]),
                    pw.TableRow(children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text('3rd',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(total3.toString(),
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(year3.toString(),
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                            year3 == 0
                                ? "0.00%"
                                : "${((year3 / total3) * 100).toStringAsFixed(2)}%",
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text('Studcon Messaging App',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(year3 == 0 ? 'None' : concern1,
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(year3 == 0 ? 'None' : type,
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                    ]),
                    pw.TableRow(children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text('4th',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(total4.toString(),
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(year4.toString(),
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                            year4 == 0
                                ? "0.00%"
                                : "${((year4 / total4) * 100).toStringAsFixed(2)}%",
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text('Studcon Messaging App',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(year4 == 0 ? 'None' : concern1,
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(year4 == 0 ? 'None' : type,
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                    ]),
                    pw.TableRow(children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text('5th',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(total5.toString(),
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(year5.toString(),
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                            year5 == 0
                                ? "0.00%"
                                : "${((year5 / total5) * 100).toStringAsFixed(2)}%",
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text('Studcon Messaging App',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(year5 == 0 ? 'None' : concern1,
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(year5 == 0 ? 'None' : type,
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                    ]),
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
                      pw.Text('Program Coordinator/Chairperson',
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
                      pw.Text('Dean',
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
    // await Printing.sharePdf(
    //     bytes: await doc.save(), filename: 'my-document.pdf');

    // /// tutorial for using path_provider: https://www.youtube.com/watch?v=fJtFDrjEvE8
    // /// save PDF with Flutter library "path_provider":
    // final output = await getTemporaryDirectory();
    // final file = File('${output.path}/reports.pdf');
    // await file.writeAsBytes(await doc.save());
  }

  void reportByYear() async {
    /// for using an image from assets
    final image = await imageFromAssetBundle('assets/images/bsu.png');
    final image1 = await imageFromAssetBundle('assets/images/dean.jpg');

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.letter.landscape,
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
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Text("CONSOLIDATED STUDENT CONSULTATION REPORT",
                  style: const pw.TextStyle(fontSize: 10)),
              pw.SizedBox(height: 20),
              pw.Text("___________________________________________",
                  style: const pw.TextStyle(fontSize: 10)),
              pw.SizedBox(height: 10),
              pw.Text("Program and Year Level",
                  style: pw.TextStyle(
                      fontSize: 6, fontStyle: pw.FontStyle.italic)),
              pw.SizedBox(height: 20),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text('Semester:___________ ',
                      style: const pw.TextStyle(fontSize: 6)),
                  pw.SizedBox(width: 30),
                  pw.Text('SY:___________ ',
                      style: const pw.TextStyle(fontSize: 6)),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Table(
                  border: pw.TableBorder.all(color: PdfColors.black),
                  children: [
                    pw.TableRow(children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text('Class Section',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text('No. of Students Enrolled',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text('No. of Students Consulted',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text('Percentage of Consultation',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text('Consultation Platform',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                            'Major or Common Issues Encountered by Students',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text('Action Taken and Status',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                    ]),
                    for (int i = 0; i < listSections.length; i++)
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(2),
                          child: pw.Text(listSections[i],
                              style: const pw.TextStyle(fontSize: 6)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(2),
                          child: pw.Text(enrolled[i].toString(),
                              style: const pw.TextStyle(fontSize: 6)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(2),
                          child: pw.Text(
                              sectionNumber[i] == 0
                                  ? "0"
                                  : sectionNumber[i].toString(),
                              style: const pw.TextStyle(fontSize: 6)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(2),
                          child: pw.Text(
                              sectionNumber[i] == 0
                                  ? "0.00%"
                                  : "${((sectionNumber[i] / enrolled[i]) * 100).toStringAsFixed(2)}%",
                              style: const pw.TextStyle(fontSize: 6)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(2),
                          child: pw.Text('Studcon Messaging App',
                              style: const pw.TextStyle(fontSize: 6)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(2),
                          child: pw.Text(
                              sectionNumber[i] == 0 ? 'None' : concern1,
                              style: const pw.TextStyle(fontSize: 6)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(2),
                          child: pw.Text(sectionNumber[i] == 0 ? 'None' : type,
                              style: const pw.TextStyle(fontSize: 6)),
                        ),
                      ]),
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
                      pw.Text('Program Coordinator/Chairperson',
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
                      pw.Text('Dean',
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
    // await Printing.sharePdf(
    //     bytes: await doc.save(), filename: 'my-document.pdf');

    // /// tutorial for using path_provider: https://www.youtube.com/watch?v=fJtFDrjEvE8
    // /// save PDF with Flutter library "path_provider":
    // final output = await getTemporaryDirectory();
    // final file = File('${output.path}/reports.pdf');
    // await file.writeAsBytes(await doc.save());
  }

  String sort = 'dateTime';

  getFilter() {
    if (course == 'All' && filterConcern == 'All' && filterType == 'All') {
      return FirebaseFirestore.instance.collection('Concerns').snapshots();
    } else if (course == 'All' && filterType == 'All') {
      return FirebaseFirestore.instance
          .collection('Concerns')
          .where('concern', isEqualTo: filterConcern)
          .orderBy(sort)
          .snapshots();
    } else if (course == 'All' && filterConcern == 'All') {
      return FirebaseFirestore.instance
          .collection('Concerns')
          .where('type', isEqualTo: filterType)
          .orderBy(sort)
          .snapshots();
    } else if (filterConcern == 'All' && filterType == 'All') {
      return FirebaseFirestore.instance
          .collection('Concerns')
          .where('course', isEqualTo: course)
          .orderBy(sort)
          .snapshots();
    } else if (course == 'All') {
      return FirebaseFirestore.instance
          .collection('Concerns')
          .where('type', isEqualTo: filterType)
          .where('concern', isEqualTo: filterConcern)
          .orderBy(sort)
          .snapshots();
    } else if (filterType == 'All') {
      return FirebaseFirestore.instance
          .collection('Concerns')
          .where('course', isEqualTo: course)
          .where('concern', isEqualTo: filterConcern)
          .orderBy(sort)
          .snapshots();
    } else if (filterConcern == 'All') {
      return FirebaseFirestore.instance
          .collection('Concerns')
          .where('course', isEqualTo: course)
          .where('type', isEqualTo: filterType)
          .orderBy(sort)
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection('Concerns')
          .where('course', isEqualTo: course)
          .where('concern', isEqualTo: filterConcern)
          .where('type', isEqualTo: filterType)
          .orderBy(sort)
          .snapshots();
    }
  }

  void codeReport() async {
    /// for using an image from assets
    final image = await imageFromAssetBundle('assets/images/bsu.png');
    final image1 = await imageFromAssetBundle('assets/images/dean.jpg');

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.letter.landscape,
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
                ],
              ),
              pw.SizedBox(height: 50),
              pw.Text("STUDENT'S CONSULTATION REPORT",
                  style: const pw.TextStyle(fontSize: 10)),
              pw.SizedBox(height: 10),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text('Semester:___________ ',
                      style: const pw.TextStyle(fontSize: 6)),
                  pw.SizedBox(width: 30),
                  pw.Text('SY:___________ ',
                      style: const pw.TextStyle(fontSize: 6)),
                ],
              ),
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
                        child: pw.Text('No. of Students Enrolled',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text('No. of Students Consulted',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text('Percentage of Consultation',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text('Consultation Platform',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text(
                            'Major or Common Issues Encountered by Students',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(2),
                        child: pw.Text('Action Taken and Status',
                            style: const pw.TextStyle(fontSize: 6)),
                      ),
                    ]),
                    for (int i = 0; i < classCodes.length; i++)
                      pw.TableRow(children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(2),
                          child: pw.Text(classCodes[i],
                              style: const pw.TextStyle(fontSize: 6)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(2),
                          child: pw.Text(codeEnrolled[i].toString(),
                              style: const pw.TextStyle(fontSize: 6)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(2),
                          child: pw.Text(
                              codeNumber[i] == 0
                                  ? "0"
                                  : codeNumber[i].toString(),
                              style: const pw.TextStyle(fontSize: 6)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(2),
                          child: pw.Text(
                              ((codeNumber[i] / codeEnrolled[i]) * 100)
                                          .toStringAsFixed(2) +
                                      "%" ??
                                  0,
                              style: const pw.TextStyle(fontSize: 6)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(2),
                          child: pw.Text('Studcon Messaging App',
                              style: const pw.TextStyle(fontSize: 6)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(2),
                          child: pw.Text(codeNumber[i] == 0 ? 'None' : concern1,
                              style: const pw.TextStyle(fontSize: 6)),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(2),
                          child: pw.Text(codeNumber[i] == 0 ? 'None' : type,
                              style: const pw.TextStyle(fontSize: 6)),
                        ),
                      ]),
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
                      pw.Text('Faculty',
                          style: pw.TextStyle(
                              fontSize: 6, fontStyle: pw.FontStyle.italic)),
                    ]),
                pw.Expanded(
                  child: pw.SizedBox(height: 50),
                ),
                pw.Text('Reviewed by: ',
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
                pw.Text('Approved by: ',
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
    // await Printing.sharePdf(
    //     bytes: await doc.save(), filename: 'my-document.pdf');

    // /// tutorial for using path_provider: https://www.youtube.com/watch?v=fJtFDrjEvE8
    // /// save PDF with Flutter library "path_provider":
    // final output = await getTemporaryDirectory();
    // final file = File('${output.path}/reports.pdf');
    // await file.writeAsBytes(await doc.save());
  }

  @override
  Widget build(BuildContext context) {
    print(listSections);
    print(classCodes);
    return hasLoaded
        ? Scaffold(
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
                        NormalText(
                            label: 'Reports', fontSize: 24, color: primary),
                        const Expanded(child: SizedBox()),
                        const SizedBox(
                          width: 30,
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              index == 0 || index == 1
                                  ? Container(
                                      width: 240,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
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
                                                  course =
                                                      "Electronic Technology";
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
                                                      "Entertainment and Multimedia Computing";
                                                },
                                                value: 4,
                                                child: Center(
                                                    child: Row(children: const [
                                                  Text(
                                                      "Entertainment and\nMultimedia Computing",
                                                      style: TextStyle(
                                                        fontFamily: 'QRegular',
                                                        color: primary,
                                                      ))
                                                ])),
                                              ),
                                              DropdownMenuItem(
                                                onTap: () {
                                                  course =
                                                      "Information Technology";
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
                                                _dropdownValue1 =
                                                    int.parse(value.toString());

                                                year1 = 0;
                                                year2 = 0;
                                                year3 = 0;
                                                year4 = 0;
                                                year5 = 0;
                                                total1 = 0;
                                                total2 = 0;
                                                total3 = 0;
                                                total4 = 0;
                                                total5 = 0;
                                              });

                                              name.clear();
                                              email.clear();
                                              courseStud.clear();
                                              yearLevel.clear();
                                              concern.clear();
                                              status.clear();
                                              classCodes.clear();
                                              listSections.clear();

                                              getAllData();

                                              getData();

                                              getData2();
                                              getData3();
                                              getData4();
                                              getData5();
                                              getTotal();
                                              getTotal2();
                                              getTotal3();
                                              getTotal4();
                                              getTotal5();
                                            },
                                          )),
                                    )
                                  : Container(
                                      width: 240,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
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
                                            value: _dropdownValue2,
                                            items: [
                                              DropdownMenuItem(
                                                onTap: () {
                                                  course = "Automotive";
                                                },
                                                value: 0,
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
                                                value: 1,
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
                                                  course =
                                                      "Electronic Technology";
                                                },
                                                value: 2,
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
                                                      "Entertainment and Multimedia Computing";
                                                },
                                                value: 3,
                                                child: Center(
                                                    child: Row(children: const [
                                                  Text(
                                                      "Entertainment and\nMultimedia Computing",
                                                      style: TextStyle(
                                                        fontFamily: 'QRegular',
                                                        color: primary,
                                                      ))
                                                ])),
                                              ),
                                              DropdownMenuItem(
                                                onTap: () {
                                                  course =
                                                      "Information Technology";
                                                },
                                                value: 4,
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
                                                _dropdownValue2 =
                                                    int.parse(value.toString());

                                                year1 = 0;
                                                year2 = 0;
                                                year3 = 0;
                                                year4 = 0;
                                                year5 = 0;
                                                total1 = 0;
                                                total2 = 0;
                                                total3 = 0;
                                                total4 = 0;
                                                total5 = 0;
                                              });

                                              name.clear();
                                              email.clear();
                                              courseStud.clear();
                                              yearLevel.clear();
                                              concern.clear();
                                              status.clear();
                                              classCodes.clear();
                                              listSections.clear();
                                              getAllData();

                                              getData();

                                              getData2();
                                              getData3();
                                              getData4();
                                              getData5();
                                              getTotal();
                                              getTotal2();
                                              getTotal3();
                                              getTotal4();
                                              getTotal5();
                                            },
                                          )),
                                    ),
                              const SizedBox(
                                height: 5,
                              ),
                              NormalText(
                                  label: '  Filter by Department',
                                  fontSize: 8,
                                  color: Colors.grey),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        course != 'All'
                            ? PopupMenuButton(
                                tooltip: 'Generate Reports',
                                itemBuilder: ((context) {
                                  return [
                                    PopupMenuItem(
                                      child: ListTile(
                                        onTap: (() {
                                          setState(() {
                                            index = 0;

                                            year1 = 0;
                                            year2 = 0;
                                            year3 = 0;
                                            year4 = 0;
                                            year5 = 0;
                                            total1 = 0;
                                            total2 = 0;
                                            total3 = 0;
                                            total4 = 0;
                                            total5 = 0;
                                          });

                                          name.clear();
                                          email.clear();
                                          courseStud.clear();
                                          yearLevel.clear();
                                          concern.clear();
                                          status.clear();

                                          getData();

                                          getData2();
                                          getData3();
                                          getData4();
                                          getData5();
                                          getTotal();
                                          getTotal2();
                                          getTotal3();
                                          getTotal4();
                                          getTotal5();

                                          Navigator.pop(context);
                                        }),
                                        title: NormalText(
                                            label: 'Log Book',
                                            fontSize: 12,
                                            color: Colors.black),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      child: ListTile(
                                        onTap: (() {
                                          setState(() {
                                            index = 1;

                                            year1 = 0;
                                            year2 = 0;
                                            year3 = 0;
                                            year4 = 0;
                                            year5 = 0;
                                            total1 = 0;
                                            total2 = 0;
                                            total3 = 0;
                                            total4 = 0;
                                            total5 = 0;
                                          });

                                          name.clear();
                                          email.clear();
                                          courseStud.clear();
                                          yearLevel.clear();
                                          concern.clear();
                                          status.clear();

                                          getData();

                                          getData2();
                                          getData3();
                                          getData4();
                                          getData5();
                                          getTotal();
                                          getTotal2();
                                          getTotal3();
                                          getTotal4();
                                          getTotal5();

                                          Navigator.pop(context);

                                          // consultationReport();
                                        }),
                                        title: NormalText(
                                            label: 'Report by Year Level',
                                            fontSize: 12,
                                            color: Colors.black),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      child: ListTile(
                                        onTap: (() {
                                          setState(() {
                                            index = 2;

                                            year1 = 0;
                                            year2 = 0;
                                            year3 = 0;
                                            year4 = 0;
                                            year5 = 0;
                                            total1 = 0;
                                            total2 = 0;
                                            total3 = 0;
                                            total4 = 0;
                                            total5 = 0;
                                          });

                                          name.clear();
                                          email.clear();
                                          courseStud.clear();
                                          yearLevel.clear();
                                          concern.clear();
                                          status.clear();

                                          getData();

                                          getData2();
                                          getData3();
                                          getData4();
                                          getData5();
                                          getTotal();
                                          getTotal2();
                                          getTotal3();
                                          getTotal4();
                                          getTotal5();

                                          Navigator.pop(context);
                                          // reportByYear();
                                        }),
                                        title: NormalText(
                                            label: 'Report by Class Section',
                                            fontSize: 12,
                                            color: Colors.black),
                                      ),
                                    ),
                                    PopupMenuItem(
                                      child: ListTile(
                                        onTap: (() {
                                          setState(() {
                                            index = 3;

                                            year1 = 0;
                                            year2 = 0;
                                            year3 = 0;
                                            year4 = 0;
                                            year5 = 0;
                                            total1 = 0;
                                            total2 = 0;
                                            total3 = 0;
                                            total4 = 0;
                                            total5 = 0;
                                          });

                                          name.clear();
                                          email.clear();
                                          courseStud.clear();
                                          yearLevel.clear();
                                          concern.clear();
                                          status.clear();

                                          getData();

                                          getData2();
                                          getData3();
                                          getData4();
                                          getData5();
                                          getTotal();
                                          getTotal2();
                                          getTotal3();
                                          getTotal4();
                                          getTotal5();

                                          Navigator.pop(context);
                                          // codeReport();
                                        }),
                                        title: NormalText(
                                            label: 'Report by Class Code',
                                            fontSize: 12,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ];
                                }))
                            : const SizedBox(),
                        const SizedBox(
                          width: 50,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Expanded(
                      child: SizedBox(
                        child: IndexedStack(
                          index: index,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Row(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: MaterialButton(
                                            color: primary,
                                            minWidth: 150,
                                            height: 50,
                                            onPressed: (() {
                                              _loggedin();
                                            }),
                                            child: NormalText(
                                                label: 'Export in PDF',
                                                fontSize: 12,
                                                color: Colors.white)),
                                      ),
                                      const Expanded(
                                        child: SizedBox(),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 120,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 2, 20, 2),
                                                child: DropdownButton(
                                                  underline: Container(
                                                      color:
                                                          Colors.transparent),
                                                  iconEnabledColor:
                                                      Colors.black,
                                                  isExpanded: true,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                  value: typeValue,
                                                  items: [
                                                    DropdownMenuItem(
                                                      onTap: () {
                                                        filterType = 'All';
                                                      },
                                                      value: 0,
                                                      child: DropDownItem(
                                                          label: 'All'),
                                                    ),
                                                    DropdownMenuItem(
                                                      onTap: () {
                                                        filterType = 'Unsolved';
                                                      },
                                                      value: 1,
                                                      child: DropDownItem(
                                                          label: 'Unsolved'),
                                                    ),
                                                    DropdownMenuItem(
                                                      onTap: () {
                                                        filterType = 'Solved';
                                                      },
                                                      value: 2,
                                                      child: DropDownItem(
                                                          label: 'Solved'),
                                                    ),
                                                  ],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      typeValue = int.parse(
                                                          value.toString());
                                                    });
                                                    name.clear();
                                                    email.clear();
                                                    courseStud.clear();
                                                    yearLevel.clear();
                                                    concern.clear();
                                                    status.clear();

                                                    getData();

                                                    getData2();
                                                    getData3();
                                                    getData4();
                                                    getData5();
                                                    getTotal();
                                                    getTotal2();
                                                    getTotal3();
                                                    getTotal4();
                                                    getTotal5();
                                                  },
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            NormalText(
                                                label: '  Filter by Status',
                                                fontSize: 8,
                                                color: Colors.grey),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 200,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 2, 20, 2),
                                                child: DropdownButton(
                                                  underline: Container(
                                                      color:
                                                          Colors.transparent),
                                                  iconEnabledColor:
                                                      Colors.black,
                                                  isExpanded: true,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                  value: concernValue,
                                                  items: [
                                                    DropdownMenuItem(
                                                      onTap: () {
                                                        filterConcern = 'All';
                                                      },
                                                      value: 0,
                                                      child: DropDownItem(
                                                          label: 'All'),
                                                    ),
                                                    DropdownMenuItem(
                                                      onTap: () {
                                                        filterConcern =
                                                            'Grades';
                                                      },
                                                      value: 1,
                                                      child: DropDownItem(
                                                          label:
                                                              'Grades (INC, not\nyet graded)'),
                                                    ),
                                                    DropdownMenuItem(
                                                      onTap: () {
                                                        filterConcern =
                                                            'Classes';
                                                      },
                                                      value: 2,
                                                      child: DropDownItem(
                                                          label: 'Classes'),
                                                    ),
                                                    DropdownMenuItem(
                                                      onTap: () {
                                                        filterConcern =
                                                            'Attendance';
                                                      },
                                                      value: 3,
                                                      child: DropDownItem(
                                                          label: 'Attendance'),
                                                    ),
                                                    DropdownMenuItem(
                                                      onTap: () {
                                                        filterConcern =
                                                            'Requirements';
                                                      },
                                                      value: 4,
                                                      child: DropDownItem(
                                                          label:
                                                              'Requirements (Projects,\nQuizzes,Late submission,\nAssignments)'),
                                                    ),
                                                  ],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      concernValue = int.parse(
                                                          value.toString());
                                                    });
                                                    name.clear();
                                                    email.clear();
                                                    courseStud.clear();
                                                    yearLevel.clear();
                                                    concern.clear();
                                                    status.clear();

                                                    getData();

                                                    getData2();
                                                    getData3();
                                                    getData4();
                                                    getData5();
                                                    getTotal();
                                                    getTotal2();
                                                    getTotal3();
                                                    getTotal4();
                                                    getTotal5();
                                                  },
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            NormalText(
                                                label: '  Filter by Concern',
                                                fontSize: 8,
                                                color: Colors.grey),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                StreamBuilder<QuerySnapshot>(
                                    stream: getFilter(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasError) {
                                        print(snapshot.error);
                                        return const Center(
                                            child: Text('Error'));
                                      }
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
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
                                                name.add(
                                                    data.docs[index]['name']);
                                                email.add(
                                                    data.docs[index]['email']);
                                                courseStud.add(
                                                    data.docs[index]['course']);
                                                yearLevel.add(data.docs[index]
                                                    ['yearLevel']);
                                                concern.add(data.docs[index]
                                                    ['concern']);
                                                status.add(
                                                    data.docs[index]['type']);

                                                DateTime created = data
                                                    .docs[index]['dateTime']
                                                    .toDate();

                                                String formattedTime =
                                                    DateFormat.yMMMd()
                                                        .add_jm()
                                                        .format(created);
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 25),
                                                  child: Container(
                                                    height: 500,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 3,
                                                            color: Colors
                                                                .grey[200]!)),
                                                    child:
                                                        SingleChildScrollView(
                                                      child: DataTable(
                                                        headingRowColor:
                                                            MaterialStateProperty
                                                                .resolveWith<
                                                                    Color?>((Set<
                                                                        MaterialState>
                                                                    states) {
                                                          return Colors
                                                              .blue[400];
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
                                                                  label:
                                                                      'Student\nName',
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white)),
                                                          DataColumn(
                                                              label: BoldText(
                                                                  label:
                                                                      'Time of\nConsultation',
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white)),
                                                          DataColumn(
                                                              label: BoldText(
                                                                  label:
                                                                      'Date of\nConsultation',
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white)),
                                                          DataColumn(
                                                              label: BoldText(
                                                                  label:
                                                                      'Course',
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white)),
                                                          DataColumn(
                                                              label: BoldText(
                                                                  label:
                                                                      'Year\nLevel',
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white)),
                                                          DataColumn(
                                                              label: BoldText(
                                                                  label:
                                                                      'Purpose of\nConsultation',
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white)),
                                                          DataColumn(
                                                              label: BoldText(
                                                                  label:
                                                                      'Ticket\nStatus',
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white)),
                                                        ],

                                                        rows: [
                                                          // row to set the values
                                                          for (int i = 0;
                                                              i <
                                                                  snapshot.data!
                                                                      .size;
                                                              i++)
                                                            DataRow(
                                                                color: MaterialStateProperty
                                                                    .resolveWith<
                                                                        Color?>((Set<
                                                                            MaterialState>
                                                                        states) {
                                                                  if (i
                                                                      .floor()
                                                                      .isEven) {
                                                                    return Colors
                                                                            .blueGrey[
                                                                        100];
                                                                  } else {
                                                                    return Colors
                                                                            .grey[
                                                                        200];
                                                                  }
                                                                }),
                                                                cells: [
                                                                  DataCell(
                                                                    NormalText(
                                                                        label: data.docs[i]
                                                                            [
                                                                            'name'],
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                  DataCell(
                                                                    NormalText(
                                                                        label: data.docs[i]
                                                                            [
                                                                            'time'],
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                  DataCell(
                                                                    NormalText(
                                                                        label: formattedTime
                                                                            .toString(),
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                  DataCell(
                                                                    NormalText(
                                                                        label: data.docs[i]
                                                                            [
                                                                            'course'],
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                  DataCell(
                                                                    NormalText(
                                                                        label: data.docs[i]
                                                                            [
                                                                            'yearLevel'],
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                  DataCell(
                                                                    NormalText(
                                                                        label: data.docs[i]
                                                                            [
                                                                            'concern'],
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                  DataCell(
                                                                    NormalText(
                                                                        label: data.docs[i]
                                                                            [
                                                                            'type'],
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .black),
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
                                    }),
                              ],
                            ),
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: MaterialButton(
                                        color: primary,
                                        minWidth: 150,
                                        height: 50,
                                        onPressed: (() {
                                          consultationReport();
                                        }),
                                        child: NormalText(
                                            label: 'Export in PDF',
                                            fontSize: 12,
                                            color: Colors.white)),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 25),
                                    child: Container(
                                      height: 450,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 3,
                                              color: Colors.grey[200]!)),
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
                                                    label: 'Year\nLevel',
                                                    fontSize: 12,
                                                    color: Colors.white)),
                                            DataColumn(
                                                label: BoldText(
                                                    label:
                                                        'No. of\nStudents Enrolled',
                                                    fontSize: 12,
                                                    color: Colors.white)),
                                            DataColumn(
                                                label: BoldText(
                                                    label:
                                                        'No. of\nStudents Consulted',
                                                    fontSize: 12,
                                                    color: Colors.white)),
                                            DataColumn(
                                                label: BoldText(
                                                    label:
                                                        'Percentage of\nConsultation',
                                                    fontSize: 12,
                                                    color: Colors.white)),
                                            DataColumn(
                                                label: BoldText(
                                                    label:
                                                        'Consultation\nPlatform',
                                                    fontSize: 12,
                                                    color: Colors.white)),
                                            DataColumn(
                                                label: BoldText(
                                                    label:
                                                        'Major or Common\nConcerns/Issues\nEncountered by Students',
                                                    fontSize: 12,
                                                    color: Colors.white)),
                                            DataColumn(
                                                label: BoldText(
                                                    label:
                                                        'Actions Taken\nand Status',
                                                    fontSize: 12,
                                                    color: Colors.white)),
                                          ],

                                          rows: [
                                            DataRow(
                                                color: MaterialStateProperty
                                                    .resolveWith<Color?>(
                                                        (Set<MaterialState>
                                                            states) {
                                                  return Colors.blueGrey[100];
                                                }),
                                                cells: [
                                                  DataCell(
                                                    NormalText(
                                                        label: '1st',
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                  DataCell(
                                                    NormalText(
                                                        label:
                                                            total1.toString(),
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                  DataCell(
                                                    NormalText(
                                                        label: year1.toString(),
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                  DataCell(
                                                    NormalText(
                                                        label: year1 == 0
                                                            ? "0.00%"
                                                            : "${((year1 / total1) * 100).toStringAsFixed(2)}%",
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                  DataCell(
                                                    NormalText(
                                                        label:
                                                            'Studcon Messaging App',
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                  DataCell(
                                                    NormalText(
                                                        label: year1 == 0
                                                            ? "0"
                                                            : concern1,
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                  DataCell(
                                                    NormalText(
                                                        label: year1 == 0
                                                            ? "0"
                                                            : type,
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                ]),
                                            DataRow(
                                                color: MaterialStateProperty
                                                    .resolveWith<Color?>(
                                                        (Set<MaterialState>
                                                            states) {
                                                  return Colors.blueGrey[100];
                                                }),
                                                cells: [
                                                  DataCell(
                                                    NormalText(
                                                        label: '2nd',
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                  DataCell(
                                                    NormalText(
                                                        label:
                                                            total2.toString(),
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                  DataCell(
                                                    NormalText(
                                                        label: year2.toString(),
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                  DataCell(
                                                    NormalText(
                                                        label: year2 == 0
                                                            ? "0.00%"
                                                            : "${((year2 / total2) * 100).toStringAsFixed(2)}%",
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                  DataCell(
                                                    NormalText(
                                                        label:
                                                            'Studcon Messaging App',
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                  DataCell(
                                                    NormalText(
                                                        label: year2 == 0
                                                            ? "0"
                                                            : concern1,
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                  DataCell(
                                                    NormalText(
                                                        label: year3 == 0
                                                            ? "0"
                                                            : type,
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                ]),
                                            DataRow(
                                                color: MaterialStateProperty
                                                    .resolveWith<Color?>(
                                                        (Set<MaterialState>
                                                            states) {
                                                  return Colors.blueGrey[100];
                                                }),
                                                cells: [
                                                  DataCell(
                                                    NormalText(
                                                        label: '3rd',
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                  DataCell(
                                                    NormalText(
                                                        label:
                                                            total3.toString(),
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                  DataCell(
                                                    NormalText(
                                                        label: year3.toString(),
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                  DataCell(
                                                    NormalText(
                                                        label: year3 == 0
                                                            ? "0.00%"
                                                            : "${((year3 / total3) * 100).toStringAsFixed(2)}%",
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                  DataCell(
                                                    NormalText(
                                                        label:
                                                            'Studcon Messaging App',
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                  DataCell(
                                                    NormalText(
                                                        label: year3 == 0
                                                            ? "0"
                                                            : concern1,
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                  DataCell(
                                                    NormalText(
                                                        label: year3 == 0
                                                            ? "0"
                                                            : type,
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                ]),
                                            DataRow(
                                                color: MaterialStateProperty
                                                    .resolveWith<Color?>(
                                                        (Set<MaterialState>
                                                            states) {
                                                  return Colors.blueGrey[100];
                                                }),
                                                cells: [
                                                  DataCell(
                                                    NormalText(
                                                        label: '4th',
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                  DataCell(
                                                    NormalText(
                                                        label:
                                                            total4.toString(),
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                  DataCell(
                                                    NormalText(
                                                        label: year4.toString(),
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                  DataCell(
                                                    NormalText(
                                                        label: year4 == 0
                                                            ? "0.00%"
                                                            : "${((year4 / total4) * 100).toStringAsFixed(2)}%",
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                  DataCell(
                                                    NormalText(
                                                        label:
                                                            'Studcon Messaging App',
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                  DataCell(
                                                    NormalText(
                                                        label: year4 == 0
                                                            ? "0"
                                                            : concern1,
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                  DataCell(
                                                    NormalText(
                                                        label: year4 == 0
                                                            ? "0"
                                                            : type,
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                ]),
                                            DataRow(
                                                color: MaterialStateProperty
                                                    .resolveWith<Color?>(
                                                        (Set<MaterialState>
                                                            states) {
                                                  return Colors.blueGrey[100];
                                                }),
                                                cells: [
                                                  DataCell(
                                                    NormalText(
                                                        label: '5th',
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                  DataCell(
                                                    NormalText(
                                                        label:
                                                            total5.toString(),
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                  DataCell(
                                                    NormalText(
                                                        label: year5.toString(),
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                  DataCell(
                                                    NormalText(
                                                        label: year5 == 0
                                                            ? "0.00%"
                                                            : "${((year5 / total5) * 100).toStringAsFixed(2)}%",
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                  DataCell(
                                                    NormalText(
                                                        label:
                                                            'Studcon Messaging App',
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                  DataCell(
                                                    NormalText(
                                                        label: year5 == 0
                                                            ? "0"
                                                            : concern1,
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                  DataCell(
                                                    NormalText(
                                                        label: year5 == 0
                                                            ? "0"
                                                            : type,
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                ]),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: MaterialButton(
                                        color: primary,
                                        minWidth: 150,
                                        height: 50,
                                        onPressed: (() {
                                          reportByYear();
                                        }),
                                        child: NormalText(
                                            label: 'Export in PDF',
                                            fontSize: 12,
                                            color: Colors.white)),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 25),
                                    child: Container(
                                      height: 450,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 3,
                                              color: Colors.grey[200]!)),
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
                                                    label: 'Class\nSection',
                                                    fontSize: 12,
                                                    color: Colors.white)),
                                            DataColumn(
                                                label: BoldText(
                                                    label:
                                                        'No. of\nStudents Enrolled',
                                                    fontSize: 12,
                                                    color: Colors.white)),
                                            DataColumn(
                                                label: BoldText(
                                                    label:
                                                        'No. of\nStudents Consulted',
                                                    fontSize: 12,
                                                    color: Colors.white)),
                                            DataColumn(
                                                label: BoldText(
                                                    label:
                                                        'Percentage of\nConsultation',
                                                    fontSize: 12,
                                                    color: Colors.white)),
                                            DataColumn(
                                                label: BoldText(
                                                    label:
                                                        'Consultation\nPlatform',
                                                    fontSize: 12,
                                                    color: Colors.white)),
                                            DataColumn(
                                                label: BoldText(
                                                    label:
                                                        'Major or Common\nConcerns/Issues\nEncountered by Students',
                                                    fontSize: 12,
                                                    color: Colors.white)),
                                            DataColumn(
                                                label: BoldText(
                                                    label:
                                                        'Actions Taken\nand Status',
                                                    fontSize: 12,
                                                    color: Colors.white)),
                                          ],

                                          rows: [
                                            for (int i = 1;
                                                i < listSections.length;
                                                i++)
                                              DataRow(
                                                  color: MaterialStateProperty
                                                      .resolveWith<Color?>(
                                                          (Set<MaterialState>
                                                              states) {
                                                    return Colors.blueGrey[100];
                                                  }),
                                                  cells: [
                                                    DataCell(
                                                      NormalText(
                                                          label:
                                                              listSections[i],
                                                          fontSize: 12,
                                                          color: Colors.black),
                                                    ),
                                                    DataCell(
                                                      StreamBuilder<
                                                              QuerySnapshot>(
                                                          stream: FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'Users')
                                                              .where('section',
                                                                  isEqualTo:
                                                                      listSections[
                                                                          i])
                                                              .snapshots(),
                                                          builder: (BuildContext
                                                                  context,
                                                              AsyncSnapshot<
                                                                      QuerySnapshot>
                                                                  snapshot) {
                                                            if (snapshot
                                                                .hasError) {
                                                              print('error');
                                                              return const Center(
                                                                  child: Text(
                                                                      'Error'));
                                                            }
                                                            if (snapshot
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .waiting) {
                                                              return const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            50),
                                                                child: Center(
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                  color: Colors
                                                                      .black,
                                                                )),
                                                              );
                                                            }

                                                            final data = snapshot
                                                                .requireData;
                                                            return NormalText(
                                                                label: data
                                                                    .docs.length
                                                                    .toString(),
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black);
                                                          }),
                                                    ),
                                                    DataCell(
                                                      StreamBuilder<
                                                              QuerySnapshot>(
                                                          stream: FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'Concerns')
                                                              .where('section',
                                                                  isEqualTo:
                                                                      listSections[
                                                                          i])
                                                              .snapshots(),
                                                          builder: (BuildContext
                                                                  context,
                                                              AsyncSnapshot<
                                                                      QuerySnapshot>
                                                                  snapshot) {
                                                            if (snapshot
                                                                .hasError) {
                                                              print('error');
                                                              return const Center(
                                                                  child: Text(
                                                                      'Error'));
                                                            }
                                                            if (snapshot
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .waiting) {
                                                              return const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            50),
                                                                child: Center(
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                  color: Colors
                                                                      .black,
                                                                )),
                                                              );
                                                            }

                                                            final data = snapshot
                                                                .requireData;
                                                            return NormalText(
                                                                label: data
                                                                    .docs.length
                                                                    .toString(),
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black);
                                                          }),
                                                    ),
                                                    DataCell(
                                                      StreamBuilder<
                                                              QuerySnapshot>(
                                                          stream: FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'Concerns')
                                                              .where(
                                                                  'classCode',
                                                                  isEqualTo:
                                                                      classCodes[
                                                                          i])
                                                              .snapshots(),
                                                          builder: (BuildContext
                                                                  context,
                                                              AsyncSnapshot<
                                                                      QuerySnapshot>
                                                                  snapshot1) {
                                                            if (snapshot1
                                                                .hasError) {
                                                              print('error');
                                                              return const Center(
                                                                  child: Text(
                                                                      'Error'));
                                                            }
                                                            if (snapshot1
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .waiting) {
                                                              return const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            50),
                                                                child: Center(
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                  color: Colors
                                                                      .black,
                                                                )),
                                                              );
                                                            }

                                                            final data1 =
                                                                snapshot1
                                                                    .requireData;
                                                            return StreamBuilder<
                                                                    QuerySnapshot>(
                                                                stream: FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'Users')
                                                                    .where(
                                                                        'classCode',
                                                                        isEqualTo:
                                                                            classCodes[
                                                                                i])
                                                                    .snapshots(),
                                                                builder: (BuildContext
                                                                        context,
                                                                    AsyncSnapshot<
                                                                            QuerySnapshot>
                                                                        snapshot) {
                                                                  if (snapshot
                                                                      .hasError) {
                                                                    print(
                                                                        'error');
                                                                    return const Center(
                                                                        child: Text(
                                                                            'Error'));
                                                                  }
                                                                  if (snapshot
                                                                          .connectionState ==
                                                                      ConnectionState
                                                                          .waiting) {
                                                                    return const Padding(
                                                                      padding: EdgeInsets
                                                                          .only(
                                                                              top: 50),
                                                                      child: Center(
                                                                          child: CircularProgressIndicator(
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                                    );
                                                                  }

                                                                  final data =
                                                                      snapshot
                                                                          .requireData;
                                                                  return NormalText(
                                                                      label: data1
                                                                              .docs
                                                                              .isEmpty
                                                                          ? "0"
                                                                          : "${((data1.docs.length / data.docs.length) * 100).toStringAsFixed(2)}%"
                                                                              .toString(),
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black);
                                                                });
                                                          }),
                                                    ),
                                                    DataCell(
                                                      NormalText(
                                                          label:
                                                              'Studcon Messaging App',
                                                          fontSize: 12,
                                                          color: Colors.black),
                                                    ),
                                                    DataCell(
                                                      StreamBuilder<
                                                              QuerySnapshot>(
                                                          stream: FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'Concerns')
                                                              .where(
                                                                  'classCode',
                                                                  isEqualTo:
                                                                      classCodes[
                                                                          i])
                                                              .snapshots(),
                                                          builder: (BuildContext
                                                                  context,
                                                              AsyncSnapshot<
                                                                      QuerySnapshot>
                                                                  snapshot1) {
                                                            if (snapshot1
                                                                .hasError) {
                                                              print('error');
                                                              return const Center(
                                                                  child: Text(
                                                                      'Error'));
                                                            }
                                                            if (snapshot1
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .waiting) {
                                                              return const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            50),
                                                                child: Center(
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                  color: Colors
                                                                      .black,
                                                                )),
                                                              );
                                                            }

                                                            final data1 =
                                                                snapshot1
                                                                    .requireData;
                                                            return NormalText(
                                                                label: data1
                                                                        .docs
                                                                        .isEmpty
                                                                    ? '0'
                                                                    : concern1,
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black);
                                                          }),
                                                    ),
                                                    DataCell(
                                                      StreamBuilder<
                                                              QuerySnapshot>(
                                                          stream: FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'Concerns')
                                                              .where(
                                                                  'classCode',
                                                                  isEqualTo:
                                                                      classCodes[
                                                                          i])
                                                              .snapshots(),
                                                          builder: (BuildContext
                                                                  context,
                                                              AsyncSnapshot<
                                                                      QuerySnapshot>
                                                                  snapshot1) {
                                                            if (snapshot1
                                                                .hasError) {
                                                              print('error');
                                                              return const Center(
                                                                  child: Text(
                                                                      'Error'));
                                                            }
                                                            if (snapshot1
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .waiting) {
                                                              return const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            50),
                                                                child: Center(
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                  color: Colors
                                                                      .black,
                                                                )),
                                                              );
                                                            }

                                                            final data1 =
                                                                snapshot1
                                                                    .requireData;
                                                            return NormalText(
                                                                label: data1
                                                                        .docs
                                                                        .isEmpty
                                                                    ? '0'
                                                                    : type,
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black);
                                                          }),
                                                    ),
                                                  ])
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: MaterialButton(
                                        color: primary,
                                        minWidth: 150,
                                        height: 50,
                                        onPressed: (() {
                                          codeReport();
                                        }),
                                        child: NormalText(
                                            label: 'Export in PDF',
                                            fontSize: 12,
                                            color: Colors.white)),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 25),
                                    child: Container(
                                      height: 450,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 3,
                                              color: Colors.grey[200]!)),
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
                                                    label: 'Class\nCode',
                                                    fontSize: 12,
                                                    color: Colors.white)),
                                            DataColumn(
                                                label: BoldText(
                                                    label:
                                                        'No. of\nStudents Enrolled',
                                                    fontSize: 12,
                                                    color: Colors.white)),
                                            DataColumn(
                                                label: BoldText(
                                                    label:
                                                        'No. of\nStudents Consulted',
                                                    fontSize: 12,
                                                    color: Colors.white)),

                                            DataColumn(
                                                label: BoldText(
                                                    label:
                                                        'Percentage of\nConsultation',
                                                    fontSize: 12,
                                                    color: Colors.white)),
                                            DataColumn(
                                                label: BoldText(
                                                    label:
                                                        'Consultation\nPlatform',
                                                    fontSize: 12,
                                                    color: Colors.white)),
                                            DataColumn(
                                                label: BoldText(
                                                    label:
                                                        'Major or Common\nConcerns/Issues\nEncountered by Students',
                                                    fontSize: 12,
                                                    color: Colors.white)),
                                            DataColumn(
                                                label: BoldText(
                                                    label:
                                                        'Actions Taken\nand Status',
                                                    fontSize: 12,
                                                    color: Colors.white)),
                                          ],

                                          rows: [
                                            for (int i = 0;
                                                i < classCodes.length;
                                                i++)
                                              DataRow(
                                                  color: MaterialStateProperty
                                                      .resolveWith<Color?>(
                                                          (Set<MaterialState>
                                                              states) {
                                                    return Colors.blueGrey[100];
                                                  }),
                                                  cells: [
                                                    DataCell(
                                                      NormalText(
                                                          label: classCodes[i],
                                                          fontSize: 12,
                                                          color: Colors.black),
                                                    ),
                                                    DataCell(
                                                      StreamBuilder<
                                                              QuerySnapshot>(
                                                          stream: FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'Users')
                                                              .where(
                                                                  'classCode',
                                                                  isEqualTo:
                                                                      classCodes[
                                                                          i])
                                                              .snapshots(),
                                                          builder: (BuildContext
                                                                  context,
                                                              AsyncSnapshot<
                                                                      QuerySnapshot>
                                                                  snapshot) {
                                                            if (snapshot
                                                                .hasError) {
                                                              print('error');
                                                              return const Center(
                                                                  child: Text(
                                                                      'Error'));
                                                            }
                                                            if (snapshot
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .waiting) {
                                                              return const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            50),
                                                                child: Center(
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                  color: Colors
                                                                      .black,
                                                                )),
                                                              );
                                                            }

                                                            final data = snapshot
                                                                .requireData;

                                                            return NormalText(
                                                                label: data
                                                                    .docs.length
                                                                    .toString(),
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black);
                                                          }),
                                                    ),
                                                    DataCell(
                                                      StreamBuilder<
                                                              QuerySnapshot>(
                                                          stream: FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'Concerns')
                                                              .where(
                                                                  'classCode',
                                                                  isEqualTo:
                                                                      classCodes[
                                                                          i])
                                                              .snapshots(),
                                                          builder: (BuildContext
                                                                  context,
                                                              AsyncSnapshot<
                                                                      QuerySnapshot>
                                                                  snapshot) {
                                                            if (snapshot
                                                                .hasError) {
                                                              print('error');
                                                              return const Center(
                                                                  child: Text(
                                                                      'Error'));
                                                            }
                                                            if (snapshot
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .waiting) {
                                                              return const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            50),
                                                                child: Center(
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                  color: Colors
                                                                      .black,
                                                                )),
                                                              );
                                                            }

                                                            final data = snapshot
                                                                .requireData;

                                                            return NormalText(
                                                                label: data
                                                                    .docs.length
                                                                    .toString(),
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black);
                                                          }),
                                                    ),
                                                    DataCell(
                                                      StreamBuilder<
                                                              QuerySnapshot>(
                                                          stream: FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'Concerns')
                                                              .where(
                                                                  'classCode',
                                                                  isEqualTo:
                                                                      classCodes[
                                                                          i])
                                                              .snapshots(),
                                                          builder: (BuildContext
                                                                  context,
                                                              AsyncSnapshot<
                                                                      QuerySnapshot>
                                                                  snapshot1) {
                                                            if (snapshot1
                                                                .hasError) {
                                                              print('error');
                                                              return const Center(
                                                                  child: Text(
                                                                      'Error'));
                                                            }
                                                            if (snapshot1
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .waiting) {
                                                              return const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            50),
                                                                child: Center(
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                  color: Colors
                                                                      .black,
                                                                )),
                                                              );
                                                            }

                                                            final data1 =
                                                                snapshot1
                                                                    .requireData;
                                                            return StreamBuilder<
                                                                    QuerySnapshot>(
                                                                stream: FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'Users')
                                                                    .where(
                                                                        'classCode',
                                                                        isEqualTo:
                                                                            classCodes[
                                                                                i])
                                                                    .snapshots(),
                                                                builder: (BuildContext
                                                                        context,
                                                                    AsyncSnapshot<
                                                                            QuerySnapshot>
                                                                        snapshot) {
                                                                  if (snapshot
                                                                      .hasError) {
                                                                    print(
                                                                        'error');
                                                                    return const Center(
                                                                        child: Text(
                                                                            'Error'));
                                                                  }
                                                                  if (snapshot
                                                                          .connectionState ==
                                                                      ConnectionState
                                                                          .waiting) {
                                                                    return const Padding(
                                                                      padding: EdgeInsets
                                                                          .only(
                                                                              top: 50),
                                                                      child: Center(
                                                                          child: CircularProgressIndicator(
                                                                        color: Colors
                                                                            .black,
                                                                      )),
                                                                    );
                                                                  }

                                                                  final data =
                                                                      snapshot
                                                                          .requireData;
                                                                  return NormalText(
                                                                      label: data
                                                                              .docs
                                                                              .isEmpty
                                                                          ? "0"
                                                                          : "${((data.docs.length / data1.docs.length) * 100).toStringAsFixed(2)}%",
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black);
                                                                });
                                                          }),
                                                    ),
                                                    DataCell(
                                                      NormalText(
                                                          label:
                                                              'Studcon Messaging App',
                                                          fontSize: 12,
                                                          color: Colors.black),
                                                    ),
                                                    DataCell(
                                                      StreamBuilder<
                                                              QuerySnapshot>(
                                                          stream: FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'Concerns')
                                                              .where(
                                                                  'classCode',
                                                                  isEqualTo:
                                                                      classCodes[
                                                                          i])
                                                              .snapshots(),
                                                          builder: (BuildContext
                                                                  context,
                                                              AsyncSnapshot<
                                                                      QuerySnapshot>
                                                                  snapshot1) {
                                                            if (snapshot1
                                                                .hasError) {
                                                              print('error');
                                                              return const Center(
                                                                  child: Text(
                                                                      'Error'));
                                                            }
                                                            if (snapshot1
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .waiting) {
                                                              return const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            50),
                                                                child: Center(
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                  color: Colors
                                                                      .black,
                                                                )),
                                                              );
                                                            }

                                                            final data1 =
                                                                snapshot1
                                                                    .requireData;
                                                            return NormalText(
                                                                label: data1
                                                                        .docs
                                                                        .isEmpty
                                                                    ? "0"
                                                                    : concern1,
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black);
                                                          }),
                                                    ),
                                                    DataCell(
                                                      StreamBuilder<
                                                              QuerySnapshot>(
                                                          stream: FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'Concerns')
                                                              .where(
                                                                  'classCode',
                                                                  isEqualTo:
                                                                      classCodes[
                                                                          i])
                                                              .snapshots(),
                                                          builder: (BuildContext
                                                                  context,
                                                              AsyncSnapshot<
                                                                      QuerySnapshot>
                                                                  snapshot1) {
                                                            if (snapshot1
                                                                .hasError) {
                                                              print('error');
                                                              return const Center(
                                                                  child: Text(
                                                                      'Error'));
                                                            }
                                                            if (snapshot1
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .waiting) {
                                                              return const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            50),
                                                                child: Center(
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                  color: Colors
                                                                      .black,
                                                                )),
                                                              );
                                                            }

                                                            final data1 =
                                                                snapshot1
                                                                    .requireData;
                                                            return NormalText(
                                                                label: data1
                                                                        .docs
                                                                        .isEmpty
                                                                    ? "0"
                                                                    : type,
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .black);
                                                          }),
                                                    ),
                                                  ])
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : const Scaffold(
            backgroundColor: greyAccent,
            body: Center(child: CircularProgressIndicator()));
  }
}
