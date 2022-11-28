import 'package:flutter/material.dart';

import '../constant/routes.dart';

class Navigation {
  Navigation(this.context);

  BuildContext context;

  goToLoginPage() {
    Navigator.pushNamed(context, Routes.loginpage);
  }

  goToHomeScreen() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(Routes.homescreen, (route) => false);
  }

  goToSignUpPage() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(Routes.signuppage, (route) => false);
  }
}
