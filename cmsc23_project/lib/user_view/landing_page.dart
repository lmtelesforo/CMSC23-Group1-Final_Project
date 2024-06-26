import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cmsc23_project/api/firebase_users_api.dart';
import 'package:cmsc23_project/providers/auth_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/firebase_provider.dart';
import '../providers/textfield_providers.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool showSignInErrorMessage = false;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TextfieldProviders>();
    final firebaseUsers = context.watch<UserInfosProvider>();

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/user_view/assets/cmsc23_background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.12, 
            left: 0,
            right: 0,
            child: Container(
              child: Image.asset(
                'lib/user_view/assets/cmsc23_logo1.png',
                width: 220,
                height: 220,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.38, 
            left: 0,
            right: 0,
            child: const Text(
              "ELBIDrive",
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                fontFamily: 'CaveatBrush',
                color: Color(0xFF373D66),
                height: 0.6,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.53, 
            left: 0,
            right: 0,
            child: Center(
              child: Container (
                width: 320,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, bottom: 12),
                      child: Text(
                        "For the People, by the People.",
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'Poppins-Reg',
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF373D66),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, "/loginDonor");
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(300, 35),
                        foregroundColor: const Color(0xFFFCBE4F),
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins-Bold',
                        ),
                        backgroundColor: const Color(0xFF373D66),
                      ),
                      child: const Text('Log In'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, "/signupDonor");
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(300, 35),
                        foregroundColor: const Color(0xFFFCBE4F),
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins-Bold',
                        ),
                        backgroundColor: const Color(0xFF373D66),
                      ),
                      child: const Text('Sign Up'),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 17, bottom: 5),
                      child: Text(
                        "Accepting donations?",
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'Poppins-Reg',
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF373D66), 
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, "/signupOrg");
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(300, 35),
                        foregroundColor: const Color(0xFF373D66),
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins-Bold',
                        ),
                        backgroundColor: const Color(0xFFFCBE4F),
                      ),
                      child: const Text('Sign up as an Organization'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final GoogleSignIn googleSignIn = GoogleSignIn();
                        await googleSignIn.signOut(); // sign out any current gmails
                        GoogleSignInAccount? googleUser = await googleSignIn.signIn();

                        GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

                        AuthCredential credential = GoogleAuthProvider.credential(
                          accessToken: googleAuth?.accessToken,
                          idToken: googleAuth?.idToken
                        );
                        
                        UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

                        print(userCredential.user?.email);

                        String? googleEmail = userCredential.user?.email;

                        final donorsData = await firebaseUsers.getDonors();

                        var donorDetails;

                        // loop through donorsData and check if user email has match in all donors
                        String? donorName;
                        bool foundDonor = false;
                        for (var donorData in donorsData) {
                          var donorEmail = donorData['email'];
                          if (donorEmail == googleEmail) {
                            foundDonor = true;
                            donorName = donorData['name'];
                            donorDetails = donorData;
                            break;
                          }
                        } 
                        
                        if (foundDonor == true) {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, "/donorHomepage", arguments: donorDetails);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Welcome, ${donorName}!'),
                            ),
                          );
                        } 
                        else if (foundDonor != true) {
                          final orgsData = await firebaseUsers.getOrgs();

                          // loop through orgsData and check if user email has match in all orgs
                          String? orgName;
                          bool foundOrg = false;
                          for (var orgData in orgsData) {
                            var orgEmail = orgData['email'];
                            if (orgEmail == googleEmail) {
                              foundOrg = true;
                              orgName = orgData['name'];
                              break;
                            }
                          }

                          if (foundOrg == true) {
                            provider.resetLogIn();
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/orgHomepage");

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Welcome, ${orgName}!'),
                              ),
                            );
                            provider.resetLogIn();
                          } 
                          else if (foundDonor != true && foundOrg != true) { // no match for either
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('You don\'t have an existing account. Please create one.'),
                              ),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(300, 35),
                        foregroundColor: const Color(0xFF373D66),
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins-Bold',
                        ),
                        backgroundColor: const Color(0xFFFCBE4F),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'lib/user_view/assets/google.png', 
                            height: 20.0,
                            width: 20.0,
                          ),
                          const SizedBox(width: 8.0), 
                          const Text('Sign in with Google'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 34,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, "/loginAdmin");
                        },
                        child: const Text(
                          "Log in as Admin",
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
            ),
          ),
        ],
      ),
    );
  }
}
