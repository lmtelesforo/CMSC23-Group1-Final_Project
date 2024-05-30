import 'package:flutter/material.dart';

class OrgDrawer extends StatelessWidget {
  const OrgDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          _HomeTile(),
          _AddDriveTile(),
          _ProfileTile(),
          _LogoutTile(),
        ],
      ),
    );
  }
}

class _LogoutTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Log Out'),
      onTap: () {
        Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
      },
    );
  }
}

class _ProfileTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Profile'),
      onTap: () {
        if (ModalRoute.of(context)!.settings.name == '/orgProfile') {
          Navigator.pop(context);
        } else {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/orgProfile');
        }
      },
    );
  }
}

class _AddDriveTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Add a Drive'),
      onTap: () {
        if (ModalRoute.of(context)!.settings.name == '/add-a-drive') {
          Navigator.pop(context);
        } else {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/add-a-drive');
        }
      },
    );
  }
}

class _HomeTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Home'),
      onTap: () {
        if (ModalRoute.of(context)!.settings.name == '/orgHomepage') {
          Navigator.pop(context);
        } else {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/orgHomepage');
        }
      },
    );
  }
}
