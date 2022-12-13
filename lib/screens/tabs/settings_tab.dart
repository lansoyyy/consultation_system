import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation_system/constant/colors.dart';
import 'package:consultation_system/widgets/text_widget.dart';
import 'package:consultation_system/widgets/textform_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../widgets/appabr_widget.dart';

class SettingsTab extends StatefulWidget {
  PageController page = PageController();

  SettingsTab({required this.page});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  final int _dropdownValue = 0;

  final firstName = TextEditingController();
  final middleName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final contactNumber = TextEditingController();

  late String? imgUrl = '';

  uploadToStorage() {
    InputElement input = FileUploadInputElement() as InputElement
      ..accept = 'image/*';
    FirebaseStorage fs = FirebaseStorage.instance;
    input.click();
    input.onChange.listen((event) {
      final file = input.files!.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) async {
        var snapshot = await fs.ref().child('newfile').putBlob(file);
        String downloadUrl = await snapshot.ref.getDownloadURL();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: NormalText(
                label: 'Uploaded Succesfully! Click update to see changes',
                fontSize: 14,
                color: Colors.white)));
        print(downloadUrl);
        setState(() {
          imgUrl = downloadUrl;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
        .collection('CONSULTATION-USERS')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    return Scaffold(
        appBar: appbarWidget(widget.page),
        backgroundColor: Colors.grey[200],
        body: Padding(
            padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
            child: StreamBuilder<DocumentSnapshot>(
                stream: userData,
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          BoldText(
                              label: 'Loading', fontSize: 24, color: primary),
                          const SizedBox(
                            height: 20,
                          )
                        ]));
                  } else if (snapshot.hasError) {
                    return SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          BoldText(
                              label: 'Something went wrong',
                              fontSize: 24,
                              color: primary),
                          const SizedBox(
                            height: 20,
                          )
                        ]));
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  dynamic data = snapshot.data;

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NormalText(
                            label: 'Profile', fontSize: 24, color: primary),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                  minRadius: 50,
                                  maxRadius: 50,
                                  backgroundColor: primary,
                                  backgroundImage:
                                      NetworkImage(data['profilePicture'])),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  //Image? fromPicker =
                                  //     await ImagePickerWeb.getImageAsWidget();
                                  uploadToStorage();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: primary,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 5, 20, 5),
                                    child: NormalText(
                                        label: 'Upload',
                                        fontSize: 15,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        NormalText(
                            label: 'EDIT YOUR PROFILE',
                            fontSize: 18,
                            color: Colors.grey),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                NormalText(
                                    label: 'First Name',
                                    fontSize: 14,
                                    color: primary),
                                const SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                    width: 150,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: TextformfieldWidget(
                                          textFieldController: firstName,
                                          label: data['first_name']),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                NormalText(
                                    label: 'Middle Name',
                                    fontSize: 14,
                                    color: primary),
                                const SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                    width: 150,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: TextformfieldWidget(
                                          textFieldController: middleName,
                                          label: data['middle_name']),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                NormalText(
                                    label: 'Surname',
                                    fontSize: 14,
                                    color: primary),
                                const SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                    width: 150,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: TextformfieldWidget(
                                          textFieldController: lastName,
                                          label: data['sur_name']),
                                    )),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // NormalText(
                        //     label: 'Surname', fontSize: 14, color: primary),
                        // const SizedBox(
                        //   height: 5,
                        // ),
                        // Container(
                        //   width: 150,
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     borderRadius: BorderRadius.circular(5),
                        //   ),
                        //   child: Padding(
                        //     padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
                        //     child: DropdownButton(
                        //       underline: Container(color: Colors.transparent),
                        //       iconEnabledColor: Colors.black,
                        //       isExpanded: true,
                        //       value: _dropdownValue,
                        //       items: [
                        //         DropdownMenuItem(
                        //           onTap: () {},
                        //           value: 0,
                        //           child: DropDownItem(label: 'Instructor'),
                        //         ),
                        //       ],
                        //       onChanged: (value) {
                        //         setState(() {
                        //           _dropdownValue = int.parse(value.toString());
                        //         });
                        //       },
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                        NormalText(
                            label: 'Email Address',
                            fontSize: 14,
                            color: primary),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                            width: 300,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: TextformfieldWidget(
                                  textFieldController: email,
                                  label: data['email']),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        NormalText(
                            label: 'Phone Number',
                            fontSize: 14,
                            color: primary),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                            width: 300,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: TextformfieldWidget(
                                  textFieldController: contactNumber,
                                  label: data['contact_number']),
                            )),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: (() {
                              print(imgUrl);
                              FirebaseFirestore.instance
                                  .collection('CONSULTATION-USERS')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .update({
                                'first_name': firstName.text == ''
                                    ? data['first_name']
                                    : firstName.text,
                                'middle_name': middleName.text == ''
                                    ? data['middle_name']
                                    : middleName.text,
                                'sur_name': lastName.text == ''
                                    ? data['sur_name']
                                    : lastName.text,
                                'email': email.text == ''
                                    ? data['email']
                                    : email.text,
                                'contact_number': contactNumber.text == ''
                                    ? data['contact_number']
                                    : contactNumber.text,
                                'profilePicture': imgUrl ??
                                    'https://cdn-icons-png.flaticon.com/512/727/727399.png'
                              });

                              firstName.clear();
                              middleName.clear();
                              lastName.clear();
                              email.clear();
                              contactNumber.clear();
                            }),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: primary,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(50, 5, 50, 5),
                                child: NormalText(
                                    label: 'Update',
                                    fontSize: 15,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  );
                })));
  }
}
