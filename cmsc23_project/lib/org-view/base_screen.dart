import 'package:cmsc23_project/models/organization.dart';
import 'package:cmsc23_project/org-view/drawer.dart';
import 'package:cmsc23_project/org-view/org_view_styles.dart';
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
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      drawer: !Navigator.canPop(context) ? const OrgDrawer() : null,
      appBar: _appBar,
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

  AppBar get _appBar => AppBar(
        iconTheme: const IconThemeData(
          color: CustomColors.primary,
        ),
        backgroundColor: Colors.transparent,
        title: _logo,
        centerTitle: true,
        actions: [_Avatar()],
      );

  Widget get _logo => const Image(
        image: AssetImage('assets/images/cmsc23_logo1.png'),
        height: 50,
        width: 50,
      );

  Widget get _backgroundImage => Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/home_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      );
}

class _Avatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Organization sampleUser =
        Provider.of<CurrentOrgProvider>(context).currentOrg;

    return InkWell(
      onTap: () {
        // Don't push the profile screen if it's already open
        if (ModalRoute.of(context)!.settings.name != "/orgProfile") {
          Navigator.pushNamed(context, "/orgProfile");
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
          backgroundImage: sampleUser.profilePic,
          backgroundColor: Colors.white,
          radius: 20,
        ),
      ),
    );
  }
}
