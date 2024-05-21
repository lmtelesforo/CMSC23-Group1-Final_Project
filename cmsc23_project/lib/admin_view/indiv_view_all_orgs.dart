import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/org_signup.dart';
import '../models/user_signup.dart';
import '../providers/textfield_providers.dart';

class IndivViewAllOrgs extends StatefulWidget {
  final int index;

  const IndivViewAllOrgs({Key? key, required this.index}) : super(key: key);

  @override
  State<IndivViewAllOrgs> createState() => _IndivViewAllOrgsState();
}

class _IndivViewAllOrgsState extends State<IndivViewAllOrgs> {
  List<Org> organizations = [
    Org(
      name: 'Org 1',
      username: 'org1_username',
      password: 'password1',
      email: 'laira@gmail.com',
      addresses: ['Address 1', 'Address 2'],
      contactNumber: '1234567890',
      proofs: ['Proofs for Organization 1', 'More'],
      userType: 'organization'
    ),
  ];

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
                Navigator.pushNamed(context, "/viewAllOrgs");
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
            top: MediaQuery.of(context).size.height * 0.14, 
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.all(17),
              child: Text(
                "Organization Details",
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
            top: MediaQuery.of(context).size.height * 0.27,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30), 
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(15), 
                ),
                child: Padding(
                  padding: EdgeInsets.all(10), 
                  child: Expanded (
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Name:',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins-Bold',
                                color: Color(0xFF373D66),
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                organizations[widget.index].name,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins-Reg',
                                  color: Color(0xFF373D66),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 7),
                        Row(
                          children: [
                            Text(
                              'Orgname:',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins-Bold',
                                color: Color(0xFF373D66),
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                organizations[widget.index].username,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins-Reg',
                                  color: Color(0xFF373D66),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 7),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Address/es:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins-Bold',
                                    color: Color(0xFF373D66),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    organizations[widget.index].addresses.first,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins-Reg',
                                      color: Color(0xFF373D66),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            (organizations[widget.index].addresses.length > 1)
                            ? newAddressLine() // if true
                            : SizedBox.shrink(), // if false
                          ],
                        ),
                        SizedBox(height: 7),
                        Row(
                          children: [
                            Text(
                              'Contact Number:',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins-Bold',
                                color: Color(0xFF373D66),
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                organizations[widget.index].contactNumber,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins-Reg',
                                  color: Color(0xFF373D66),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 7),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Proof/s:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins-Bold',
                                    color: Color(0xFF373D66),
                                  ),
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    organizations[widget.index].proofs?.first,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins-Reg',
                                      color: Color(0xFF373D66),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            (organizations[widget.index].proofs!.length > 1)
                            ? newLine() // if true
                            : SizedBox.shrink(), // if false
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
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
        organizations[widget.index].addresses.length - 1,
        (index) {
          return Padding(
            padding: EdgeInsets.only(left: 106), 
            child: Text(
              organizations[widget.index].addresses[index + 1],
              style: TextStyle(
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
        organizations[widget.index].proofs!.length - 1,
        (index) {
          return Padding(
            padding: EdgeInsets.only(left: 70), 
            child: Text(
              organizations[widget.index].proofs![index + 1],
              style: TextStyle(
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
}
