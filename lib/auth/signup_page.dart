import 'package:consultation_system/constant/colors.dart';
import 'package:consultation_system/repositories/auth_repository.dart';
import 'package:consultation_system/services/navigation.dart';
import 'package:consultation_system/widgets/text_widget.dart';
import 'package:consultation_system/widgets/textform_field_widget.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _middleNameController = TextEditingController();

  final TextEditingController _surNameController = TextEditingController();

  final TextEditingController _contactNumberController =
      TextEditingController();

  final signupformKey = GlobalKey<FormState>();

  int _dropdownValue1 = 0;

  late String course = 'IT';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background1.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 0, bottom: 0),
            child: Center(
              child: Container(
                height: 550,
                width: 400,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[100]),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  child: SingleChildScrollView(
                    child: Form(
                      key: signupformKey,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            BoldText(
                                label: 'Signup', fontSize: 24, color: primary),
                            NormalText(
                                label: 'Create your account',
                                fontSize: 14,
                                color: Colors.black),
                            const SizedBox(
                              height: 20,
                            ),
                            TextformfieldWidget(
                              label: 'First name',
                              textFieldController: _firstNameController,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextformfieldWidget(
                              label: 'Middle Name',
                              textFieldController: _middleNameController,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextformfieldWidget(
                              label: 'Surname',
                              textFieldController: _surNameController,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextformfieldWidget(
                              label: 'Contact Number',
                              textFieldController: _contactNumberController,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Department'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: 400,
                                    decoration: BoxDecoration(
                                      color: greyColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 2, 20, 2),
                                      child: DropdownButton(
                                        underline: Container(
                                            color: Colors.transparent),
                                        iconEnabledColor: Colors.black,
                                        isExpanded: true,
                                        value: _dropdownValue1,
                                        items: [
                                          DropdownMenuItem(
                                            onTap: () {
                                              course = "Automotive";
                                            },
                                            value: 0,
                                            child: Center(
                                                child: Row(children: const [
                                              Text("Automotive",
                                                  style: TextStyle(
                                                    fontFamily: 'QRegular',
                                                    color: Colors.black,
                                                  ))
                                            ])),
                                          ),
                                          DropdownMenuItem(
                                            onTap: () {
                                              course = "Food Technology";
                                            },
                                            value: 1,
                                            child: Center(
                                                child: Row(children: const [
                                              Text("Food Technology",
                                                  style: TextStyle(
                                                    fontFamily: 'QRegular',
                                                    color: Colors.black,
                                                  ))
                                            ])),
                                          ),
                                          DropdownMenuItem(
                                            onTap: () {
                                              course = "Electronic Technology";
                                            },
                                            value: 2,
                                            child: Center(
                                                child: Row(children: const [
                                              Text("Electronic Technology",
                                                  style: TextStyle(
                                                    fontFamily: 'QRegular',
                                                    color: Colors.black,
                                                  ))
                                            ])),
                                          ),
                                          DropdownMenuItem(
                                            onTap: () {
                                              course =
                                                  "Entertainment and\nMultimedia Computing";
                                            },
                                            value: 3,
                                            child: Center(
                                                child: Row(children: const [
                                              Text(
                                                  "Entertainment and\nMultimedia Computing",
                                                  style: TextStyle(
                                                    fontFamily: 'QRegular',
                                                    color: Colors.black,
                                                  ))
                                            ])),
                                          ),
                                          DropdownMenuItem(
                                            onTap: () {
                                              course = "Information Technology";
                                            },
                                            value: 4,
                                            child: Center(
                                                child: Row(children: const [
                                              Text("Information Technology",
                                                  style: TextStyle(
                                                    fontFamily: 'QRegular',
                                                    color: Colors.black,
                                                  ))
                                            ])),
                                          ),
                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            _dropdownValue1 =
                                                int.parse(value.toString());
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextformfieldWidget(
                                prefixIcon: const Icon(Icons.email),
                                label: 'Email',
                                textFieldController: _emailController),
                            const SizedBox(
                              height: 20,
                            ),
                            TextformfieldWidget(
                                prefixIcon: const Icon(Icons.lock),
                                label: 'Password',
                                textFieldController: _passwordController),
                            const SizedBox(
                              height: 50,
                            ),
                            Center(
                              child: MaterialButton(
                                  minWidth: 300,
                                  color: primary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100)),
                                  onPressed: (() {
                                    if (signupformKey.currentState!
                                            .validate() &&
                                        _emailController.text
                                            .contains('buksu.edu.ph')) {
                                      AuthRepository().userSignUp(
                                          _firstNameController.text,
                                          _middleNameController.text,
                                          _surNameController.text,
                                          _contactNumberController.text,
                                          _emailController.text,
                                          _passwordController.text,
                                          '',
                                          course);
                                      Navigation(context).goToLoginPage();
                                    }

                                    // Navigator.of(context).push(MaterialPageRoute(
                                    //     builder: (context) => LoginPage()));
                                  }),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: NormalText(
                                        label: 'Signup',
                                        fontSize: 24,
                                        color: Colors.white),
                                  )),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                NormalText(
                                    label: 'Already have an account?',
                                    fontSize: 14,
                                    color: Colors.grey),
                                TextButton(
                                  onPressed: (() {
                                    // Navigator.of(context).push(MaterialPageRoute(
                                    //     builder: (context) => LoginPage()));
                                    Navigation(context).goToLoginPage();
                                  }),
                                  child: NormalText(
                                      label: 'Login now',
                                      fontSize: 16,
                                      color: brownAccent),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
