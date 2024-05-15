import 'package:cmsc23_project/admin_view/admin_dashboard.dart';
import 'package:cmsc23_project/admin_view/approve_signups.dart';
import 'package:cmsc23_project/admin_view/view_all_donors.dart';
import 'package:cmsc23_project/admin_view/view_all_organizations.dart';
import 'package:cmsc23_project/user_view/landing_page.dart';
import 'package:cmsc23_project/admin_view/login_admin.dart';
import 'package:cmsc23_project/user_view/login_donor.dart';
import 'package:cmsc23_project/user_view/login_org.dart';
import 'package:cmsc23_project/user_view/signup_donor.dart';
import 'package:cmsc23_project/user_view/signup_org.dart';
import 'package:cmsc23_project/donation_page/donor_homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'admin_view/view_all_donations.dart';
import 'providers/textfield_providers.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TextfieldProviders(),
        )
      ],
      child: const RootWidget(),
    ),
  );
}

class RootWidget extends StatelessWidget {
  const RootWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/adminDashboard",
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
        "/donorHomepage": (context) => DonorHomepage()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}