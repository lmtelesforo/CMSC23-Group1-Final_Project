import 'package:cmsc23_project/models/donation_drive.dart';
import 'package:cmsc23_project/models/organization.dart';
import 'package:cmsc23_project/org-view/base_screen.dart';
import 'package:cmsc23_project/org-view/donations/donation_drive_card.dart';
import 'package:cmsc23_project/org-view/donation_drive/manage_donation_drives.dart';
import 'package:cmsc23_project/org-view/org_view_styles.dart';
import 'package:flutter/material.dart';

class OrgHomePage extends StatelessWidget {
  // Main homepage for the organization
  const OrgHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Test data
    final Organization org = Organization(
      name: 'Organization 1',
      username: 'org1',
      addresses: ['Address 1'],
      contactNo: '1234567890',
      profilePic: const AssetImage('assets/images/org_profile.png'),
      donationDrives: [
        DonationDrive(
          name: 'Donation Drive 1',
          image: const AssetImage('assets/images/donation_drive.jpg'),
        ),
        DonationDrive(
          name: 'Donation Drive 2',
          image: const AssetImage('assets/images/donation_drive.jpg'),
        ),
        DonationDrive(
          name: 'Donation Drive 3',
          image: const AssetImage('assets/images/donation_drive.jpg'),
        ),
      ],
    );
    org.donationDrives[2].end();

    return BaseScreen(
      body: Column(
        children: [
          MainAction(org.donationDrives),
          const Favorites([]),
          const DonationList([]),
        ],
      ),
    );
  }
}

class MainAction extends StatelessWidget {
  // The main/leading card on the org homepage
  final List<DonationDrive> donationDrives;
  const MainAction(this.donationDrives, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Card(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ManageDonationDrives(
                    donationDrives: donationDrives,
                  ),
                ),
              );
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
        image: AssetImage('assets/images/xmas_box.png'),
        height: 80,
        width: 80,
      );
}

class Favorites extends StatelessWidget {
  // List of favorited donation drives
  final List<DonationDrive> favorites;
  const Favorites(this.favorites, {super.key});

  @override
  Widget build(BuildContext context) {
    // Favorites are centered using row if they can fit in the parent container
    // Otherwise, they are built with a horizontal, scrollable listview
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final totalWidth = favorites.length * (200);

        return Container(
          height: 200,
          padding: const EdgeInsets.only(bottom: 10),
          child: totalWidth < constraints.maxWidth
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: favorites.map((favorite) {
                    return DonationDriveCard(donationDrive: favorite);
                  }).toList(),
                )
              : ListView.builder(
                  itemCount: favorites.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: DonationDriveCard(donationDrive: favorites[index]),
                    );
                  },
                ),
        );
      },
    );
  }
}
