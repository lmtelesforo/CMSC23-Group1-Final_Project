import 'package:cmsc23_project/org-view/org_view.dart';
import 'package:cmsc23_project/providers/current_org_provider.dart';
import 'package:cmsc23_project/providers/donation_providers.dart';
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
      initialRoute: '/org',
      routes: {
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
