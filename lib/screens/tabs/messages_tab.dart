import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation_system/constant/colors.dart';
import 'package:consultation_system/services/add_message.dart';
import 'package:consultation_system/widgets/appabr_widget.dart';
import 'package:consultation_system/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
                    height: 20,
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection(FirebaseAuth.instance.currentUser!.uid)
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
                                  onTap: (() {
                                    setState(() {
                                      id = data.docs[index].id;
                                      name = data.docs[index]['name'];
                                      concern = data.docs[index]['concern'];
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
                                      backgroundImage: NetworkImage(
                                          data.docs[index]['profilePicture']),
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
                                          color: greenAccent,
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
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
                    Container(
                        width: double.infinity,
                        height: 50,
                        decoration: const BoxDecoration(),
                        child: Center(
                          child: ListTile(
                            leading: CircleAvatar(
                              minRadius: 50,
                              maxRadius: 50,
                              backgroundImage: NetworkImage(profilePicture),
                              backgroundColor: Colors.grey,
                            ),
                            title: BoldText(
                                label: name, fontSize: 18, color: Colors.grey),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(right: 300),
                              child: Container(
                                height: 20,
                                width: 50,
                                color: greenAccent,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: NormalText(
                                        label: concern,
                                        fontSize: 12,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )),
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
                                                backgroundImage: NetworkImage(
                                                    data.docs[index]
                                                        ['profilePicture']),
                                                backgroundColor: blueAccent,
                                              ),
                                            ),
                                            title: Container(
                                              decoration: BoxDecoration(
                                                color: primary,
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
                                                    color: Colors.white),
                                              ),
                                            ),
                                            subtitle: NormalText(
                                                label: data.docs[index]
                                                        ['name'] +
                                                    "    ${data.docs[index]['course']}  ${data.docs[index]['yearLevel']}",
                                                fontSize: 12,
                                                color: Colors.grey),
                                            trailing: NormalText(
                                                label: data.docs[index]['time'],
                                                fontSize: 14,
                                                color: Colors.grey),
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
