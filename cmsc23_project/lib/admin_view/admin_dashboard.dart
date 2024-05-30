import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/textfield_providers.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TextfieldProviders>();

    return Scaffold(
      body: Stack(
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
                  image: AssetImage('lib/user_view/assets/cmsc23_background.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.045,
            left: 0,
            right: 0,
            child: Container(
              child: Image.asset(
                'lib/user_view/assets/cmsc23_logo1.png',
                width: 60,
                height: 60,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.045,
            left: 0,
            child: TextButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Admin Abi logged out!'),
                  ),
                );
                Navigator.pop(context);
                Navigator.pushNamed(context, "/");
              },
              icon: Image.asset(
                'lib/user_view/assets/back.png',
                width: 34,
                height: 34,
              ),
              label: const Text(
                'Log out',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins-Reg',
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
            top: MediaQuery.of(context).size.height * 0.12,
            left: 0,
            right: 0,
            child: const Padding(
              padding: EdgeInsets.all(17),
              child: Text(
                "Admin Dashboard",
                style: TextStyle(
                  fontSize: 26,
                  fontFamily: 'Poppins-Bold',
                  color: Color(0xFF373D66),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.25,
            left: 0,
            right: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 145, 
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/adminApprove");
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10), 
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                 'lib/user_view/assets/signup.png', 
                                width: 135, 
                                height: 100, 
                              ), 
                              const SizedBox(height: 10),
                              const Text(
                                'Sign Up Requests',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins-Bold',
                                  color: Color(0xFF373D66),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: 145, 
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/viewAllDonors");
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10), 
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                 'lib/user_view/assets/donors.png', 
                                width: 135, 
                                height: 100, 
                              ), 
                              const SizedBox(height: 10),
                              const Text(
                                'View All Donors',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins-Bold',
                                  color: Color(0xFF373D66),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 145, 
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/viewAllDonations");
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10), 
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                 'lib/user_view/assets/donate.png', 
                                width: 135, 
                                height: 100, 
                              ), 
                              const SizedBox(height: 10),
                              const Text(
                                'View All Donations',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins-Bold',
                                  color: Color(0xFF373D66),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: 145, 
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/viewAllOrgs");
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10), 
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                 'lib/user_view/assets/orgs.png', 
                                width: 135, 
                                height: 100, 
                              ), 
                              const SizedBox(height: 10),
                              const Text(
                                'View All Organizations',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins-Bold',
                                  color: Color(0xFF373D66),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
