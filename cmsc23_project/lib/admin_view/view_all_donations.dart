import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23_project/admin_view/indiv_view_all_donations.dart';
import 'package:cmsc23_project/providers/donation_storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/indiv_donation.dart';
import '../providers/textfield_providers.dart';

class AdminViewAllDonations extends StatefulWidget {
  const AdminViewAllDonations({super.key});

  @override
  State<AdminViewAllDonations> createState() => _AdminViewAllDonationsState();
}

class _AdminViewAllDonationsState extends State<AdminViewAllDonations> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TextfieldProviders>();
    final firebaseUsers = context.watch<DonationStorageProvider>();

    firebaseUsers.printAllDonations();
    Stream<QuerySnapshot> donationStream =
        context.watch<DonationStorageProvider>().allDonations;

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
                  image:
                      AssetImage('lib/user_view/assets/cmsc23_background.png'),
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
                "All Donations",
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
            top: MediaQuery.of(context).size.height * 0.19,
            left: 0,
            right: 0,
            child: const Padding(
              padding: EdgeInsets.all(19),
              child: Text(
                "See Pending, Confirmed, Scheduled, Complete, and Cancelled Donations",
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  color: Color(0xFF373D66),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.28,
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).size.height * 0.047,
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: donationStream,
                        builder: (context, snapshot) {
                          print(
                              "Connection State: ${snapshot.connectionState}"); // debug
                          if (snapshot.hasError) {
                            return Center(
                              child:
                                  Text("Error encountered: ${snapshot.error}"),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            context
                                .read<DonationStorageProvider>()
                                .fetchDonations(); // reload snapshots
                            return Center(
                              child: CircularProgressIndicator(),
                            ); // display loading circle until it succeeds
                          }

                          List<DocumentSnapshot> donationDetails =
                              snapshot.data?.docs ?? [];

                          if (donationDetails.isEmpty) {
                            // if no donationDetails, display message
                            return const Center(
                              child: Text(
                                "No Donations Yet",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins-Bold',
                                  color: Color(0xFF373D66),
                                ),
                              ),
                            );
                          }

                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: AlwaysScrollableScrollPhysics(),
                            itemCount: donationDetails.length,
                            itemBuilder: (context, index) {
                              print(
                                  'Request at index $index: ${donationDetails[index].data()}');
                                  
                              Donation donation = Donation.fromJson(
                                  donationDetails[index].data()
                                      as Map<String, dynamic>);
                             
                              donation.id = donationDetails[index].id;
                              String subtitle = '\n' + 'Org: ' + donation.organization + '\n' + 'Donor: ' + donation.email + '\n' + 'Status: '+ donation.status;

                              return Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFFFFF),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                margin: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 28),
                                child: ListTile(
                                  contentPadding: EdgeInsets.only(
                                      top: 2, left: 10, bottom: 2, right: 13),
                                  title: Text(
                                    'Drive: ${donation.driveName}',
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'Poppins-Bold',
                                      color: Color(0xFF373D66),
                                    ),
                                  ),
                                  subtitle: Text(
                                    subtitle,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontFamily: 'Poppins-Reg',
                                    ),
                                  ),
                                  trailing: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              IndivViewAllDonations(
                                                  donationDetails:
                                                      donationDetails[index]),
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
    ));
  }
}
