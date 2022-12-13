import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation_system/constant/colors.dart';
import 'package:consultation_system/services/add_message.dart';
import 'package:consultation_system/widgets/appabr_widget.dart';
import 'package:consultation_system/widgets/drop_down_button.dart';
import 'package:consultation_system/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat, toBeginningOfSentenceCase;

class MessagesTab extends StatefulWidget {
  PageController page = PageController();

  MessagesTab({required this.page});
  @override
  State<MessagesTab> createState() => _MessagesTabState();
}

class _MessagesTabState extends State<MessagesTab> {
  final _messageController = TextEditingController();

  late String id = '';

  data() {
    if (id != '') {
      return FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.uid)
          .doc()
          .collection('Messages')
          .orderBy('dateTime')
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.uid)
          .doc(id)
          .collection('Messages')
          .orderBy('dateTime')
          .snapshots();
    }
  }

  late String profilePicture = '';
  late String name = '';
  late String concern = '';

  final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
      .collection('CONSULTATION-USERS')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  late String nameSearched = '';
  late String one = '';

  int value3 = 0;
  late String status = 'Active';

  late String filterMsg = 'All';

  final nameController = TextEditingController();

  int value4 = 0;
  late String concernFilter = 'Grades';

  late String email = '';

  filterMessage() {
    if (filterMsg == 'All') {
      return FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.uid)
          .where('name',
              isGreaterThanOrEqualTo: toBeginningOfSentenceCase(nameSearched))
          .where('name',
              isLessThan: '${toBeginningOfSentenceCase(nameSearched)}z')
          .where('concern', isEqualTo: concernFilter)
          .snapshots();
    } else if (filterMsg == 'Read') {
      return FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.uid)
          .where('status', isEqualTo: 'Read')
          .where('name',
              isGreaterThanOrEqualTo: toBeginningOfSentenceCase(nameSearched))
          .where('name',
              isLessThan: '${toBeginningOfSentenceCase(nameSearched)}z')
          .where('concern', isEqualTo: concernFilter)
          .snapshots();
    } else if (filterMsg == 'Unread') {
      return FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.uid)
          .where('status', isEqualTo: 'Unread')
          .where('name',
              isGreaterThanOrEqualTo: toBeginningOfSentenceCase(nameSearched))
          .where('name',
              isLessThan: '${toBeginningOfSentenceCase(nameSearched)}z')
          .where('concern', isEqualTo: concernFilter)
          .snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(widget.page),
      body: Row(
        children: [
          SizedBox(
            width: 400,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NormalText(label: 'Messages', fontSize: 28, color: primary),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 350,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    decoration: BoxDecoration(
                      color: greyColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                      ),
                    ),
                    child: TextFormField(
                      controller: nameController,
                      onSaved: (newValue) {
                        setState(() {
                          nameSearched = one;
                        });
                      },
                      onChanged: ((value) {
                        one = value;
                      }),
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: (() {
                              setState(() {
                                nameSearched = one;
                              });
                            }),
                            icon: Icon(Icons.search),
                          ),
                          prefixIcon: IconButton(
                            onPressed: (() {
                              setState(() {
                                nameSearched = '';
                              });
                              nameController.clear();
                            }),
                            icon: Icon(Icons.close),
                          ),
                          hintText: 'Search'),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 150,
                        decoration: BoxDecoration(
                          color: greyColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                          child: DropdownButton(
                            underline: Container(color: Colors.transparent),
                            iconEnabledColor: Colors.black,
                            isExpanded: true,
                            value: value3,
                            items: [
                              DropdownMenuItem(
                                onTap: () {
                                  filterMsg = 'All';
                                },
                                value: 0,
                                child: DropDownItem(label: 'All'),
                              ),
                              DropdownMenuItem(
                                onTap: () {
                                  filterMsg = 'Read';
                                },
                                value: 1,
                                child: DropDownItem(label: 'Read'),
                              ),
                              DropdownMenuItem(
                                onTap: () {
                                  filterMsg = 'Unread';
                                },
                                value: 2,
                                child: DropDownItem(label: 'Unread'),
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
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 190,
                        decoration: BoxDecoration(
                          color: greyColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                          child: DropdownButton(
                            underline: Container(color: Colors.transparent),
                            iconEnabledColor: Colors.black,
                            isExpanded: true,
                            value: value4,
                            items: [
                              DropdownMenuItem(
                                onTap: () {
                                  concernFilter = 'Grades';
                                },
                                value: 0,
                                child: DropDownItem(label: 'Grades'),
                              ),
                              DropdownMenuItem(
                                onTap: () {
                                  concernFilter = 'Requirements';
                                },
                                value: 1,
                                child: DropDownItem(label: 'Requirements'),
                              ),
                              DropdownMenuItem(
                                onTap: () {
                                  concernFilter = 'Attendance';
                                },
                                value: 2,
                                child: DropDownItem(label: 'Attendance'),
                              ),
                              DropdownMenuItem(
                                onTap: () {
                                  concernFilter = 'Others';
                                },
                                value: 3,
                                child: DropDownItem(label: 'Others'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                value4 = int.parse(value.toString());
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: filterMessage(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          print(snapshot.error);
                          return const Center(child: Text('Error'));
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
                              itemCount: snapshot.data?.size ?? 0,
                              itemBuilder: ((context, index) {
                                return ListTile(
                                  onTap: (() {
                                    setState(() {
                                      id = data.docs[index].id;
                                      name = data.docs[index]['name'];
                                      concern = data.docs[index]['concern'];
                                      email = data.docs[index]['email'];
                                    });

                                    FirebaseFirestore.instance
                                        .collection(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .doc(data.docs[index].id)
                                        .update({
                                      'status': 'Read',
                                    });

                                    FirebaseFirestore.instance
                                        .collection(data.docs[index].id)
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .update({
                                      'status': 'Read',
                                    });
                                  }),
                                  leading: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5),
                                    child: CircleAvatar(
                                      minRadius: 40,
                                      maxRadius: 40,
                                      child: BoldText(
                                          label: data.docs[index]['name'][0],
                                          fontSize: 22,
                                          color: Colors.white),
                                      backgroundColor: blueAccent,
                                    ),
                                  ),
                                  title: BoldText(
                                      label: data.docs[index]['name'],
                                      fontSize: 18,
                                      color: Colors.black45),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 50, top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          color: brownAccent,
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5, 2, 5, 2),
                                              child: NormalText(
                                                  label: data.docs[index]
                                                      ['concern'],
                                                  fontSize: 12,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        NormalText(
                                            label: data.docs[index]['time'],
                                            fontSize: 12,
                                            color: Colors.grey),
                                      ],
                                    ),
                                  ),
                                  trailing: IconButton(
                                    onPressed: (() {
                                      FirebaseFirestore.instance
                                          .collection(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .doc(data.docs[index].id)
                                          .delete();
                                    }),
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
          ),
          const VerticalDivider(),
          Expanded(
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Concerns')
                            .where('email', isEqualTo: email)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            print(snapshot.error);
                            return const Center(child: Text('Error'));
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

                          final data3 = snapshot.requireData;

                          print(email);

                          return Container(
                              width: double.infinity,
                              height: 50,
                              decoration: const BoxDecoration(),
                              child: Center(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    minRadius: 50,
                                    maxRadius: 50,
                                    child: BoldText(
                                        label: name[0],
                                        fontSize: 22,
                                        color: Colors.white),
                                    backgroundColor: blueAccent,
                                  ),
                                  title: BoldText(
                                      label: name,
                                      fontSize: 18,
                                      color: primary),
                                  subtitle: Row(
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 100,
                                        color: primary,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: NormalText(
                                                label:
                                                    data3.docs[0]['type'] ?? '',
                                                fontSize: 12,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      Expanded(child: SizedBox()),
                                      Row(
                                        children: [
                                          Container(
                                            height: 20,
                                            width: 100,
                                            color: brownAccent,
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: NormalText(
                                                    label: concern,
                                                    fontSize: 12,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          PopupMenuButton(
                                              itemBuilder: ((context) => [
                                                    PopupMenuItem(
                                                      onTap: (() async {
                                                        var collection =
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'Users')
                                                                .where('email',
                                                                    isEqualTo:
                                                                        email);

                                                        var querySnapshot =
                                                            await collection
                                                                .get();
                                                        if (mounted) {
                                                          setState(() {
                                                            for (var queryDocumentSnapshot
                                                                in querySnapshot
                                                                    .docs) {
                                                              Map<String,
                                                                      dynamic>
                                                                  data12 =
                                                                  queryDocumentSnapshot
                                                                      .data();

                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'Concerns')
                                                                  .doc(data12[
                                                                      'id'])
                                                                  .update({
                                                                'type':
                                                                    'Solved',
                                                              });
                                                            }
                                                          });
                                                        }
                                                      }),
                                                      child: NormalText(
                                                          label:
                                                              'Mark as Solved',
                                                          fontSize: 12,
                                                          color: Colors.black),
                                                    ),
                                                  ])),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    const Divider(),
                    Expanded(
                      child: SizedBox(
                        child: Column(
                          children: [
                            StreamBuilder<QuerySnapshot>(
                                stream: id == ''
                                    ? FirebaseFirestore.instance
                                        .collection(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .doc()
                                        .collection('Messages')
                                        .orderBy('dateTime')
                                        .snapshots()
                                    : FirebaseFirestore.instance
                                        .collection(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .doc(id)
                                        .collection('Messages')
                                        .orderBy('dateTime')
                                        .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    print('error');
                                    return const Center(child: Text('Error'));
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
                                        itemCount: snapshot.data?.size ?? 0,
                                        itemBuilder: ((context, index) {
                                          return ListTile(
                                            leading: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: CircleAvatar(
                                                minRadius: 30,
                                                maxRadius: 30,
                                                child: BoldText(
                                                    label: data.docs[index]
                                                        ['name'][0],
                                                    fontSize: 22,
                                                    color: Colors.white),
                                                backgroundColor: blueAccent,
                                              ),
                                            ),
                                            title: Container(
                                              decoration: BoxDecoration(
                                                color: greyAccent,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20, 10, 20, 10),
                                                child: NormalText(
                                                    label: data.docs[index]
                                                        ['message'],
                                                    fontSize: 14,
                                                    color: primary),
                                              ),
                                            ),
                                            subtitle: NormalText(
                                                label: data.docs[index]
                                                        ['name'] +
                                                    "   -    ${data.docs[index]['course']}  -  ${data.docs[index]['yearLevel']}",
                                                fontSize: 10,
                                                color: primary),
                                            trailing: NormalText(
                                                label: data.docs[index]['time'],
                                                fontSize: 14,
                                                color: primary),
                                          );
                                        }),
                                      ),
                                    ),
                                  );
                                }),
                            StreamBuilder<DocumentSnapshot>(
                                stream: userData,
                                builder: (context,
                                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Center(child: Text('Loading'));
                                  } else if (snapshot.hasError) {
                                    return const Center(
                                        child: Text('Something went wrong'));
                                  } else if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }

                                  dynamic data = snapshot.data;
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: ListTile(
                                      tileColor: Colors.white,
                                      leading: SizedBox(
                                          height: 100,
                                          width: 500,
                                          child: TextFormField(
                                            controller: _messageController,
                                            textCapitalization:
                                                TextCapitalization.words,
                                            decoration: const InputDecoration(
                                                fillColor: Colors.white),
                                          )),
                                      trailing: IconButton(
                                          onPressed: (() {
                                            addMessage(
                                                '',
                                                data['profilePicture'],
                                                data['first_name'] +
                                                    ' ' +
                                                    data['sur_name'],
                                                data['email'],
                                                '',
                                                _messageController.text,
                                                name,
                                                '',
                                                id,
                                                concern,
                                                data['to'],
                                                data['from']);
                                            addMessage2(
                                                '',
                                                data['profilePicture'],
                                                data['first_name'] +
                                                    ' ' +
                                                    data['sur_name'],
                                                data['email'],
                                                '',
                                                _messageController.text,
                                                name,
                                                '',
                                                id,
                                                concern);
                                            _messageController.clear();
                                          }),
                                          icon: const Icon(Icons.send,
                                              color: secondary)),
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
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
