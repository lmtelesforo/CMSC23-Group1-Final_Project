import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23_project/admin_view/indiv_approve_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/org_signup.dart';
import '../models/user_signup.dart';
import '../providers/firebase_provider.dart';
import '../providers/textfield_providers.dart';

class ApproveOrgSignups extends StatefulWidget {
  const ApproveOrgSignups({super.key});

  @override
  State<ApproveOrgSignups> createState() => _ApproveOrgSignupsState();
}

class _ApproveOrgSignupsState extends State<ApproveOrgSignups> {
  final _formKey = GlobalKey<FormState>(); 

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TextfieldProviders>();

    Stream<QuerySnapshot> userStream = context.watch<UserInfosProvider>().allSignUpReqs;

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
              top: MediaQuery.of(context).size.height * 0.12, 
              left: 0,
              right: 0,
              child: const Padding(
                padding: EdgeInsets.all(17),
                child: Text(
                  "Pending Organization Sign ups",
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
              top: MediaQuery.of(context).size.height * 0.26,
              left: 0,
              right: 0,
              bottom: MediaQuery.of(context).size.height * 0.057,
              child: SingleChildScrollView(
                child: Container(
                height: MediaQuery.of(context).size.height * 0.7, 
                width: MediaQuery.of(context).size.width*0.8,
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                        stream: userStream,
                        builder: (context, snapshot) {
                          print("Connection State: ${snapshot.connectionState}"); // debug
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("Error encountered: ${snapshot.error}"),
                            );
                          } 
                          else if (snapshot.connectionState == ConnectionState.waiting) {
                            context.read<UserInfosProvider>().fetchSignUpRequests(); // reload snapshots
                            return Center(
                              child: CircularProgressIndicator(),
                            ); // display loading circle until it succeeds
                          } 
                        
                        List<DocumentSnapshot> orgDetails = (snapshot.data as QuerySnapshot)
                          .docs
                          .where((user) => (user.data() as Map<String, dynamic>)['userType'] == 'organization') 
                          .toList();

                        if (orgDetails.isEmpty) { // if no orgs, display message
                          return const Center(
                            child: Text("No Sign Up Requests Yet",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins-Bold',
                              color: Color(0xFF373D66)
                              )
                            ),
                          );
                        }

                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: orgDetails.length,
                          itemBuilder: (context, index) {
                            print('Request at index $index: ${orgDetails[index].data()}'); 
                            Org org = Org.fromJson(orgDetails[index].data() as Map<String, dynamic>);
                            org.id = orgDetails[index].id;

                            return Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 28),
                              child: ListTile(
                                contentPadding: EdgeInsets.only(top: 2, left: 10, bottom: 2, right: 13),
                                title: Text(
                                  org.name, 
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Poppins-Bold',
                                    color: Color(0xFF373D66),
                                  ),
                                ),
                                subtitle: Text(
                                  org.contactNumber,
                                  style: TextStyle(
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
                                        builder: (context) => OrgRequestPage(orgDetails: orgDetails[index]),
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
                        );
                        },
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
}
