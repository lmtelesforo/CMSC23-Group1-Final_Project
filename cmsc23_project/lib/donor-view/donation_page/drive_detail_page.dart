import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../providers/textfield_providers.dart';
import '../../models/donation_drive.dart';

class DriveDetailsPage extends StatefulWidget {
  final String orgUsername;
  final String name;

  const DriveDetailsPage({Key? key, required this.orgUsername, required this.name}) : super(key: key);

  @override
  _DriveDetailsPageState createState() => _DriveDetailsPageState();
}

class _DriveDetailsPageState extends State<DriveDetailsPage> {
  DonationDrive? drive;

  @override
  void initState() {
    super.initState();
    fetchDriveDetails();
  }

  void fetchDriveDetails() async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('drives')
          .where('orgUsername', isEqualTo: widget.orgUsername)
          .where('name', isEqualTo: widget.name)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          drive = DonationDrive.fromSnapshot(snapshot.docs.first);
        });
      }
    } catch (e) {
      print('Error fetching drive details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drive Details',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Poppins-Bold',
            color: Color(0xFF373D66),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme:
            IconThemeData(color: const Color.fromRGBO(55, 61, 102, 1), size: 30),
      ),
      body: drive == null ? Center(child: CircularProgressIndicator()) : buildDriveDetails(),
    );
  }

  Widget buildDriveDetails() {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'lib/user_view/assets/cmsc23_background.png',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.12,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Text(
              '${drive!.name}',
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
          top: MediaQuery.of(context).size.height * 0.22,
          left: 0,
          right: 0,
          bottom: MediaQuery.of(context).size.height * 0.057,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Text(
                    '${drive!.description}',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins-Bold',
                      color: Color(0xFF373D66),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${drive!.isOngoing ? 'Ongoing' : 'Not Ongoing'}',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Poppins-Bold',
                      color: Color(0xFF373D66),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
