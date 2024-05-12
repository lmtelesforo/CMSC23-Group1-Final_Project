import 'package:cmsc23_project/models/user.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  // Represents the base screen for the org view (background + header/appbar)
  const BaseScreen({super.key, required this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    User sampleUser = User(
      name: 'Donator Name 1',
      profilePic: const AssetImage('assets/images/profile_pic.jpg'),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: !Navigator.canPop(context) ? const Drawer() : null,
      appBar: AppBar(
        iconTheme: const IconThemeData(
            color: Color(0xFF373D66)), // Change color of back button (if any
        backgroundColor: Colors.transparent,
        title: const Image(
          image: AssetImage('assets/images/cmsc23_logo1.png'),
          height: 50,
          width: 50,
        ),
        centerTitle: true,
        actions: [
          CircleAvatar(
            backgroundImage: sampleUser.profilePic,
            backgroundColor: Colors.white,
            radius: 20,
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/cmsc23_background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: SafeArea(
              child: body,
            ),
          ),
        ],
      ),
    );
  }
}
