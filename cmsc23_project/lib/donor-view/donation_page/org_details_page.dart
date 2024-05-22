import 'package:cmsc23_project/donor-view/donation_page/donor_page.dart';
import 'package:flutter/material.dart';

class OrgDetailsPage extends StatelessWidget {
  final String organization;
  final Map<String, String> organizationDetails; // New field for organization details
  
  OrgDetailsPage({required this.organization, required this.organizationDetails});

  @override
  Widget build(BuildContext context) {
    String allDetails = organizationDetails.values.join('\n');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,  // Removes the shadow
        title: Text(
          'Organization Details',
          style: TextStyle(
            color: const Color.fromRGBO(55, 61, 102, 1),  // Ensure the title is visible
            fontFamily: 'Montserrat',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: const Color.fromRGBO(55, 61, 102, 1)),  // Ensure back button is visible
      ),
      extendBodyBehindAppBar: true,  // Extends the body behind the AppBar
      body: Stack(
        children: [
          Column(
            children: [
              Image.asset(
                'images/$organization.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 380,  // Increased height to occupy more space
              ),
              SizedBox(height: 80),  // Adjusted for spacing of the container
            ],
          ),
          Positioned(
            top: 340,  // Adjust the value to control overlap
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
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      organization,
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20), 
                    Text(
                      allDetails,
                      style: TextStyle(
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
            bottom: 120,
            left: 100,
            right: 100,
            child: GestureDetector(
              onTap: () {
                // Handle onTap
              },
              child: Container(
                height: 175,
                width: 100, // Adjusted width for better fit
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10), // Add margin to the container holding the image
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15), // Adjusted borderRadius
                        child: Image.asset(
                          'assets/images/donation_drive.jpg', // Replace with your donation image
                          fit: BoxFit.cover, // Adjusted fit property
                          width: double.infinity, // Ensures the image fills the width
                        ),
                      ),
                    ),
                    SizedBox(height: 1), // Adjusted spacing
                    Text(
                      'Donation Drive 1',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Montserrat",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 16), // Added space between image and button
          Positioned(
            bottom: 20,
            left: 25,
            right: 25,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DonorPage(organization: organization)),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(252, 190, 79, 1),
                textStyle: TextStyle(
                  fontSize: 16,
                ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              child: Text(
                'Send Donation', 
                style: TextStyle(
                  color: Colors.white, 
                  fontFamily: "Montserrat",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
