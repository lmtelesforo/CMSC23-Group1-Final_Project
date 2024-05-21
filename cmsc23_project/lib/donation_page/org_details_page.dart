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
        ],
      ),
    );
  }
}
