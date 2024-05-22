import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_signup.dart';
import '../providers/firebase_provider.dart';
import '../providers/textfield_providers.dart';

class IndivViewAllDonors extends StatefulWidget {
  final DocumentSnapshot userDetails;

  const IndivViewAllDonors({Key? key, required this.userDetails}) : super(key: key);

  @override
  State<IndivViewAllDonors> createState() => _IndivViewAllDonorsState();
}

class _IndivViewAllDonorsState extends State<IndivViewAllDonors> {
  late User user; 

  @override
  void initState() {
    super.initState();
    user = User.fromJson(widget.userDetails.data() as Map<String, dynamic>);
    user.id = widget.userDetails.id;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TextfieldProviders>();

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
                Navigator.pushNamed(context, "/viewAllDonors");
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
                "Donor Details",
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
                                user.name,
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
                                user.username,
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
                                    user.addresses.first,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins-Reg',
                                      color: Color(0xFF373D66),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            (user.addresses.length > 1)
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
                                user.contactNumber,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins-Reg',
                                  color: Color(0xFF373D66),
                                ),
                              ),
                            ),
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
            bottom: MediaQuery.of(context).size.height * 0.25,
            left: (MediaQuery.of(context).size.width - 250) / 2, // center
            child: ElevatedButton.icon(
              onPressed: () {
                final userService = Provider.of<UserInfosProvider>(context, listen: false);

                userService.deleteUser(user.email); // delete org

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${user.name} deleted!'),
                  ),
                );
                Navigator.pop(context);
                Navigator.pushNamed(context, "/viewAllDonors");
              },
              icon: Icon(
                Icons.clear,
                color: Color(0xFFFCBE4F),
              ),
              label: Text(
                'Delete Donor',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Poppins-Bold',
                  color: Color(0xFFFCBE4F),
                ),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(250, 50),
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins-Bold',
                ),
                backgroundColor: Color.fromARGB(255, 190, 58, 58),
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
        user.addresses.length - 1,
        (index) {
          return Padding(
            padding: EdgeInsets.only(left: 106), 
            child: Text(
              user.addresses[index + 1],
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
