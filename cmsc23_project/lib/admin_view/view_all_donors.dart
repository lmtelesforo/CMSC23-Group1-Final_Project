import 'package:cmsc23_project/admin_view/indiv_approve_page.dart';
import 'package:cmsc23_project/admin_view/indiv_view_all_donors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_signup.dart';
import '../providers/textfield_providers.dart';
import 'indiv_view_all_orgs.dart';

class AdminViewAllDonors extends StatefulWidget {
  const AdminViewAllDonors({Key? key}) : super(key: key);

  @override
  State<AdminViewAllDonors> createState() => _AdminViewAllDonorsState();
}

class _AdminViewAllDonorsState extends State<AdminViewAllDonors> {
  final _formKey = GlobalKey<FormState>(); 

  List<User> donors = [
    User(
      name: 'sadasda',
      username: 'org1_username',
      password: 'password1',
      addresses: ['Address 1', 'Address 2'],
      contactNumber: '1234567890',
    ),
    User(
      name: 'Ofsda',
      username: 'org3_username',
      password: 'password3',
      addresses: ['Address 5', 'Address 6'],
      contactNumber: '9876543210',
    ),
    User(
      name: 'fdsfds',
      username: 'org3_username',
      password: 'password3',
      addresses: ['Address 5', 'Address 6'],
      contactNumber: '9876543210',
    ),
    User(
      name: 'Org 3',
      username: 'org3_username',
      password: 'password3',
      addresses: ['Address 5', 'Address 6'],
      contactNumber: '9876543210',
    ),
  ];

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
                  Navigator.pushNamed(context, "/adminDashboard");
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
              top: MediaQuery.of(context).size.height * 0.13, 
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.all(17),
                child: Text(
                  "All Donors",
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
              top: MediaQuery.of(context).size.height * 0.23,
              left: 0,
              right: 0,
              bottom: MediaQuery.of(context).size.height * 0.057,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: donors.length,
                      itemBuilder: (context, index) {
                        User donor = donors[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(15), 
                          ),
                          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 28),
                          child: ListTile(
                            contentPadding: EdgeInsets.only(top: 2, left: 10, bottom: 2, right: 13),
                            title: Text(
                              donor.name,
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Poppins-Bold',
                                color: Color(0xFF373D66),
                              ),
                            ),
                            subtitle: Text(
                              donor.contactNumber,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            trailing: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => IndivViewAllDonors(index: index),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(57, 50),
                                foregroundColor: Color(0xFF373D66),
                                textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins-Bold',
                                ),
                                backgroundColor: Color(0xFFFCBE4F),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15), 
                                ),
                              ),
                              child: const Text('View Details'),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
