import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;
  late String name = '';
  late String email = '';
  late String contactNumber = '';
  late List<String> addresses = [];

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      setState(() {
        user = currentUser;
      });

      try {
        // Fetch user info from Firestore based on email
        final snapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: currentUser.email)
            .get();
        
        if (snapshot.docs.isNotEmpty) {
          final userData = snapshot.docs.first.data() as Map<String, dynamic>;
          setState(() {
            name = userData['name'];
            email = userData['email'];
            contactNumber = userData['contactNumber'];
            addresses = List<String>.from(userData['addresses'] ?? []);
          });
        }
      } catch (error) {
        print('Error fetching user info: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: const Color.fromRGBO(55, 61, 102, 1)),
        title: const Text(
          "Profile",
          style: TextStyle(
            fontFamily: "Montserrat",
            color: const Color.fromRGBO(55, 61, 102, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Column(
            children: [
              Image.asset(
                'images/wallpaper.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: screenSize.height * 0.40, // Adjusted height
              ),
              SizedBox(height: screenSize.height * 0.1), // Adjusted height
            ],
          ),
          Positioned(
            top: screenSize.height * 0.14, // Adjusted position
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 3.0,
                  ),
                ),
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/profile_pic.jpg"),
                  radius: screenSize.width * 0.20, // Adjusted radius
                ),
              ),
            ),
          ),
          Positioned.fill(
            top: screenSize.height * 0.38, // Adjusted position
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
                    if (user != null) ...[
                      SizedBox(height: screenSize.height * 0.04), // Adjusted height
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(name, style: const TextStyle(
                            fontSize: 20, 
                            fontFamily: 'Poppins', 
                            color: const Color.fromRGBO(55, 61, 102, 1)
                            )),
                        ],
                      ),
                      SizedBox(height: screenSize.height * 0.02), // Adjusted height
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(email, style: const TextStyle(
                            fontSize: 20, 
                            fontFamily: 'Poppins',
                            color: const Color.fromRGBO(55, 61, 102, 1)
                            )),
                        ],
                      ),
                      SizedBox(height: screenSize.height * 0.02), // Adjusted height
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(contactNumber, style: const TextStyle(
                            fontSize: 20, 
                            fontFamily: 'Poppins',
                            color: const Color.fromRGBO(55, 61, 102, 1)
                            )),
                        ],
                      ),
                      SizedBox(height: screenSize.height * 0.02), // Adjusted height
                      if (addresses.isNotEmpty) ...[
                        for (var address in addresses) 
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(address, style: const TextStyle(
                                fontSize: 20, 
                                fontFamily: 'Poppins',
                                color: const Color.fromRGBO(55, 61, 102, 1)
                                )),
                            ],
                          ),
                      ] else
                        Text("No addresses found"),
                      SizedBox(height: screenSize.height * 0.04), // Adjusted height
                    ] else
                      CircularProgressIndicator(),
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