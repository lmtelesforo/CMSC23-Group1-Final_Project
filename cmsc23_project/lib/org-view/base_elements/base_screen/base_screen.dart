import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23_project/models/org_signup.dart';
import 'package:cmsc23_project/org-view/base_elements/base_screen/app_bar.dart';
import 'package:cmsc23_project/org-view/base_elements/base_screen/drawer.dart';
import 'package:cmsc23_project/providers/current_org_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  // Represents the base screen of the org view (appbar + background image)
  // Needs a body widget which is the main content of the screen
  // Can have a floating action button
  final Widget body;
  final FloatingActionButton? floatingActionButton;

  const BaseScreen({super.key, required this.body, this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Avoids resizing the screen when the keyboard appears
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      // Drawer is only shown if the current screen is the home screen
      drawer: !Navigator.canPop(context) ? const OrgDrawer() : null,
      appBar: OrgAppBar(actions: [_Avatar()]).appBar,
      floatingActionButton: floatingActionButton,
      body: Stack(
        children: [
          _backgroundImage,
          SingleChildScrollView(
            child: SafeArea(
              child: body,
            ),
          ),
        ],
      ),
    );
  }

  Widget get _backgroundImage => Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/wallpaper.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      );
}

class _Avatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> org = context.read<CurrentOrgProvider>().currentOrg;

    return StreamBuilder(
      stream: org,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error');
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        Org org =
            Org.fromJson(snapshot.data!.docs[0].data() as Map<String, dynamic>);

        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: InkWell(
            onTap: () {
              // Don't push the profile screen if it's already open
              if (ModalRoute.of(context)!.settings.name != "/org/profile") {
                Navigator.pushNamed(context, "/org/profile");
              }
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 4,
                ),
              ),
              child: CircleAvatar(
                backgroundImage: NetworkImage(org.profilePic!),
                backgroundColor: Colors.white,
                radius: 20,
              ),
            ),
          ),
        );
      },
    );
  }
}
