import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
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
                        Navigator.pushNamed(context, "/loginOrg");
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
                      child: const Text('Log in as an Organization'),
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
