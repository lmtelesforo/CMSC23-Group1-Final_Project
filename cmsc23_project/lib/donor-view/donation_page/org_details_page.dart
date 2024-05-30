import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrgDetailsPageWidget extends StatefulWidget {
  final String orgName;
  final String orgUsername;

  OrgDetailsPageWidget({
    required this.orgName,
    required this.orgUsername,
  });

  @override
  _OrgDetailsPageWidgetState createState() => _OrgDetailsPageWidgetState();
}

class _OrgDetailsPageWidgetState extends State<OrgDetailsPageWidget> {
  Org? orgDetails;
  List<DonationDrive> ongoingDrives = [];

  @override
  void initState() {
    super.initState();
    fetchOrgDetails(widget.orgUsername);
    fetchOngoingDonationDrives(widget.orgUsername);
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
      // Handle error
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
      // Handle error
    }
  }


  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: orgDetails != null ? AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(orgDetails!.name,
          style: TextStyle(
            color: const Color.fromRGBO(55, 61, 102, 1),
            fontFamily: 'Montserrat',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: const Color.fromRGBO(55, 61, 102, 1)), 
      ) : null, 
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
                              children: ongoingDrives
                                  .map((drive) => Text('${drive.name}', 
                                  style: TextStyle(
                                    color: const Color.fromRGBO(55, 61, 102, 1),
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                  )))
                                  .toList(),
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
          )
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

class DonationDrive {
  final String orgUsername;
  final String name;
  final String description;
  final bool isOngoing;
  final bool isFavorite;

  DonationDrive({
    required this.orgUsername,
    required this.name,
    required this.description,
    required this.isOngoing,
    required this.isFavorite,
  });

  factory DonationDrive.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DonationDrive(
      orgUsername: data['orgUsername'],
      name: data['name'],
      description: data['description'],
      isOngoing: data['isOngoing'],
      isFavorite: data['isFavorite'],
    );
  }
}