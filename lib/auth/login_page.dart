import 'package:consultation_system/constant/colors.dart';
import 'package:consultation_system/repositories/auth_repository.dart';
import 'package:consultation_system/services/navigation.dart';
import 'package:consultation_system/widgets/text_widget.dart';
import 'package:consultation_system/widgets/textform_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/error_dialogue_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final loginformKey = GlobalKey<FormState>();
  bool secureText = true;
  @override
  Widget build(BuildContext context) {
    validateLogin(dynamic e) {
      showDialog(
        context: context,
        builder: ((context) {
          return ErrorDialog(
              caption: e.code,
              onPressed: () {
                Navigator.of(context).pop();
              });
        }),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background1.jpeg'),
                  fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 80, bottom: 50),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: 550,
                width: 400,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[100]),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  child: Form(
                    key: loginformKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        BoldText(label: 'Login', fontSize: 24, color: primary),
                        NormalText(
                            label: 'Welcome to our website',
                            fontSize: 14,
                            color: Colors.black),
                        const SizedBox(
                          height: 50,
                        ),
                        TextformfieldWidget(
                          label: 'Email',
                          prefixIcon: const Icon(Icons.email),
                          textFieldController: _emailController,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextformfieldWidget(
                          isObscure: secureText,
                          label: 'Password',
                          prefixIcon: const Icon(Icons.lock),
                          textFieldController: _passwordController,
                          suffixIcon: IconButton(
                            icon: Icon(
                              secureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                secureText = !secureText;
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: MaterialButton(
                              minWidth: 300,
                              color: primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              onPressed: (() async {
                                if (loginformKey.currentState!.validate()) {
                                  try {
                                    await AuthRepository().loginOfuser(
                                        _emailController.text,
                                        _passwordController.text);
                                    // ignore: use_build_context_synchronously
                                    Navigation(context).goToHomeScreen();
                                  } on FirebaseAuthException catch (e) {
                                    validateLogin(e);
                                  }
                                }
                              }),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: NormalText(
                                    label: 'Login',
                                    fontSize: 24,
                                    color: Colors.white),
                              )),
                        ),
                        const Expanded(
                          child: SizedBox(
                            height: 80,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            NormalText(
                                label: 'Not a member yet?',
                                fontSize: 14,
                                color: Colors.grey),
                            TextButton(
                              onPressed: (() {
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => SignupPage()));
                                Navigation(context).goToSignUpPage();
                              }),
                              child: NormalText(
                                  label: 'Register now',
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
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
