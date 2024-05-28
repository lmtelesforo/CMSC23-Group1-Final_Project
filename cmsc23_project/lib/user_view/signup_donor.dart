import 'package:cmsc23_project/providers/firebase_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/textfield_providers.dart';

class SignUpDonorPage extends StatefulWidget {
  const SignUpDonorPage({super.key});

  @override
  State<SignUpDonorPage> createState() => _SignUpDonorPageState();
}

class _SignUpDonorPageState extends State<SignUpDonorPage> {
  final _formKey = GlobalKey<FormState>(); 
  late String signUpResult;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TextfieldProviders>();
    List<String> addressesList = [];

    bool isNumeric(String str) { // check if input is a contact number
      if(str == null) {
        return false;
      }
      return double.tryParse(str) != null;
    }

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
              top: MediaQuery.of(context).size.height * 0.09, 
              left: 0,
              right: 0,
              child: Container(
                child: Image.asset(
                  'lib/user_view/assets/cmsc23_logo1.png',
                  width: 70,
                  height: 70,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.17, 
              left: 0,
              right: 0,
              child: const Text(
                "ELBIDrive",
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'CaveatBrush',
                  color: Color(0xFF373D66),
                  height: 0.6,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.23, 
              left: 0,
              right: 0,
              child: const Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Text(
                  "Create a donor account.",
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
              top: MediaQuery.of(context).size.height * 0.25, 
              left: 0,
              right: 0,
              bottom: MediaQuery.of(context).size.height * 0.07,
              child: Center(
                child: Container (
                  width: 320,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.041, bottom: 4),
                            child: const Text(
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
                      SizedBox(
                        width: 320,
                        height: 55,
                        child: Stack (
                          children: [
                            Container (
                              width: 320,
                              height: 38,
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
                                  color: const Color(0xFF373D66).withOpacity(0.9),
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 7),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.041, bottom: 4),
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
                        height: 55,
                        child: Stack (
                          children: [
                            Container (
                              width: 320,
                              height: 38,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(32),
                                  color: const Color(0xFFFFFFFF).withOpacity(0.7),
                                ),
                              ),
                            TextFormField(
                              controller: provider.controller2, 
                              onChanged: provider.updateUsername,
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.041, bottom: 4),
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
                                if (EmailValidator.validate(val) != true) {
                                  return "Invalid email";
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
                            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.041, bottom: 6),
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
                              obscureText: true,
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
                                  color: const Color(0xFF373D66).withOpacity(0.9),
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 7),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1, 
                        color: const Color(0xFFFCBE4F),
                      ),
                      Text(
                        "Separate multiple entries with semi-colons. Leave no space in between (e.g. Address 1;Address 2)",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins-Reg',
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF373D66),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Divider(
                        thickness: 1, 
                        color: const Color(0xFFFCBE4F), 
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.041, bottom: 3),
                            child: const Text(
                              "Address/es",
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
                        height: 55,
                        child: Stack (
                          children: [
                            Container (
                              width: 320,
                              height: 38,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(32),
                                  color: const Color(0xFFFFFFFF).withOpacity(0.7),
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
                                  color: const Color(0xFF373D66).withOpacity(0.9),
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 7),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.041, bottom: 6),
                            child: const Text(
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
                      SizedBox(
                        width: 320,
                        height: 55,
                        child: Stack (
                          children: [
                            Container (
                              width: 320,
                              height: 38,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(32),
                                  color: const Color(0xFFFFFFFF).withOpacity(0.7),
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
                                  color: const Color(0xFF373D66).withOpacity(0.9),
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 7),
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
                            _formKey.currentState!.save();
                            final name = provider.controller1.text;
                            final username = provider.controller2.text;
                            final email = provider.controller3.text;
                            final password = provider.controller4.text;
                            final addressesUnsplit = provider.controller5.text;
                            final contactnumber = provider.controller6.text;
                            final userType = 'donor';
                            bool multipleAddresses = addressesUnsplit.contains(';');

                            if (multipleAddresses == true) {
                              addressesList = addressesUnsplit.split(';').map((address) => address.trim()).toList();
                            }
                            else {
                              addressesList = [addressesUnsplit];
                            }
                            
                            final authService = Provider.of<UserAuthProvider>(context, listen: false).authService;
                            final userService = Provider.of<UserInfosProvider>(context, listen: false).firebaseService;

                            signUpResult = (await authService.signUp(email, password))!;

                            if (signUpResult == 'The account already exists for that email.' && checkUserType(email) == true) { // match error message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Account already exists!')),
                              );
                            }
                            else {
                              final user = UserInfosProvider().donorData(name, username, email, addressesList, contactnumber, userType);
                              
                              userService.addUser(user); // add to firebase

                              provider.resetSignUp();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('$name signed up! Log in to experience ElbiDrive.'),
                                ),
                              );
                              Navigator.pop(context);
                              Navigator.pushNamed(context, "/");
                            }
                          } 
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(320, 40),
                          foregroundColor:  const Color(0xFFFCBE4F),
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins-Bold',
                          ),
                          backgroundColor: const Color(0xFF373D66),
                        ),
                        child: const Text('Sign up as a Donor'),
                      ),
                      Center (
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
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
                                child: const Text(
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
            ),
          ],
        ),
      )
    );
  }

  Future<bool> checkUserType(String? googleEmail) async {
    final provider = Provider.of<TextfieldProviders>(context, listen: false);
    final firebaseUsers = Provider.of<UserInfosProvider>(context, listen: false);
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
      return true;
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
        return true;
      } 
      else if (foundDonor != true && foundOrg != true) { // no match for either
        return false;
      }
    }
    return false;
  }
}
