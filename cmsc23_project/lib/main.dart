import 'package:cmsc23_project/user_view/landing_page.dart';
import 'package:cmsc23_project/user_view/login_donor.dart';
import 'package:cmsc23_project/user_view/login_org.dart';
import 'package:cmsc23_project/user_view/signup_donor.dart';
import 'package:cmsc23_project/user_view/signup_org.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const RootWidget());
}

class RootWidget extends StatelessWidget {
  const RootWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => const LandingPage(),
        "/loginDonor": (context) => LogInDonorPage(),
        "/loginOrg": (context) => LogInOrgPage(),
        "/signupDonor": (context) => SignUpDonorPage(),
        "/signupOrg": (context) => SignUpOrgPage(),
      },
    );
  }
}