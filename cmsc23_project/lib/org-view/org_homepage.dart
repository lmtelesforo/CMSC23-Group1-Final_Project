import 'package:cmsc23_project/models/donation_drive.dart';
import 'package:cmsc23_project/models/organization.dart';
import 'package:cmsc23_project/org-view/base_screen.dart';
import 'package:cmsc23_project/org-view/donation_drive_page.dart';
import 'package:cmsc23_project/org-view/manage_donation_drives.dart';
import 'package:cmsc23_project/org-view/org_view_styles.dart';
import 'package:flutter/material.dart';

class OrgHomePage extends StatelessWidget {
  // Main homepage for the organization
  const OrgHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Organization org = Organization(
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
      ],
    );
    org.favorite(org.donationDrives[0]);

    return BaseScreen(
      body: Column(
        children: [
          MainAction(org.donationDrives),
          Favorites(org.favorites),
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
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      'Organize your donation drives',
                      style: CustomTextStyle.mainAction,
                    ),
                  ),
                  Image(
                    image: AssetImage('assets/images/xmas_box.png'),
                    height: 80,
                    width: 80,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Favorites extends StatelessWidget {
  // List of favorited donation drives
  final List<DonationDrive> favorites;
  const Favorites(this.favorites, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Wrap(
              children: [
                for (final donationDrive in favorites)
                  DonationDriveCard(donationDrive: donationDrive),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DonationDriveCard extends StatelessWidget {
  // Represents a donation drive card on the homepage and donation drive list
  final DonationDrive donationDrive;

  const DonationDriveCard({
    super.key,
    required this.donationDrive,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 180,
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DonationDriveScreen(
                  donationDrive: donationDrive,
                ),
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  image: donationDrive.image,
                  height: 90,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(donationDrive.name, style: CustomTextStyle.body),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
