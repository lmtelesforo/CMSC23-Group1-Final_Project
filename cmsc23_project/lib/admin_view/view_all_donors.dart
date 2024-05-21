import 'package:cmsc23_project/admin_view/indiv_view_all_donors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_signup.dart';
import '../providers/textfield_providers.dart';

class AdminViewAllDonors extends StatefulWidget {
  const AdminViewAllDonors({super.key});

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
              top: MediaQuery.of(context).size.height * 0.13, 
              left: 0,
              right: 0,
              child: const Padding(
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
                    const SizedBox(height: 10),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: donors.length,
                      itemBuilder: (context, index) {
                        User donor = donors[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(15), 
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 28),
                          child: ListTile(
                            contentPadding: const EdgeInsets.only(top: 2, left: 10, bottom: 2, right: 13),
                            title: Text(
                              donor.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontFamily: 'Poppins-Bold',
                                color: Color(0xFF373D66),
                              ),
                            ),
                            subtitle: Text(
                              donor.contactNumber,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontFamily: 'Poppins-Reg',
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
                                foregroundColor: const Color(0xFF373D66),
                                textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Poppins-Bold',
                                ),
                                backgroundColor: const Color(0xFFFCBE4F),
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
