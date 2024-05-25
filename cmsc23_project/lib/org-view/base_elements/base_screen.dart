import 'package:cmsc23_project/models/organization.dart';
import 'package:cmsc23_project/org-view/base_elements/app_bar.dart';
import 'package:cmsc23_project/org-view/base_elements/drawer.dart';
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
    Organization org = Provider.of<CurrentOrgProvider>(context).currentOrg;

    return InkWell(
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
            width: 2,
          ),
        ),
        child: CircleAvatar(
          backgroundImage: org.profilePic,
          backgroundColor: Colors.white,
          radius: 20,
        ),
      ),
    );
  }
}
