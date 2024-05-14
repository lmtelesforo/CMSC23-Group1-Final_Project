import 'package:cmsc23_project/org-view/donation_drive/add_a_drive.dart';
import 'package:cmsc23_project/org-view/org_homepage.dart';
import 'package:cmsc23_project/org-view/profile.dart';
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
        "/": (context) => const OrgHomePage(),
        "/add-a-drive": (context) => const AddADrive(),
        "/profile": (context) => Profile(),
      },
    );
  }
}
