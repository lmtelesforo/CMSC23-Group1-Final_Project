import 'package:cmsc23_project/providers/textfield_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class SignUpOrgPage extends StatefulWidget {
  const SignUpOrgPage({Key? key}) : super(key: key);

  @override
  State<SignUpOrgPage> createState() => _SignUpOrgPageState();
}

class _SignUpOrgPageState extends State<SignUpOrgPage> {
  final _formKey = GlobalKey<FormState>();
  late String signUpResult;

  bool isNumeric(String str) { // check if input is a contact number
    if(str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TextfieldProviders>();

    return Scaffold(
      body: Form(
        key: _formKey, 
        child: Stack(
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
                  provider.resetSignUp();
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
                    fontFamily: 'Poppins-Reg',
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
              top: MediaQuery.of(context).size.height * 0.08, 
              left: 0,
              right: 0,
              child: Container(
                child: Image.asset(
                  'lib/user_view/assets/cmsc23_logo1.png',
                  width: 50,
                  height: 50,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.14, 
              left: 0,
              right: 0,
              child: const Text(
                "ELBIDrive",
                style: TextStyle(
                  fontSize: 29,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'CaveatBrush',
                  color: Color(0xFF373D66),
                  height: 0.6,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.19, 
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
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.133, bottom: 4),
                          child: Text(
                            "Name",
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
                    Container(
                      width: 320,
                      height: 55,
                      child: Stack (
                        children: [
                          Container (
                            width: 320,
                            height: 38,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                                color: Color(0xFFFFFFFF).withOpacity(0.7),
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
                              return null;
                            },
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins-Reg',
                                color: Color(0xFF373D66)
                            ),
                            decoration: InputDecoration(
                              hintText: 'Enter your name',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins-Reg',
                                color: Color(0xFF373D66).withOpacity(0.9),
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 16, right: 16, bottom: 7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.133, bottom: 4),
                          child: Text(
                            "Nickname",
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
                    Container(
                      width: 320,
                      height: 55,
                      child: Stack (
                        children: [
                          Container (
                            width: 320,
                            height: 38,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                                color: Color(0xFFFFFFFF).withOpacity(0.7),
                              ),
                            ),
                          TextFormField(
                            controller: provider.controller2, 
                            onChanged: provider.updateNickname,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter your nickname";
                              }
                              if (val.trim().isEmpty) {
                                return "Please enter your nickname";
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
                              hintText: 'Enter your nickname',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins-Reg',
                                color: Color(0xFF373D66).withOpacity(0.9),
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 16, right: 16, bottom: 7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.133, bottom: 4),
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
                    Container(
                      width: 320,
                      height: 55,
                      child: Stack (
                        children: [
                          Container (
                            width: 320,
                            height: 38,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                                color: Color(0xFFFFFFFF).withOpacity(0.7),
                              ),
                            ),
                          TextFormField(
                            controller: provider.controller3, 
                            onChanged: provider.updateEmail,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter your email";
                              }
                              if (val.trim().isEmpty) {
                                return "Please enter your email";
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
                              hintText: 'Enter your email',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins-Reg',
                                color: Color(0xFF373D66).withOpacity(0.9),
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 16, right: 16, bottom: 7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.133, bottom: 6),
                          child: Text(
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
                    Container(
                      width: 320,
                      height: 55,
                      child: Stack (
                        children: [
                          Container (
                            width: 320,
                            height: 38,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                                color: Color(0xFFFFFFFF).withOpacity(0.7),
                              ),
                            ),
                          TextFormField(
                            controller: provider.controller4, 
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
                                color: Color(0xFF373D66).withOpacity(0.9),
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 16, right: 16, bottom: 7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.133, bottom: 3),
                          child: Text(
                            "Address/es",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Poppins-Reg',
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF373D66),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1, bottom: 3),
                          child: Text(
                            "separate with commas",
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Poppins-Reg',
                              color: Color(0xFF373D66),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 320,
                      height: 55,
                      child: Stack (
                        children: [
                          Container (
                            width: 320,
                            height: 38,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                                color: Color(0xFFFFFFFF).withOpacity(0.7),
                              ),
                            ),
                          TextFormField(
                            controller: provider.controller5, 
                            onChanged: provider.updateAddresses,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter your address/es";
                              }
                              if (val.trim().isEmpty) {
                                return "Please enter your address/es";
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
                              hintText: 'Enter your address/es',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins-Reg',
                                color: Color(0xFF373D66).withOpacity(0.9),
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 16, right: 16, bottom: 7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.133, bottom: 6),
                          child: Text(
                            "Contact number",
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
                    Container(
                      width: 320,
                      height: 55,
                      child: Stack (
                        children: [
                          Container (
                            width: 320,
                            height: 38,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                                color: Color(0xFFFFFFFF).withOpacity(0.7),
                              ),
                            ),
                          TextFormField(
                            controller: provider.controller6, 
                            onChanged: provider.updateContactNumber,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter your contact number";
                              }
                              if (val.trim().isEmpty) {
                                return "Please enter your contact number";
                              }
                              if (isNumeric(val) != true) {
                                return "Please enter a valid contact number";
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
                              hintText: 'Enter your contact number',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins-Reg',
                                color: Color(0xFF373D66).withOpacity(0.9),
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 16, right: 16, bottom: 7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.133, bottom: 3),
                          child: Text(
                            "Proof/s of Legitimacy",
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
                    Container(
                      width: 320,
                      height: 55,
                      child: Stack (
                        children: [
                          Container (
                            width: 320,
                            height: 38,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                                color: Color(0xFFFFFFFF).withOpacity(0.7),
                              ),
                            ),
                          TextFormField(
                            controller: provider.controller7, 
                            onChanged: provider.updateContactNumber,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please include your proofs";
                              }
                              if (val.trim().isEmpty) {
                                return "Please include your proofs";
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
                              hintText: 'e.g. Date established, etc.',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins-Reg',
                                color: Color(0xFF373D66).withOpacity(0.9),
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 16, right: 16, bottom: 7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 34,
                      child: TextButton(
                        onPressed: () {
                          provider.resetSignUp();
                        },
                        child: Text(
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
                          _formKey.currentState!.save();
                          final name = provider.controller1.text;
                          final nickname = provider.controller2.text;
                          final email = provider.controller3.text;
                          final password = provider.controller4.text;
                          final addresses = provider.controller5.text;
                          final contactnumber = provider.controller6.text;
                          final proofs = provider.controller7.text;
                          final userType = 'organization';

                          final authService = Provider.of<UserAuthProvider>(context, listen: false).authService;

                          signUpResult = (await authService.signUp(email, password))!;

                          if (signUpResult == 'The account already exists for that email.') { // match error message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Account already exists!')),
                            );
                          }
                          else {
                            provider.resetSignUp();
                            Navigator.pop(context);
                            Navigator.pushNamed(context, "/donorHomepage");

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Welcome to ElbiDrive, $name!'),
                              ),
                            );  
                          }
                        } 
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(320, 40),
                        foregroundColor:  Color(0xFFFCBE4F),
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins-Bold',
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
                              fontFamily: 'Poppins-Reg',
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF373D66),
                            ),
                          ),
                          SizedBox(
                            height: 34,
                            child: TextButton(
                              onPressed: () {
                                provider.resetSignUp();
                                Navigator.pop(context);
                                Navigator.pushNamed(context, "/loginDonor");
                              },
                              child: Text(
                                "Log in",
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
        ],
      ),
      ),
    );
  }
}
