import 'package:cmsc23_project/api/firebase_users_api.dart';
import 'package:cmsc23_project/providers/auth_provider.dart';
import 'package:cmsc23_project/providers/current_org_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/firebase_provider.dart';
import '../providers/textfield_providers.dart';

class LogInDonorPage extends StatefulWidget {
  const LogInDonorPage({super.key});

  @override
  State<LogInDonorPage> createState() => _LogInDonorPageState();
}

class _LogInDonorPageState extends State<LogInDonorPage> {
  final _formKey = GlobalKey<FormState>();
  bool showSignInErrorMessage = false;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TextfieldProviders>();
    final firebaseUsers = context.watch<UserInfosProvider>();

    firebaseUsers.printAllUsers();

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'lib/user_view/assets/cmsc23_background.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.06,
              left: 0,
              child: TextButton.icon(
                onPressed: () {
                  provider.resetLogIn();
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/");
                },
                icon: Image.asset(
                  'lib/user_view/assets/back.png',
                  width: 34,
                  height: 34,
                ),
                label: const Text(
                  'Back',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Poppins-Bold',
                  ),
                ),
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF373D66),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.165,
              left: 0,
              right: 0,
              child: Container(
                child: Image.asset(
                  'lib/user_view/assets/cmsc23_logo1.png',
                  width: 150,
                  height: 150,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.345,
              left: 0,
              right: 0,
              child: const Text(
                "ELBIDrive",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'CaveatBrush',
                  color: Color(0xFF373D66),
                  height: 0.6,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.43,
              left: 0,
              right: 0,
              child: const Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Text(
                  "Log in your account.",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Poppins-Reg',
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF373D66),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.415,
              left: 0,
              right: 0,
              bottom: 0,
              child: Center(
                child: Container(
                  width: 320,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.041,
                                bottom: 4),
                            child: Text(
                              "Email",
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Poppins-Reg',
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF373D66),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 320,
                        height: 60,
                        child: Stack(
                          children: [
                            Container(
                              width: 320,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                                color: const Color(0xFFFFFFFF).withOpacity(0.7),
                              ),
                            ),
                            TextFormField(
                              controller: provider.controller1,
                              onChanged: provider.updateName,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Please enter your name";
                                }
                                if (val.trim().isEmpty) {
                                  return "Please enter your name";
                                }
                                if (EmailValidator.validate(val) != true) {
                                  return "Invalid email";
                                }
                                return null;
                              },
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins-Reg',
                                  color: Color(0xFF373D66)),
                              decoration: InputDecoration(
                                hintText: 'Enter your email',
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins-Reg',
                                  color:
                                      const Color(0xFF373D66).withOpacity(0.9),
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.only(
                                    left: 16, right: 16, bottom: 7),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.041,
                                bottom: 4),
                            child: const Text(
                              "Password",
                              style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'Poppins-Reg',
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF373D66),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 320,
                        height: 60,
                        child: Stack(
                          children: [
                            Container(
                              width: 320,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                                color: const Color(0xFFFFFFFF).withOpacity(0.7),
                              ),
                            ),
                            TextFormField(
                              obscureText: true,
                              controller: provider.controller2,
                              onChanged: provider.updatePassword,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Please enter your password";
                                }
                                if (val.trim().isEmpty) {
                                  return "Please enter your password";
                                }
                                if (val.trim().length < 6) {
                                  return "Minimum of 6 characters";
                                }
                                return null;
                              },
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins-Reg',
                                  color: Color(0xFF373D66)),
                              decoration: InputDecoration(
                                hintText: 'Enter your password',
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins-Reg',
                                  color:
                                      const Color(0xFF373D66).withOpacity(0.9),
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.only(
                                    left: 16, right: 16, bottom: 7),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 34,
                        child: TextButton(
                          onPressed: () {
                            provider.resetLogIn();
                          },
                          child: const Text(
                            "Reset",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins-Reg',
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF373D66),
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            String email = provider.controller1.text;
                            String password = provider.controller2.text;

                            String? message = await context
                                .read<UserAuthProvider>()
                                .authService
                                .signIn(email!, password!);

                            print(message);
                            print(showSignInErrorMessage);

                            setState(() async {
                              final bool found = await checkUserType(email);
                              print(found);
                              // ignore: unrelated_type_equality_checks
                              if (message != null &&
                                  message.isNotEmpty &&
                                  found != false) {
                                print(found);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Invalid email or password. Check your credentials or try signing in with Google.'),
                                  ),
                                );
                              }
                              // ignore: unrelated_type_equality_checks
                              else if (found != true) {
                                print(found);
                                showSignInErrorMessage = true;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'No existing account. Create one?'),
                                  ),
                                );
                              } else {
                                showSignInErrorMessage = false;

                                final donorsData =
                                    await firebaseUsers.getDonors();

                                var donorDetails;

                                // loop through donorsData and check if user email has match in all donors
                                String? donorName;
                                bool foundDonor = false;
                                for (var donorData in donorsData) {
                                  var donorEmail = donorData['email'];
                                  if (donorEmail == email) {
                                    foundDonor = true;
                                    donorName = donorData['name'];
                                    donorDetails = donorData;
                                    break;
                                  }
                                }

                                if (foundDonor == true) {
                                  provider.resetLogIn();
                                  Navigator.pop(context);
                                  Navigator.pushNamed(context, "/donorHomepage",
                                      arguments: donorDetails);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Welcome to ElbiDrive, $donorName!'),
                                    ),
                                  );
                                } else if (foundDonor != true) {
                                  final orgsData =
                                      await firebaseUsers.getOrgs();

                                  // loop through orgsData and check if user email has match in all orgs
                                  String? orgName;
                                  String? orgUsername;
                                  bool foundOrg = false;
                                  for (var orgData in orgsData) {
                                    var orgEmail = orgData['email'];
                                    if (orgEmail == email) {
                                      foundOrg = true;
                                      orgName = orgData['name'];
                                      orgUsername = orgData['username'];
                                      break;
                                    }
                                  }

                                  if (foundOrg == true) {
                                    provider.resetLogIn();
                                    Navigator.pop(context);
                                    context
                                        .read<CurrentOrgProvider>()
                                        .setOrg(orgUsername!, orgName!);
                                    Navigator.pushNamed(context, "/org");

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Welcome, ${orgName}!'),
                                      ),
                                    );
                                    provider.resetLogIn();
                                  } else if (foundDonor != true &&
                                      foundOrg != true) {
                                    // no match for either
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'You don\'t have an existing account. Create one?'),
                                      ),
                                    );
                                  }
                                }
                              }
                            });
                          } else {}
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(320, 40),
                          foregroundColor: const Color(0xFFFCBE4F),
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins-Bold',
                          ),
                          backgroundColor: const Color(0xFF373D66),
                        ),
                        child: const Text('Log in'),
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Poppins-Reg',
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF373D66),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                              child: TextButton(
                                onPressed: () {
                                  provider.resetLogIn();
                                  Navigator.pop(context);
                                  Navigator.pushNamed(context, "/signupDonor");
                                },
                                child: const Text(
                                  "Sign up",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Poppins-Bold',
                                    color: Color(0xFF373D66),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.035,
              left: 0,
              right: 0,
              child: Center(
                child:
                    showSignInErrorMessage ? signInErrorMessage : Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get signInErrorMessage => const Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: Text(
          "Invalid email or password",
          style: TextStyle(
              color: Color.fromARGB(255, 179, 42, 32),
              fontFamily: 'Poppins',
              fontSize: 15),
        ),
      );

  Future<bool> checkUserType(String? googleEmail) async {
    final firebaseUsers = context.read<UserInfosProvider>();
    final donorsData = await firebaseUsers.getDonors();
    final orgsData = await firebaseUsers.getOrgs();

    // check if it matches any existing email
    final foundDonor =
        donorsData.any((donorData) => donorData['email'] == googleEmail);

    // check if it matches any emails
    final foundOrg = orgsData.any((orgData) => orgData['email'] == googleEmail);

    print('Donor match: $foundDonor');
    print('Organization match: $foundOrg');

    // true if it matched with any email
    if (foundDonor == true || foundOrg == true) {
      return true;
    }
    return false;
  }
}
