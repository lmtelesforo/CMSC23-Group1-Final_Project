import 'package:flutter/material.dart';

class SignUpDonorPage extends StatefulWidget {
  const SignUpDonorPage({Key? key}) : super(key: key);

  @override
  State<SignUpDonorPage> createState() => _SignUpDonorPageState();
}

class _SignUpDonorPageState extends State<SignUpDonorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned (
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
            child: TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/");
              },
              icon: Image.asset(
                'lib/user_view/assets/back.png', 
                width: 34, 
                height: 34, 
              ),
              label: Text(
                'Back',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              style: TextButton.styleFrom(
                foregroundColor: Color(0xFF373D66),
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
            child: Container(
              child: Image.asset(
                'lib/user_view/assets/cmsc23_logo1.png',
                width: 100,
                height: 100,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.24, 
            left: 0,
            right: 0,
            child: const Text(
              "ELBIDrive",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                fontFamily: 'CaveatBrush',
                color: Color(0xFF373D66),
                height: 0.6,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.31, 
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Text(
                "Create a donor account.",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF373D66),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.37, 
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.133, bottom: 6),
                        child: Text(
                          "Name",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF373D66),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 320, 
                    height: 34,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: Color(0xFFFFFFFF).withOpacity(0.7), 
                    ),
                    child: TextField(
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        color: Color(0xFF373D66)
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter your name',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          color: Color(0xFF373D66).withOpacity(0.9),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 10.5, horizontal: 16),
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.133, bottom: 3, top: 6),
                        child: Text(
                          "Username",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF373D66),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 320, 
                    height: 34,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: Color(0xFFFFFFFF).withOpacity(0.7), 
                    ),
                    child: TextField(
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        color: Color(0xFF373D66)
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter your username',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          color: Color(0xFF373D66).withOpacity(0.9),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 10.5, horizontal: 16),
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.133, bottom: 6, top: 6),
                        child: Text(
                          "Password",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF373D66),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 320, 
                    height: 34,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: Color(0xFFFFFFFF).withOpacity(0.7), 
                    ),
                    child: TextField(
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        color: Color(0xFF373D66)
                      ),
                      decoration: InputDecoration(
                        hintText: 'Minimum of 6 characters',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          color: Color(0xFF373D66).withOpacity(0.9),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 10.5, horizontal: 16),
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.133, bottom: 3, top: 6),
                        child: Text(
                          "Address/es",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF373D66),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1, bottom: 3, top: 6),
                        child: Text(
                          "separate with commas",
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            color: Color(0xFF373D66),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 320, 
                    height: 34,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: Color(0xFFFFFFFF).withOpacity(0.7), 
                    ),
                    child: TextField(
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        color: Color(0xFF373D66)
                      ),
                      decoration: InputDecoration(
                        hintText: 'Address 1, Address 2',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          color: Color(0xFF373D66).withOpacity(0.9),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 10.5, horizontal: 16),
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.133, bottom: 6, top: 6),
                        child: Text(
                          "Contact number",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF373D66),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 320, 
                    height: 34,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: Color(0xFFFFFFFF).withOpacity(0.7), 
                    ),
                    child: TextField(
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        color: Color(0xFF373D66)
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter your contact number',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          color: Color(0xFF373D66).withOpacity(0.9),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 10.5, horizontal: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: 42),
                  ElevatedButton(
                    onPressed: () {

                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(320, 40),
                      foregroundColor:  Color(0xFFFCBE4F),
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Poppins',
                      ),
                      backgroundColor: Color(0xFF373D66),
                    ),
                    child: const Text('Sign up as a Donor'),
                  ),
                  Center (
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF373D66),
                          ),
                        ),
                        SizedBox(
                          height: 34,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pushNamed(context, "/loginDonor");
                            },
                            child: Text(
                              "Log in",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w900,
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
        ],
      ),
    );
  }
}
