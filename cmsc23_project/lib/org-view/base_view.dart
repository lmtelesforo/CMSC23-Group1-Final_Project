import 'package:flutter/material.dart';

class BaseView extends StatelessWidget {
  const BaseView({super.key, required this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const Drawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Image(
          image: AssetImage('assets/images/cmsc23_logo1.png'),
          height: 50,
          width: 50,
        ),
        centerTitle: true,
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/profile_pic.jpg'),
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
