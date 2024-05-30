import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/org_signup.dart';
import '../providers/firebase_provider.dart';
import '../providers/textfield_providers.dart';

class OrgRequestPage extends StatefulWidget {
  final DocumentSnapshot orgDetails;

  const OrgRequestPage({super.key, required this.orgDetails});

  @override
  State<OrgRequestPage> createState() => _OrgRequestPageState();
}

class _OrgRequestPageState extends State<OrgRequestPage> {
  late Org org; 
  late Map<String, dynamic> orgMap;

  @override
  void initState() {
    super.initState();
    org = Org.fromJson(widget.orgDetails.data() as Map<String, dynamic>);
    orgMap = org.toJson(org);
    org.id = widget.orgDetails.id;
  }
  
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TextfieldProviders>();
    final int index;

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
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/adminApprove");
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
              top: MediaQuery.of(context).size.height * 0.12, 
              left: 0,
              right: 0,
              child: const Padding(
                padding: EdgeInsets.all(17),
                child: Text(
                  "Organization Request",
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
              top: MediaQuery.of(context).size.height * 0.24,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30), 
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(15), 
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10), 
                    child: Expanded (
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Name:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins-Bold',
                                  color: Color(0xFF373D66),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  org.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins-Reg',
                                    color: Color(0xFF373D66),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 7),
                          Row(
                            children: [
                              const Text(
                                'Username:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins-Bold',
                                  color: Color(0xFF373D66),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  org.username,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins-Reg',
                                    color: Color(0xFF373D66),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 7),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Address/es:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins-Bold',
                                      color: Color(0xFF373D66),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      org.addresses.first,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Poppins-Reg',
                                        color: Color(0xFF373D66),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              (org.addresses.length > 1)
                              ? newAddressLine() // if true
                              : const SizedBox.shrink(), // if false
                            ],
                          ),
                          const SizedBox(height: 7),
                          Row(
                            children: [
                              const Text(
                                'Email:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins-Bold',
                                  color: Color(0xFF373D66),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  org.email,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins-Reg',
                                    color: Color(0xFF373D66),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 7),
                          Row(
                            children: [
                              const Text(
                                'Contact Number:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins-Bold',
                                  color: Color(0xFF373D66),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  org.contactNumber,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins-Reg',
                                    color: Color(0xFF373D66),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 7),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'Proof/s:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins-Bold',
                                      color: Color(0xFF373D66),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      org.proofs.first,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Poppins-Reg',
                                        color: Color(0xFF373D66),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              (org.proofs.length > 1)
                              ? newLine() // if true
                              : const SizedBox.shrink(), // if false
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
            bottom: MediaQuery.of(context).size.height * 0.2,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      final bool found = await checkUserType(org.email);
                      print(found);   

                      if (found != false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('An account already exists under this email. Disapprove request?')),
                        );
                      }
                      else {
                        final userService = Provider.of<UserInfosProvider>(context, listen: false).firebaseService;
                        userService.addOrg(orgMap);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${org.name} sign up request approved!'),
                          ),
                        );
                        userService.deleteSignUpReq(org.id);
                        Navigator.pop(context);
                        Navigator.pushNamed(context, "/adminApprove");
                      }
                    },
                    icon: const Icon(
                      Icons.check,
                      color: Color.fromARGB(255, 68, 183, 39),
                    ),
                    label: const Text(
                      'Approve',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins-Bold',
                        color: Color(0xFFFCBE4F),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(300, 35),
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins-Bold',
                      ),
                      backgroundColor: const Color(0xFF373D66),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      final userService = Provider.of<UserInfosProvider>(context, listen: false).firebaseService;
                      userService.deleteSignUpReq(org.id); // only delete request
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${org.name} sign up request disapproved!'),
                        ),
                      );
                      Navigator.pop(context);
                      Navigator.pushNamed(context, "/adminApprove");
                    },
                    icon: const Icon(
                      Icons.clear,
                      color: Color.fromARGB(255, 181, 19, 19),
                    ),
                    label: const Text(
                      'Disapprove',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins-Bold',
                        color: Color(0xFF373D66),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(300, 35),
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Poppins-Bold',
                      ),
                      backgroundColor: const Color(0xFFFCBE4F),
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

  Widget newAddressLine() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        org.addresses.length - 1,
        (index) {
          return Padding(
            padding: const EdgeInsets.only(left: 106), 
            child: Text(
              org.addresses[index + 1],
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins-Reg',
                color: Color(0xFF373D66),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget newLine() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        org.proofs.length - 1,
        (index) {
          return Padding(
            padding: const EdgeInsets.only(left: 70), 
            child: Text(
              org.proofs[index + 1],
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins-Reg',
                color: Color(0xFF373D66),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<bool> checkUserType(String? googleEmail) async {
    final firebaseUsers = context.read<UserInfosProvider>();
    final donorsData = await firebaseUsers.getDonors();
    final orgsData = await firebaseUsers.getOrgs();

    // check if it matches any existing email
    final foundDonor = donorsData.any((donorData) => donorData['email'] == googleEmail);

    // check if it matches any emails
    final foundOrg = orgsData.any((orgData) => orgData['email'] == googleEmail);

    // true if it matched with any email
    return foundDonor || foundOrg;
  }
}
