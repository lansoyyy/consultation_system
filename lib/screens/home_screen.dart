import 'package:consultation_system/screens/tabs/analytics_tab.dart';
import 'package:consultation_system/screens/tabs/dashboard_tab.dart';
import 'package:consultation_system/screens/tabs/feedback_tab.dart';
import 'package:consultation_system/screens/tabs/messages_tab.dart';
import 'package:consultation_system/screens/tabs/notif_tab.dart';
import 'package:consultation_system/screens/tabs/reports_tab.dart';
import 'package:consultation_system/screens/tabs/settings_tab.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/colors.dart';
import '../widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController page = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 632,
            color: primary,
            child: SideMenu(
              controller: page,
              style: SideMenuStyle(
                  unselectedTitleTextStyle:
                      const TextStyle(color: Colors.white),

                  // showTooltip: false,
                  displayMode: SideMenuDisplayMode.auto,
                  hoverColor: blueAccent,
                  selectedColor: Colors.black38,
                  selectedTitleTextStyle:
                      GoogleFonts.openSans(color: Colors.white),
                  selectedIconColor: Colors.white,
                  unselectedIconColor: Colors.white
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.all(Radius.circular(10)),
                  // ),
                  // backgroundColor: Colors.blueGrey[700]
                  ),
              title: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    border: Border(
                        bottom: BorderSide(width: 1, color: greyAccent))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        'assets/images/bsu.png',
                        width: 33,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      BoldText(
                        label: 'STUDCON',
                        fontSize: 24,
                        color: blueAccent,
                      ),
                    ],
                  ),
                ),
              ),
              items: [
                SideMenuItem(
                  priority: 0,
                  title: 'Dashboard',
                  onTap: () {
                    page.jumpToPage(0);
                  },
                  icon: const Icon(Icons.home),
                  tooltipContent: "This is a tooltip for Dashboard item",
                ),
                SideMenuItem(
                  priority: 1,
                  title: 'Messages',
                  onTap: () {
                    page.jumpToPage(1);
                  },
                  icon: const Icon(Icons.message),
                ),
                SideMenuItem(
                  priority: 2,
                  title: 'Reports',
                  onTap: () {
                    page.jumpToPage(2);
                  },
                  icon: const Icon(Icons.report_problem_rounded),
                ),
                SideMenuItem(
                  priority: 3,
                  title: 'Analytics',
                  onTap: () {
                    page.jumpToPage(3);
                  },
                  icon: const Icon(Icons.analytics),
                ),
                SideMenuItem(
                  priority: 4,
                  title: 'Feedback',
                  onTap: () {
                    page.jumpToPage(4);
                  },
                  icon: const Icon(Icons.feedback),
                ),
                SideMenuItem(
                  onTap: () {
                    page.jumpToPage(5);
                  },
                  priority: 5,
                  title: 'Notification',
                  icon: const Icon(Icons.notifications),
                ),
                SideMenuItem(
                  onTap: () {
                    page.jumpToPage(6);
                  },
                  priority: 6,
                  title: 'Settings',
                  icon: const Icon(Icons.settings),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: page,
              children: [
                DashboardTab(
                  page: page,
                ),
                MessagesTab(
                  page: page,
                ),
                ReportTab(
                  page: page,
                ),
                AnalyticsTab(
                  page: page,
                ),
                FeedbackTab(
                  page: page,
                ),
                NotfiTab(
                  page: page,
                ),
                SettingsTab(
                  page: page,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
