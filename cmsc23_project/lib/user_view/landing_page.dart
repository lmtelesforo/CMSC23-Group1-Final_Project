import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

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
                width: 240,
                height: 240,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.40, 
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
            top: MediaQuery.of(context).size.height * 0.55, 
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 5),
                    child: Text(
                      "For the People, by the People",
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF373D66),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(320, 35),
                      foregroundColor: Color(0xFFFCBE4F),
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Poppins',
                      ),
                      backgroundColor: Color(0xFF373D66),
                    ),
                    child: const Text('Log In'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(320, 35),
                      foregroundColor: Color(0xFFFCBE4F),
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                      backgroundColor: Color(0xFF373D66),
                    ),
                    child: const Text('Sign Up'),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 7, bottom: 5),
                    child: Text(
                      "Accepting donations?",
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF373D66), 
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(320, 35),
                      foregroundColor: Color(0xFF373D66),
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Poppins',
                      ),
                      backgroundColor: Color(0xFFFCBE4F).withOpacity(0.65),
                    ),
                    child: const Text('Log in as an Organization'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(320, 35),
                      foregroundColor: Color(0xFF373D66),
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Poppins',
                      ),
                      backgroundColor: Color(0xFFFCBE4F).withOpacity(0.65),
                    ),
                    child: const Text('Sign up as an Organization'),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.907, 
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "© 2024 ELBIDrive. All Rights Reserved.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF373D66),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
