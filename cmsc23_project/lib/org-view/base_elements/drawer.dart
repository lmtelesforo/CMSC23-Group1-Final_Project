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
        if (ModalRoute.of(context)!.settings.name == '/org/profile') {
          Navigator.pop(context);
        } else {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/org/profile');
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
        if (ModalRoute.of(context)!.settings.name == '/org/add-a-drive') {
          Navigator.pop(context);
        } else {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/org/add-a-drive');
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
        if (ModalRoute.of(context)!.settings.name == '/org') {
          Navigator.pop(context);
        } else {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/org');
        }
      },
    );
  }
}
