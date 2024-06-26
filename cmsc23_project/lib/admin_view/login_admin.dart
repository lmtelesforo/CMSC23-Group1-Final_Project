import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/textfield_providers.dart';

class LogInAdminPage extends StatefulWidget {
  const LogInAdminPage({super.key});

  @override
  State<LogInAdminPage> createState() => _LogInAdminPageState();
}

class _LogInAdminPageState extends State<LogInAdminPage> {
  final _formKey = GlobalKey<FormState>(); 

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TextfieldProviders>();

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
                    image: AssetImage('lib/user_view/assets/cmsc23_background.png'),
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
                  "For admin access only!",
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
              top: MediaQuery.of(context).size.height * 0.515,
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
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.145, bottom: 4),
                          child: const Text(
                            "Username",
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
                      child: Stack (
                        children: [
                          Container (
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
                                return "Please enter your username";
                              }
                              if (val.trim().isEmpty) {
                                return "Please enter your username";
                              }
                              return null;
                            },
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins-Reg',
                              color: Color(0xFF373D66)
                            ),
                            decoration: InputDecoration(
                              hintText: 'Enter your username',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins-Reg',
                                color: const Color(0xFF373D66).withOpacity(0.9),
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 7),
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
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.145, bottom: 4),
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
                      child: Stack (
                        children: [
                          Container (
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
                                color: Color(0xFF373D66)
                            ),
                            decoration: InputDecoration(
                              hintText: 'Enter your password',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins-Reg',
                                color: const Color(0xFF373D66).withOpacity(0.9),
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          String username = provider.controller1.text;
                          String password = provider.controller2.text;

                          if (username == "admin" && password == "adminPass") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Logged in!'),
                              ),
                            );
                            provider.resetLogIn();
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/adminDashboard");
                          }

                          else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Invalid admin credentials!'),
                              ),
                            );
                          }
                        } 
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
                      child: const Text('Log in as Admin'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
