import 'package:cmsc23_project/admin_view/admin_dashboard.dart';
import 'package:cmsc23_project/admin_view/approve_signups.dart';
import 'package:cmsc23_project/admin_view/view_all_donors.dart';
import 'package:cmsc23_project/admin_view/view_all_organizations.dart';
import 'package:cmsc23_project/providers/current_org_provider.dart';
import 'package:cmsc23_project/user_view/landing_page.dart';
import 'package:cmsc23_project/admin_view/login_admin.dart';
import 'package:cmsc23_project/user_view/login_donor.dart';
import 'package:cmsc23_project/user_view/login_org.dart';
import 'package:cmsc23_project/user_view/signup_donor.dart';
import 'package:cmsc23_project/user_view/signup_org.dart';
import 'package:cmsc23_project/donor-view/donation_page/donor_homepage.dart';
import 'package:cmsc23_project/org-view/org_view.dart';
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
        ),
        ChangeNotifierProvider(create: (context) => CurrentOrgProvider())
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
        "/org": (context) => const OrgHomePage(),
        "/org/add-a-drive": (context) => const AddADrive(),
        "/org/profile": (context) => const Profile(),
        "/org/manage-drives": (context) => const ManageDonationDrives(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
