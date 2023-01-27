import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation_system/constant/colors.dart';
import 'package:consultation_system/services/add_message.dart';
import 'package:consultation_system/widgets/appabr_widget.dart';
import 'package:consultation_system/widgets/drop_down_button.dart';
import 'package:consultation_system/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart' show DateFormat, toBeginningOfSentenceCase;

class MessagesTab extends StatefulWidget {
  PageController page = PageController();

  MessagesTab({required this.page});
  @override
  State<MessagesTab> createState() => _MessagesTabState();
}

class _MessagesTabState extends State<MessagesTab> {
  @override
  void initState() {
    super.initState();
    getMyData();

    if (box.read('filter') == null) {
      box.write('filter', 'All');
    }
  }

  late String myName = '';

  getMyData() async {
    // Use provider
    var collection = FirebaseFirestore.instance
        .collection('CONSULTATION-USERS')
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid);

    var querySnapshot = await collection.get();
    if (mounted) {
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();
          myName = data['first_name'] + ' ' + data['sur_name'];
        }
      });
    }
  }

  final box = GetStorage();

  final _messageController = TextEditingController();

  data() {
    if (box.read('userId') != '') {
      return FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.uid)
          .doc()
          .collection('Messages')
          .orderBy('dateTime')
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.uid)
          .doc(box.read('userId'))
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

  final nameController = TextEditingController();

  int value4 = 0;
  late String concernFilter = 'Assignment';

  late String email = '';

  filterMessage() {
    if (box.read('filter') == 'All') {
      return FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.uid)
          // .where('name',
          //     isGreaterThanOrEqualTo: toBeginningOfSentenceCase(nameSearched))
          // .where('name',
          //     isLessThan: '${toBeginningOfSentenceCase(nameSearched)}z')
          .where('concern', isEqualTo: concernFilter)
          .snapshots();
    } else if (box.read('filter') == 'Read') {
      return FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.uid)
          .where('status', isEqualTo: 'Read')
          // .where('name',
          //     isGreaterThanOrEqualTo: toBeginningOfSentenceCase(nameSearched))
          // .where('name',
          //     isLessThan: '${toBeginningOfSentenceCase(nameSearched)}z')
          .where('concern', isEqualTo: concernFilter)
          .snapshots();
    } else if (nameSearched != '' &&
        box.read('filter') == '' &&
        concernFilter == '') {
      return FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.uid)
          // .where('status', isEqualTo: 'Read')
          .where('name',
              isGreaterThanOrEqualTo: toBeginningOfSentenceCase(nameSearched))
          .where('name',
              isLessThan: '${toBeginningOfSentenceCase(nameSearched)}z')
          // .where('concern', isEqualTo: concernFilter)
          .snapshots();
    } else if (box.read('filter') == 'Unread') {
      return FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.uid)
          .where('status', isEqualTo: 'Unread')
          // .where('name',
          //     isGreaterThanOrEqualTo: toBeginningOfSentenceCase(nameSearched))
          // .where('name',
          //     isLessThan: '${toBeginningOfSentenceCase(nameSearched)}z')
          .where('concern', isEqualTo: concernFilter)
          .snapshots();
    }
  }

  @override
  Widget build(BuildContext context) {
    print(box.read('filter'));
    return Scaffold(
      appBar: appbarWidget(widget.page),
      body: Container(
        color: greyAccent,
        child: Row(
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
                        color: Colors.white,
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
                            prefixIcon: IconButton(
                              onPressed: (() {
                                setState(() {
                                  box.write('filter', '');
                                  nameSearched = one;

                                  concernFilter = '';
                                });
                              }),
                              icon: Icon(Icons.search),
                            ),
                            suffixIcon: IconButton(
                              onPressed: (() {
                                setState(() {
                                  nameSearched = '';
                                });
                                nameController.clear();
                              }),
                              icon: Icon(Icons.close),
                            ),
                            hintText: 'Search Messages'),
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
                            color: Colors.white,
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
                                    setState(() {
                                      box.write('filter', 'All');
                                    });
                                  },
                                  value: 0,
                                  child: DropDownItem(label: 'All'),
                                ),
                                DropdownMenuItem(
                                  onTap: () {
                                    setState(() {
                                      box.write('filter', 'Read');
                                    });
                                  },
                                  value: 1,
                                  child: DropDownItem(label: 'Read'),
                                ),
                                DropdownMenuItem(
                                  onTap: () {
                                    setState(() {
                                      box.write('filter', 'Unread');
                                    });
                                  },
                                  value: 2,
                                  child: DropDownItem(label: 'Unread'),
                                ),
                              ],
                              onChanged: (value) {
                                print(box.read('filter'));
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
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Categ')
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
                              dynamic data9 = snapshot.requireData;

                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                width: 160,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 2, 20, 2),
                                  child: DropdownButton(
                                    underline:
                                        Container(color: Colors.transparent),
                                    iconEnabledColor: Colors.black,
                                    isExpanded: true,
                                    value: value4,
                                    items: [
                                      for (int i = 0; i < data9.size; i++)
                                        DropdownMenuItem(
                                          onTap: () {
                                            concernFilter =
                                                data9.docs[i]['name'];
                                          },
                                          value: i,
                                          child: DropDownItem(
                                              label: data9.docs[i]['name']),
                                        ),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        value4 = int.parse(value.toString());
                                      });
                                    },
                                  ),
                                ),
                              );
                            })
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
                                        box.write(
                                            'userId', data.docs[index].id);
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
                                            decoration: BoxDecoration(
                                              color: Colors.blue[700],
                                              borderRadius:
                                                  BorderRadius.circular(2.5),
                                            ),
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
                                              color: Colors.black),
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
            box.read('userId') != ''
                ? Expanded(
                    child: SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('Concerns')
                                    .where('name', isEqualTo: name)
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
                                                height: 30,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  color: primary,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: NormalText(
                                                        label: data3.docs[0]
                                                                ['type'] ??
                                                            '',
                                                        fontSize: 12,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              Expanded(child: SizedBox()),
                                              Row(
                                                children: [
                                                  Container(
                                                    height: 30,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue[700],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2.0),
                                                        child: NormalText(
                                                            label: concern,
                                                            fontSize: 12,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                  PopupMenuButton(
                                                      itemBuilder:
                                                          ((context) => [
                                                                PopupMenuItem(
                                                                  onTap:
                                                                      (() async {
                                                                    var collection = FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'Users')
                                                                        .where(
                                                                            'email',
                                                                            isEqualTo:
                                                                                email);

                                                                    var querySnapshot =
                                                                        await collection
                                                                            .get();
                                                                    if (mounted) {
                                                                      setState(
                                                                          () {
                                                                        for (var queryDocumentSnapshot
                                                                            in querySnapshot.docs) {
                                                                          Map<String, dynamic>
                                                                              data12 =
                                                                              queryDocumentSnapshot.data();

                                                                          FirebaseFirestore
                                                                              .instance
                                                                              .collection('Concerns')
                                                                              .doc(data12['id'])
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
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black),
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
                            Container(
                              child: Expanded(
                                child: SizedBox(
                                  child: Column(
                                    children: [
                                      StreamBuilder<QuerySnapshot>(
                                          stream: box.read('userId') == ''
                                              ? FirebaseFirestore.instance
                                                  .collection(FirebaseAuth
                                                      .instance
                                                      .currentUser!
                                                      .uid)
                                                  .doc()
                                                  .collection('Messages')
                                                  .orderBy('dateTime')
                                                  .snapshots()
                                              : FirebaseFirestore.instance
                                                  .collection(FirebaseAuth
                                                      .instance
                                                      .currentUser!
                                                      .uid)
                                                  .doc(box.read('userId'))
                                                  .collection('Messages')
                                                  .orderBy('dateTime')
                                                  .snapshots(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<QuerySnapshot>
                                                  snapshot) {
                                            if (snapshot.hasError) {
                                              print('error');
                                              return const Center(
                                                  child: Text('Error'));
                                            }
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              print('waiting');
                                              return const Padding(
                                                padding:
                                                    EdgeInsets.only(top: 50),
                                                child: Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                  color: Colors.black,
                                                )),
                                              );
                                            }

                                            final data = snapshot.requireData;
                                            return Expanded(
                                              child: SizedBox(
                                                child: ListView.builder(
                                                  itemCount:
                                                      snapshot.data?.size ?? 0,
                                                  itemBuilder:
                                                      ((context, index) {
                                                    return data.docs[index]
                                                                ['name'] ==
                                                            myName
                                                        ? ListTile(
                                                            trailing: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  CircleAvatar(
                                                                minRadius: 30,
                                                                maxRadius: 30,
                                                                child: BoldText(
                                                                    label: data.docs[index]
                                                                            [
                                                                            'name']
                                                                        [0],
                                                                    fontSize:
                                                                        22,
                                                                    color: Colors
                                                                        .white),
                                                                backgroundColor:
                                                                    blueAccent,
                                                              ),
                                                            ),
                                                            title: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          100),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .fromLTRB(
                                                                          20,
                                                                          10,
                                                                          20,
                                                                          10),
                                                                      child: NormalText(
                                                                          label: data.docs[index]
                                                                              [
                                                                              'message'],
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              primary),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  NormalText(
                                                                      label: data
                                                                              .docs[index]
                                                                          [
                                                                          'time'],
                                                                      fontSize:
                                                                          12,
                                                                      color:
                                                                          primary),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        : ListTile(
                                                            leading: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  CircleAvatar(
                                                                minRadius: 30,
                                                                maxRadius: 30,
                                                                child: BoldText(
                                                                    label: data.docs[index]
                                                                            [
                                                                            'name']
                                                                        [0],
                                                                    fontSize:
                                                                        22,
                                                                    color: Colors
                                                                        .white),
                                                                backgroundColor:
                                                                    blueAccent,
                                                              ),
                                                            ),
                                                            title: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          100),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .fromLTRB(
                                                                          20,
                                                                          10,
                                                                          20,
                                                                          10),
                                                                      child: NormalText(
                                                                          label: data.docs[index]
                                                                              [
                                                                              'message'],
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              primary),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  NormalText(
                                                                      label: data
                                                                              .docs[index]
                                                                          [
                                                                          'time'],
                                                                      fontSize:
                                                                          12,
                                                                      color:
                                                                          primary),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                  }),
                                                ),
                                              ),
                                            );
                                          }),
                                      StreamBuilder<DocumentSnapshot>(
                                          stream: userData,
                                          builder: (context,
                                              AsyncSnapshot<DocumentSnapshot>
                                                  snapshot) {
                                            if (!snapshot.hasData) {
                                              return const Center(
                                                  child: Text('Loading'));
                                            } else if (snapshot.hasError) {
                                              return const Center(
                                                  child: Text(
                                                      'Something went wrong'));
                                            } else if (snapshot
                                                    .connectionState ==
                                                ConnectionState.waiting) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }

                                            dynamic data = snapshot.data;
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 10, 10, 15),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10,
                                                            bottom: 10),
                                                    child: ListTile(
                                                      tileColor: Colors.white,
                                                      leading: SizedBox(
                                                          height: 100,
                                                          width: 500,
                                                          child: TextFormField(
                                                            controller:
                                                                _messageController,
                                                            textCapitalization:
                                                                TextCapitalization
                                                                    .words,
                                                            decoration:
                                                                const InputDecoration(
                                                                    fillColor:
                                                                        Colors
                                                                            .white),
                                                          )),
                                                      trailing: MaterialButton(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        color: Colors.blue[700],
                                                        child: NormalText(
                                                            label: 'SEND',
                                                            fontSize: 14,
                                                            color:
                                                                Colors.white),
                                                        onPressed: (() {
                                                          addMessage(
                                                              '',
                                                              data[
                                                                  'profilePicture'],
                                                              data['first_name'] +
                                                                  ' ' +
                                                                  data[
                                                                      'sur_name'],
                                                              data['email'],
                                                              '',
                                                              _messageController
                                                                  .text,
                                                              name,
                                                              '',
                                                              box.read(
                                                                  'userId'),
                                                              concern,
                                                              data['to'],
                                                              data['from']);
                                                          addMessage2(
                                                              '',
                                                              data[
                                                                  'profilePicture'],
                                                              data['first_name'] +
                                                                  ' ' +
                                                                  data[
                                                                      'sur_name'],
                                                              data['email'],
                                                              '',
                                                              _messageController
                                                                  .text,
                                                              name,
                                                              '',
                                                              box.read(
                                                                  'userId'),
                                                              concern);
                                                          _messageController
                                                              .clear();
                                                        }),
                                                      ),
                                                    )),
                                              ),
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
