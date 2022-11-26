import 'package:consultation_system/constant/colors.dart';
import 'package:consultation_system/widgets/drop_down_button.dart';
import 'package:consultation_system/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  int _dropdownValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Padding(
          padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BoldText(label: 'Profile', fontSize: 24, color: primary),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        minRadius: 50,
                        maxRadius: 50,
                        backgroundColor: primary,
                        backgroundImage: NetworkImage(
                            'https://cdn-icons-png.flaticon.com/512/3899/3899618.png'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          child: NormalText(
                              label: 'Upload',
                              fontSize: 15,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                NormalText(
                    label: 'EDIT YOUR PROFILE',
                    fontSize: 18,
                    color: Colors.grey),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NormalText(
                            label: 'First Name', fontSize: 14, color: primary),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                            width: 150,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: TextFormField(),
                            )),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NormalText(
                            label: 'Middle Name', fontSize: 14, color: primary),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                            width: 150,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: TextFormField(),
                            )),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NormalText(
                            label: 'Surname', fontSize: 14, color: primary),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                            width: 150,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: TextFormField(),
                            )),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                NormalText(label: 'Surname', fontSize: 14, color: primary),
                const SizedBox(
                  height: 5,
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
                          child: DropDownItem(label: 'Instructor'),
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
                  height: 20,
                ),
                NormalText(
                    label: 'Email Address', fontSize: 14, color: primary),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                    width: 300,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(),
                    )),
                const SizedBox(
                  height: 20,
                ),
                NormalText(label: 'Phone Number', fontSize: 14, color: primary),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                    width: 300,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: TextFormField(),
                    )),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ));
  }
}
