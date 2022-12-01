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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                                      child: DropDownItem(label: '8:00AM'),
                                    ),
                                    DropdownMenuItem(
                                      onTap: () {},
                                      value: 1,
                                      child: DropDownItem(label: '9:00AM'),
                                    ),
                                    DropdownMenuItem(
                                      onTap: () {},
                                      value: 2,
                                      child: DropDownItem(label: '10:00AM'),
                                    ),
                                    DropdownMenuItem(
                                      onTap: () {},
                                      value: 3,
                                      child: DropDownItem(label: '11:00AM'),
                                    ),
                                    DropdownMenuItem(
                                      onTap: () {},
                                      value: 4,
                                      child: DropDownItem(label: '12:00AM'),
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
                                child: Center(
                                  child: NormalText(
                                      label: 'TO',
                                      fontSize: 14,
                                      color: Colors.grey),
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
                                      child: DropDownItem(label: '1:00PM'),
                                    ),
                                    DropdownMenuItem(
                                      onTap: () {},
                                      value: 1,
                                      child: DropDownItem(label: '2:00PM'),
                                    ),
                                    DropdownMenuItem(
                                      onTap: () {},
                                      value: 2,
                                      child: DropDownItem(label: '3:00PM'),
                                    ),
                                    DropdownMenuItem(
                                      onTap: () {},
                                      value: 3,
                                      child: DropDownItem(label: '4:00PM'),
                                    ),
                                    DropdownMenuItem(
                                      onTap: () {},
                                      value: 4,
                                      child: DropDownItem(label: '5:00PM'),
                                    ),
                                    DropdownMenuItem(
                                      onTap: () {},
                                      value: 5,
                                      child: DropDownItem(label: '6:00PM'),
                                    ),
                                    DropdownMenuItem(
                                      onTap: () {},
                                      value: 6,
                                      child: DropDownItem(label: '7:00PM'),
                                    ),
                                    DropdownMenuItem(
                                      onTap: () {},
                                      value: 7,
                                      child: DropDownItem(label: '8:00PM'),
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
                          label: "Set your activity status",
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
                                child: DropDownItem(label: 'Active'),
                              ),
                              DropdownMenuItem(
                                onTap: () {},
                                value: 1,
                                child: DropDownItem(label: 'Inactive'),
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
                              "You can make your notification status active/inactive",
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
