import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultation_system/constant/colors.dart';
import 'package:consultation_system/services/navigation.dart';
import 'package:consultation_system/widgets/notification_widget.dart';
import 'package:consultation_system/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

PreferredSizeWidget appbarWidget(PageController page) {
  final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
      .collection('CONSULTATION-USERS')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  final box = GetStorage();

  return AppBar(
    actions: [
      const SizedBox(
        width: 20,
      ),
      Center(
          child: BoldText(
              label: 'BukSU Consultation', fontSize: 24, color: primary)),
      const Expanded(
        child: SizedBox(
          width: 50,
        ),
      ),
      // const NotificationWidget(),
      const SizedBox(
        width: 20,
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

            List notifs = data['notif'];

            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Badge(
                  badgeContent: NormalText(
                      label: notifs.length.toString(),
                      fontSize: 12,
                      color: Colors.white),
                  child: IconButton(
                    onPressed: (() {
                      showDialog(
                          context: context,
                          builder: ((context) {
                            return Dialog(
                              child: Container(
                                color: greyAccent,
                                height: 400,
                                width: 400,
                                child: ListView.builder(
                                    itemCount: notifs.reversed.length,
                                    itemBuilder: ((context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 5, 20, 5),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: ListTile(
                                            onTap: (() async {
                                              box.write('userId',
                                                  notifs[index]['id']);
                                              Navigator.pop(context);
                                              page.jumpToPage(1);
                                              await FirebaseFirestore.instance
                                                  .collection(
                                                      'CONSULTATION-USERS')
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .update({
                                                'notif': FieldValue.arrayRemove(
                                                    [notifs[index]]),
                                              });
                                            }),
                                            title: Text(
                                              notifs[index]['message'],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.openSans(
                                                textStyle: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            subtitle: Text(
                                              notifs[index]['name'],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.openSans(
                                                textStyle: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            trailing: Text(
                                              notifs[index]['time'],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.openSans(
                                                textStyle: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black),
                                              ),
                                            ),
                                            tileColor: Colors.white,
                                          ),
                                        ),
                                      );
                                    })),
                              ),
                            );
                          }));
                    }),
                    icon: const Icon(
                      Icons.notifications,
                      color: primary,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                CircleAvatar(
                  minRadius: 20,
                  maxRadius: 20,
                  backgroundImage: NetworkImage(data['profilePicture']),
                ),
              ],
            );
          }),
      const SizedBox(
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
      const SizedBox(
        width: 10,
      ),
      PopupMenuButton(
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.black,
        ),
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              onTap: (() {
                page.jumpToPage(5);
              }),
              child: ListTile(
                leading: const Icon(Icons.edit),
                title: NormalText(
                    label: 'Edit Profile', fontSize: 12, color: Colors.black),
              ),
            ),
            PopupMenuItem(
              onTap: (() async {
                await FirebaseAuth.instance.signOut();

                Navigation(context).goToLoginPage();
                Navigation(context).goToLoginPage();
              }),
              child: ListTile(
                leading: const Icon(Icons.logout),
                title: NormalText(
                    label: 'Logout', fontSize: 12, color: Colors.black),
              ),
            ),
          ];
        },
      ),
      const SizedBox(
        width: 20,
      ),
    ],
    backgroundColor: Colors.grey[100],
  );
}
