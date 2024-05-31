import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23_project/donor-view/donation_page/donor_page.dart';
import 'package:cmsc23_project/donor-view/donation_page/drive_detail_page.dart';
import 'package:cmsc23_project/models/donation_drive.dart';
import 'package:flutter/material.dart';

class OrgDetailsPageWidget extends StatefulWidget {
  final String orgName;
  final String orgUsername;
  final Map<String, dynamic> donorDetails;

  OrgDetailsPageWidget({
    required this.orgName,
    required this.orgUsername,
    required this.donorDetails
  });

  @override
  _OrgDetailsPageWidgetState createState() => _OrgDetailsPageWidgetState();
}

class _OrgDetailsPageWidgetState extends State<OrgDetailsPageWidget> {
  Org? orgDetails;
  List<DonationDrive> ongoingDrives = [];
  late Map<String, dynamic> donorDetails;

  @override
  void initState() {
    super.initState();
    donorDetails = widget.donorDetails;
    fetchData();
  }


  void fetchData() async {
    await fetchOrgDetails(widget.orgUsername);
    await fetchOngoingDonationDrives(widget.orgUsername);
  }

  Future<void> fetchOrgDetails(String orgUsername) async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: orgUsername)
          .where('userType', isEqualTo: 'organization')
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          orgDetails = Org.fromSnapshot(snapshot.docs.first);
        });
      }
    } catch (e) {
      print('Error fetching organization details: $e');
    }
  }

  Future<void> fetchOngoingDonationDrives(String orgUsername) async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('drives')
          .where('orgUsername', isEqualTo: orgUsername)
          .where('isOngoing', isEqualTo: true)
          .get();

      setState(() {
        ongoingDrives =
            snapshot.docs.map((doc) => DonationDrive.fromSnapshot(doc)).toList();
      });
    } catch (e) {
      print('Error fetching ongoing donation drives: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    String orgUsername;


    return Scaffold(
      appBar: orgDetails != null
        ? AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  orgDetails!.name,
                  style: TextStyle(
                    color: const Color.fromRGBO(55, 61, 102, 1),
                    fontFamily: 'Montserrat',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: screenSize.height * 0.02),
                SizedBox(
                  width: 40,
                  height: 40,
                  child: Image.asset('images/logo.png'),
                ),
              ],
            ),
            iconTheme:
                IconThemeData(color: const Color.fromRGBO(55, 61, 102, 1)),
          )
        : null, 
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Column(
            children: [
              Image.asset('images/organization.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: screenSize.height * 0.40,
              ),
              SizedBox(height: screenSize.height * 0.1),
            ],
          ),
          Positioned.fill(
            top: screenSize.height * 0.38,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (orgDetails != null) 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'About:',
                            style: TextStyle(
                              color: const Color.fromRGBO(55, 61, 102, 1),
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.02),
                          Text(
                            orgDetails!.about ?? 'No information available',
                            style: TextStyle(
                              color: const Color.fromRGBO(55, 61, 102, 1),
                              fontSize: 16,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.02),
                          Text(
                            'Ongoing Donation Drivers:',
                            style: TextStyle(
                              color: const Color.fromRGBO(55, 61, 102, 1),
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: screenSize.height * 0.02),
                          if (ongoingDrives.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: ongoingDrives.map((drive) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DriveDetailsPage(
                                        orgUsername: drive.orgUsername,
                                        name: drive.name 
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  '${drive.name}',
                                  style: TextStyle(
                                    color: const Color.fromRGBO(55, 61, 102, 1),
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              );
                            }).toList(),
                          )
                        else
                          Text(
                            'No ongoing donation drives found.',
                            style: TextStyle(
                              color: const Color.fromRGBO(55, 61, 102, 1),
                              fontSize: 16,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            )
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20, // adjust the value as needed
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DonorPage(
                        organization: orgDetails!.name,
                        donorDetails: donorDetails,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: screenSize.width * 0.8,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(252, 190, 79, 1),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Center(
                    child: Text(
                      'Send Donation',
                      style: TextStyle(
                        color: const Color.fromRGBO(55, 61, 102, 1),
                        fontSize: 16,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}

class Org {
  final String name;
  final String? about;

  Org({
    required this.name,
    this.about,
  });

  factory Org.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Org(
      name: data['name'],
      about: data['about'],
    );
  }
}
