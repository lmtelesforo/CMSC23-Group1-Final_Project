import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_signup.dart';
import '../providers/textfield_providers.dart';

class OrgRequestPage extends StatefulWidget {
  final int index;

  const OrgRequestPage({Key? key, required this.index}) : super(key: key);

  @override
  State<OrgRequestPage> createState() => _OrgRequestPageState();
}

class _OrgRequestPageState extends State<OrgRequestPage> {
  List<User> requests = [
    User(
      name: 'Org 1',
      username: 'org1_username',
      password: 'password1',
      addresses: ['Address 1', 'Address 2'],
      contactNumber: '1234567890',
      proofs: ['Proofs for Organization 1'],
    ),
    User(
      name: 'Org 2',
      username: 'org2_username',
      password: 'password2',
      addresses: ['Address 3', 'Address 4'],
      contactNumber: '0987654321',
      proofs: ['gfgdf', '7979'],
    ),
    User(
      name: 'Org 3',
      username: 'org3_username',
      password: 'password3',
      addresses: ['Address 5', 'Address 6'],
      contactNumber: '9876543210',
      proofs: ['Proofs for Organization 3'],
    ),
    User(
      name: 'Org 3',
      username: 'org3_username',
      password: 'password3',
      addresses: ['Address 5', 'Address 6'],
      contactNumber: '9876543210',
      proofs: ['Proofs for Organization 3'],
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
                  Navigator.pushNamed(context, "/adminApprove");
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
              child: Padding(
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
                                  requests[widget.index].name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
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
                                'Username:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins-Bold',
                                  color: Color(0xFF373D66),
                                ),
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  requests[widget.index].username,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
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
                                      requests[widget.index].addresses.first,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF373D66),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              (requests[widget.index].addresses.length > 1)
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
                                  requests[widget.index].contactNumber,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
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
                                      requests[widget.index].proofs?.first,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF373D66),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              (requests[widget.index].proofs!.length > 1)
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
            Positioned(
            bottom: MediaQuery.of(context).size.height * 0.2,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, "/adminApprove");
                    },
                    icon: Icon(
                      Icons.check,
                      color: Color.fromARGB(255, 68, 183, 39),
                    ),
                    label: Text(
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
                      backgroundColor: Color(0xFF373D66),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, "/adminApprove");
                    },
                    icon: Icon(
                      Icons.clear,
                      color: const Color.fromARGB(255, 181, 19, 19),
                    ),
                    label: Text(
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
                      backgroundColor: Color(0xFFFCBE4F),
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
        requests[widget.index].addresses.length - 1,
        (index) {
          return Padding(
            padding: EdgeInsets.only(left: 106), 
            child: Text(
              requests[widget.index].addresses[index + 1],
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins',
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
        requests[widget.index].proofs!.length - 1,
        (index) {
          return Padding(
            padding: EdgeInsets.only(left: 70), 
            child: Text(
              requests[widget.index].proofs![index + 1],
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins',
                color: Color(0xFF373D66),
              ),
            ),
          );
        },
      ),
    );
  }
}
