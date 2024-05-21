import 'package:cmsc23_project/admin_view/admin_dashboard.dart';
import 'package:cmsc23_project/admin_view/approve_signups.dart';
import 'package:cmsc23_project/admin_view/login_admin.dart';
import 'package:cmsc23_project/admin_view/view_all_donations.dart';
import 'package:cmsc23_project/admin_view/view_all_donors.dart';
import 'package:cmsc23_project/admin_view/view_all_organizations.dart';
import 'package:cmsc23_project/donor-view/donation_page/donor_homepage.dart';
import 'package:cmsc23_project/org-view/donation_drive/add_a_drive.dart';
import 'package:cmsc23_project/org-view/org_homepage.dart';
import 'package:cmsc23_project/org-view/profile.dart';
import 'package:cmsc23_project/providers/donation_providers.dart';
import 'package:cmsc23_project/user_view/landing_page.dart';
import 'package:cmsc23_project/user_view/login_donor.dart';
import 'package:cmsc23_project/user_view/login_org.dart';
import 'package:cmsc23_project/user_view/signup_donor.dart';
import 'package:cmsc23_project/user_view/signup_org.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => DonationProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DonorHomepage(),
    );
  }
}

class RootWidget extends StatelessWidget {
  const RootWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => const LandingPage(),
        "/loginDonor": (context) => LogInDonorPage(),
        "/loginOrg": (context) => LogInOrgPage(),
        "/loginAdmin": (context) => LogInAdminPage(),
        "/signupDonor": (context) => SignUpDonorPage(),
        "/signupOrg": (context) => SignUpOrgPage(),
        "/adminApprove": (context) => ApproveOrgSignups(),
        "/viewAllOrgs": (context) => AdminViewAllOrgs(),
        "/viewAllDonations": (context) => AdminViewAllDonations(),
        "/viewAllDonors": (context) => AdminViewAllDonors(),
        "/adminDashboard": (context) => AdminDashboard(),
        "/donorHomepage": (context) => DonorHomepage(),
        "/orgHomepage": (context) => const OrgHomePage(),
        "/add-a-drive": (context) => const AddADrive(),
        "/orgProfile": (context) => Profile(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
