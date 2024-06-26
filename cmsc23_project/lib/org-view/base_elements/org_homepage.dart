import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23_project/org-view/base_elements/base_screen/base_screen.dart';
import 'package:cmsc23_project/org-view/donation_drive/donation_drive_card.dart';
import 'package:cmsc23_project/org-view/donations/donation_list.dart';
import 'package:cmsc23_project/org-view/base_elements/org_view_styles.dart';
import 'package:cmsc23_project/providers/current_org_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrgHomePage extends StatelessWidget {
  // Main homepage for the organization
  const OrgHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseScreen(
      body: Column(
        children: [
          MainAction(),
          Favorites(),
          DonationList(),
        ],
      ),
    );
  }
}

class MainAction extends StatelessWidget {
  // The main/leading card on the org homepage
  const MainAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Card(
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/org/drives');
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _text,
                  _image,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get _text => const Flexible(
        child: Text(
          'Organize your donation drives',
          style: CustomTextStyle.mainAction,
        ),
      );

  Widget get _image => const Image(
        image: AssetImage('images/icon.png'),
        height: 80,
        width: 80,
      );
}

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: context.read<CurrentOrgProvider>().favoriteDrives,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('An error occurred');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final favorites = snapshot.data!.docs;

          return Visibility(
            visible: favorites.isNotEmpty,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final totalWidth = favorites.length * 200;

                return Container(
                  height: 150,
                  padding: const EdgeInsets.only(bottom: 10),
                  // if the cards can fit in the screen, display them in a row
                  // otherwise, display them in a horizontal list
                  child: totalWidth < constraints.maxWidth
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: favorites.map((favorite) {
                            return DonationDriveCard(favorite.id);
                          }).toList(),
                        )
                      : ListView.builder(
                          itemCount: favorites.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: DonationDriveCard(favorites[index].id),
                            );
                          },
                        ),
                );
              },
            ),
          );
        });
  }
}
