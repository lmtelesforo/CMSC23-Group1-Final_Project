import 'package:flutter/material.dart';

class OrgDrawer extends StatelessWidget {
  const OrgDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        ListTile(
          title: const Text('Home'),
          onTap: () {
            if (ModalRoute.of(context)!.settings.name == '/orgHomepage') {
              Navigator.pop(context);
            } else {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/orgHomepage');
            }
          },
        ),
        ListTile(
          title: const Text('Add a Drive'),
          onTap: () {
            if (ModalRoute.of(context)!.settings.name == '/add-a-drive') {
              Navigator.pop(context);
            } else {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/add-a-drive');
            }
          },
        ),
        ListTile(
          title: const Text('Profile'),
          onTap: () {
            if (ModalRoute.of(context)!.settings.name == '/orgProfile') {
              Navigator.pop(context);
            } else {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/orgProfile');
            }
          },
        ),
        ListTile(
          title: const Text('Log Out'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/');
          },
        ),
      ],
    ));
  }
}
