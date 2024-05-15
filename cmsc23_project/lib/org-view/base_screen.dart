import 'package:cmsc23_project/models/user.dart';
import 'package:cmsc23_project/org-view/org_view_styles.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  // Represents the base screen of the org view (appbar + background image)

  final User sampleUser = User(
    name: 'Sample User',
    profilePic: const AssetImage('assets/images/profile_pic.jpg'),
  );
  final Widget body;
  final FloatingActionButton? floatingActionButton;

  BaseScreen({super.key, required this.body, this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      drawer: !Navigator.canPop(context) ? const Drawer() : null,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: CustomColors.primary,
        ),
        backgroundColor: Colors.transparent,
        title: _logo,
        centerTitle: true,
        actions: [_Avatar(sampleUser: sampleUser)],
      ),
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
  const _Avatar({
    required this.sampleUser,
  });

  final User sampleUser;

  @override
  Widget build(BuildContext context) {
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
