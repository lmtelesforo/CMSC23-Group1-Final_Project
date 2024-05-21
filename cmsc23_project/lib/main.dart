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
import 'package:cmsc23_project/donor-view/donation_page/donor_homepage.dart';
import 'package:cmsc23_project/org-view/donation_drive/add_a_drive.dart';
import 'package:cmsc23_project/org-view/org_homepage.dart';
import 'package:cmsc23_project/org-view/profile.dart';
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
      initialRoute: "/",
      routes: {
        "/": (context) => const LandingPage(),
        "/loginDonor": (context) => const LogInDonorPage(),
        "/loginOrg": (context) => const LogInOrgPage(),
        "/loginAdmin": (context) => const LogInAdminPage(),
        "/signupDonor": (context) => const SignUpDonorPage(),
        "/signupOrg": (context) => const SignUpOrgPage(),
        "/adminApprove": (context) => const ApproveOrgSignups(),
        "/viewAllOrgs": (context) => const AdminViewAllOrgs(),
        "/viewAllDonations": (context) => const AdminViewAllDonations(),
        "/viewAllDonors": (context) => const AdminViewAllDonors(),
        "/adminDashboard": (context) => const AdminDashboard(),
        "/donorHomepage": (context) => const DonorHomepage(),
        "/orgHomepage": (context) => const OrgHomePage(),
        "/add-a-drive": (context) => const AddADrive(),
        "/orgProfile": (context) => Profile(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}