import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation_system/constant/uid.dart';
import 'package:consultation_system/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget appbarWidget(PageController page) {
  final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
      .collection('CONSULTATION-USERS')
      .doc(FirebaseAuthToken().uid)
      .snapshots();

  return AppBar(
    actions: [
      StreamBuilder<DocumentSnapshot>(
          stream: userData,
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: Text('Loading'));
            } else if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            dynamic data = snapshot.data;
            return CircleAvatar(
              minRadius: 20,
              maxRadius: 20,
              backgroundImage: NetworkImage(data['profilePicture']),
            );
          }),
      SizedBox(
        width: 10,
      ),
      StreamBuilder<DocumentSnapshot>(
          stream: userData,
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: Text('Loading'));
            } else if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            dynamic data = snapshot.data;
            return Center(
                child: BoldText(
                    label: '${data['sur_name']}, ${data['first_name']}',
                    fontSize: 18,
                    color: Colors.black));
          }),
      SizedBox(
        width: 10,
      ),
      PopupMenuButton(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black,
        ),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              onTap: (() {
                page.jumpToPage(6);
              }),
              child: ListTile(
                leading: Icon(Icons.edit),
                title: NormalText(
                    label: 'Edit Profile', fontSize: 12, color: Colors.black),
              ),
            ),
            PopupMenuItem(
              onTap: (() async {
                await FirebaseAuth.instance.signOut();

                Navigator.pushReplacementNamed(context, '/loginpage');
                Navigator.pushReplacementNamed(context, '/loginpage');
              }),
              child: ListTile(
                leading: Icon(Icons.logout),
                title: NormalText(
                    label: 'Logout', fontSize: 12, color: Colors.black),
              ),
            ),
          ];
        },
      ),
      SizedBox(
        width: 20,
      ),
    ],
    backgroundColor: Colors.grey[100],
  );
}
