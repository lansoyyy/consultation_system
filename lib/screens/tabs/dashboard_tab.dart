import 'package:consultation_system/constant/colors.dart';
import 'package:consultation_system/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    String cdate3 = DateFormat("MMMM, EEEE, yyyy").format(DateTime.now());

    return Container(
      padding: const EdgeInsets.only(left: 20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          NormalText(label: cdate3.toString(), fontSize: 24, color: primary),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 20, top: 10),
                height: 100,
                width: 250,
                color: greyAccent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NormalText(
                        label: 'MESSAGES TODAY',
                        fontSize: 12,
                        color: Colors.grey),
                    const SizedBox(
                      height: 20,
                    ),
                    BoldText(label: '23', fontSize: 32, color: primary),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, top: 10),
                height: 100,
                width: 250,
                color: greyAccent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NormalText(
                        label: 'UNREAD MESSAGES TODAY',
                        fontSize: 12,
                        color: Colors.grey),
                    const SizedBox(
                      height: 20,
                    ),
                    BoldText(label: '23', fontSize: 32, color: primary),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, top: 10),
                height: 100,
                width: 250,
                color: greyAccent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NormalText(
                        label: 'REPLIED MESSAGES TODAY',
                        fontSize: 12,
                        color: Colors.grey),
                    const SizedBox(
                      height: 20,
                    ),
                    BoldText(label: '23', fontSize: 32, color: primary),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Container(
                padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                height: 400,
                width: 600,
                color: greyAccent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NormalText(
                        label: 'TICKETS FOR TODAY',
                        fontSize: 12,
                        color: Colors.grey),
                    const SizedBox(
                      height: 10,
                    ),
                    BoldText(
                        label: 'CONCERNS', fontSize: 12, color: Colors.grey),
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      leading: NormalText(
                          label: 'Grades', fontSize: 12, color: primary),
                      trailing:
                          BoldText(label: '2', fontSize: 12, color: primary),
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    ListTile(
                      leading: NormalText(
                          label: 'Instructional Materials',
                          fontSize: 12,
                          color: primary),
                      trailing:
                          BoldText(label: '2', fontSize: 12, color: primary),
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    ListTile(
                      leading: NormalText(
                          label: 'Requirements/Projects',
                          fontSize: 12,
                          color: primary),
                      trailing:
                          BoldText(label: '2', fontSize: 12, color: primary),
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    ListTile(
                      leading: NormalText(
                          label: 'Attendance', fontSize: 12, color: primary),
                      trailing:
                          BoldText(label: '2', fontSize: 12, color: primary),
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    ListTile(
                      leading: NormalText(
                          label: 'Other concerns',
                          fontSize: 12,
                          color: primary),
                      trailing:
                          BoldText(label: '2', fontSize: 12, color: primary),
                    ),
                    const Divider(
                      color: Colors.white,
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
