import 'package:consultation_system/constant/colors.dart';
import 'package:consultation_system/widgets/drop_down_button.dart';
import 'package:consultation_system/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class NotfiTab extends StatefulWidget {
  const NotfiTab({super.key});

  @override
  State<NotfiTab> createState() => _NotfiTabState();
}

class _NotfiTabState extends State<NotfiTab> {
  int _dropdownValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BoldText(label: 'Notifications', fontSize: 28, color: primary),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 300,
                  width: 300,
                  color: greyAccent,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BoldText(
                            label: 'Pause Notifications',
                            fontSize: 16,
                            color: Colors.grey),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                            onPressed: (() {}),
                            child: NormalText(
                                label: 'For 30 minutes',
                                fontSize: 12,
                                color: primary)),
                        TextButton(
                            onPressed: (() {}),
                            child: NormalText(
                                label: 'For 1 hour',
                                fontSize: 12,
                                color: primary)),
                        TextButton(
                            onPressed: (() {}),
                            child: NormalText(
                                label: 'For 2 hour',
                                fontSize: 12,
                                color: primary)),
                        TextButton(
                            onPressed: (() {}),
                            child: NormalText(
                                label: 'Until tommorow',
                                fontSize: 12,
                                color: primary)),
                        const Divider(
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
                const VerticalDivider(
                  color: Colors.grey,
                  width: 5,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BoldText(
                          label: 'Schedule a Notification',
                          fontSize: 18,
                          color: Colors.black),
                      NormalText(
                          label:
                              "You'all only receive notification in the hours you choose. Outside of those times, notifications will be paused.",
                          fontSize: 12,
                          color: Colors.grey),
                      const SizedBox(
                        height: 30,
                      ),
                      NormalText(
                          label: "Allow notification:",
                          fontSize: 12,
                          color: Colors.grey),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 2, 20, 2),
                                child: DropdownButton(
                                  underline:
                                      Container(color: Colors.transparent),
                                  iconEnabledColor: Colors.black,
                                  isExpanded: true,
                                  value: _dropdownValue,
                                  items: [
                                    DropdownMenuItem(
                                      onTap: () {},
                                      value: 0,
                                      child: DropDownItem(label: 'Everyday'),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _dropdownValue =
                                          int.parse(value.toString());
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Container(
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 2, 20, 2),
                                child: DropdownButton(
                                  underline:
                                      Container(color: Colors.transparent),
                                  iconEnabledColor: Colors.black,
                                  isExpanded: true,
                                  value: _dropdownValue,
                                  items: [
                                    DropdownMenuItem(
                                      onTap: () {},
                                      value: 0,
                                      child: DropDownItem(label: '12:00 AM'),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _dropdownValue =
                                          int.parse(value.toString());
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Container(
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 2, 20, 2),
                                child: DropdownButton(
                                  underline:
                                      Container(color: Colors.transparent),
                                  iconEnabledColor: Colors.black,
                                  isExpanded: true,
                                  value: _dropdownValue,
                                  items: [
                                    DropdownMenuItem(
                                      onTap: () {},
                                      value: 0,
                                      child: DropDownItem(label: 'Midnight'),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      _dropdownValue =
                                          int.parse(value.toString());
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      NormalText(
                          label:
                              "Set a default time for reminder notifications:",
                          fontSize: 12,
                          color: Colors.grey),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
                          child: DropdownButton(
                            underline: Container(color: Colors.transparent),
                            iconEnabledColor: Colors.black,
                            isExpanded: true,
                            value: _dropdownValue,
                            items: [
                              DropdownMenuItem(
                                onTap: () {},
                                value: 0,
                                child: DropDownItem(label: 'Midnight'),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _dropdownValue = int.parse(value.toString());
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      NormalText(
                          label:
                              "Reminders you set for a specific day (ex. tommorow) will be sent at the time you select.",
                          fontSize: 12,
                          color: Colors.grey),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
