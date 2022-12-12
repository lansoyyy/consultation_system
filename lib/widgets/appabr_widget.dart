import 'package:consultation_system/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget appbarWidget(PageController page) {
  return AppBar(
    actions: [
      CircleAvatar(
        minRadius: 20,
        maxRadius: 20,
      ),
      SizedBox(
        width: 10,
      ),
      Center(
          child: BoldText(
              label: 'Olana, Lance', fontSize: 18, color: Colors.black)),
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
              onTap: (() {
                FirebaseAuth.instance.signOut();
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
