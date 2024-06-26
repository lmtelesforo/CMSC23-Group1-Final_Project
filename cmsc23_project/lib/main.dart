import 'package:cmsc23_project/admin_view/admin_dashboard.dart';
import 'package:cmsc23_project/admin_view/approve_signups.dart';
import 'package:cmsc23_project/admin_view/login_admin.dart';
import 'package:cmsc23_project/admin_view/view_all_donations.dart';
import 'package:cmsc23_project/admin_view/view_all_donors.dart';
import 'package:cmsc23_project/admin_view/view_all_organizations.dart';
import 'package:cmsc23_project/donor-view/donation_page/donor_homepage.dart';
import 'package:cmsc23_project/providers/current_org_provider.dart';
import 'package:cmsc23_project/providers/donation_providers.dart';
import 'package:cmsc23_project/providers/donation_storage_provider.dart';
import 'package:cmsc23_project/user_view/landing_page.dart';
import 'package:cmsc23_project/user_view/login_donor.dart';
import 'package:cmsc23_project/user_view/google_signin.dart';
import 'package:cmsc23_project/user_view/signup_donor.dart';
import 'package:cmsc23_project/user_view/signup_org.dart';
import 'package:cmsc23_project/org-view/org_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/firebase_provider.dart';
import 'providers/textfield_providers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TextfieldProviders(),
        ),
        ChangeNotifierProvider(create: ((context) => UserAuthProvider())),
        ChangeNotifierProvider(create: ((context) => UserInfosProvider())),
        ChangeNotifierProvider(
          create: (context) => DonationProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CurrentOrgProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DonationStorageProvider(),
        ),
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
      initialRoute: '/',
      routes: {
        "/": (context) => const LandingPage(),
        "/loginDonor": (context) => const LogInDonorPage(),
        "/googleSignIn": (context) => const GoogleSignIn(),
        "/loginAdmin": (context) => const LogInAdminPage(),
        "/signupDonor": (context) => const SignUpDonorPage(),
        "/signupOrg": (context) => const SignUpOrgPage(),
        "/adminApprove": (context) => const ApproveOrgSignups(),
        "/viewAllOrgs": (context) => const AdminViewAllOrgs(),
        "/viewAllDonations": (context) => const AdminViewAllDonations(),
        "/viewAllDonors": (context) => const AdminViewAllDonors(),
        "/adminDashboard": (context) => const AdminDashboard(),
        "/donorHomepage": (context) => const DonorHomepage(),
        // org
        '/org': (context) => const OrgHomePage(),
        '/org/profile': (context) => const Profile(),
        '/org/profile/edit': (context) => const ProfileEditor(),
        '/org/drives': (context) => const ManageDonationDrives(),
        '/org/drives/details': (context) => const DonationDriveDetails(),
        '/org/drives/add': (context) => const DriveForm(),
        '/org/drives/edit': (context) => const DriveForm(),
        '/org/donation': (context) => const DonationDetails(),
        '/org/scan-qr': (context) => const BarcodeScannerWithOverlay(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
