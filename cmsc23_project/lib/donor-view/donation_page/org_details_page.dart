import 'package:cmsc23_project/donor-view/donation_page/donor_page.dart';
import 'package:flutter/material.dart';

class OrgDetailsPage extends StatelessWidget {
  final String organization;
  final Map<String, String> organizationDetails; 
  final Map<String, dynamic> donorDetails;

  const OrgDetailsPage({super.key, required this.organization, required this.organizationDetails, required this.donorDetails});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    String allDetails = organizationDetails.values.join('\n');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,  
        iconTheme: IconThemeData(color: const Color.fromRGBO(55, 61, 102, 1)),  
      ),
      extendBodyBehindAppBar: true,  
      body: Stack(
        children: [
          Column(
            children: [
              Image.asset(
                'images/organization.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: screenSize.height * 0.40, // Adjusted height
              ),
              SizedBox(height: screenSize.height * 0.1),  
            ],
          ),
          Positioned.fill(
            top: screenSize.height * 0.35,  // Adjusted position
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenSize.height * 0.01),
                    Text(
                      organization,
                      style: const TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.04),
                    Text(
                      allDetails,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontFamily: "Montserrat",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: screenSize.height * 0.2, // Adjusted position
            left: screenSize.width * 0.18, // Adjusted position
            right: screenSize.width * 0.18, // Adjusted position
            child: GestureDetector(
              onTap: () {
                // Handle onTap
              },
              child: Container(
                height: screenSize.height * 0.25, // Adjusted height
                width: screenSize.width * 0.3, // Adjusted width
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10), 
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15), 
                        child: Image.asset(
                          'assets/images/donation_drive.jpg', 
                          fit: BoxFit.contain, 
                          width: double.infinity, 
                        ),
                      ),
                    ),
                    SizedBox(height: 1),
                    Text(
                      'Donation Drive 1',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Montserrat",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: screenSize.height * 0.04),  
          Positioned(
            bottom: screenSize.height * 0.02,  
            left: screenSize.width * 0.1,  
            right: screenSize.width * 0.1,  
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DonorPage(organization: organization, donorDetails: donorDetails)),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(252, 190, 79, 1),
                textStyle: const TextStyle(
                  fontSize: 16,
                ),
                padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.2, vertical: screenSize.height * 0.01),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              child: const Text(
                'Send Donation', 
                style: TextStyle(
                  color: Colors.white, 
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
