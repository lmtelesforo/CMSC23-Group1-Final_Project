import 'package:cmsc23_project/models/donation_drive.dart';
import 'package:cmsc23_project/models/organization.dart';
import 'package:cmsc23_project/org-view/base_view.dart';
import 'package:cmsc23_project/org-view/donation_drives.dart';
import 'package:cmsc23_project/org-view/org_view_styles.dart';
import 'package:flutter/material.dart';

class OrgHomePage extends StatelessWidget {
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

    return BaseView(
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
                  builder: (context) => DonationDrives(
                    donationDrives: donationDrives,
                  ),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Row(
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
                  DonationDriveCard(
                    onTap: () {},
                    image: donationDrive.image,
                    name: donationDrive.name,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DonationDriveCard extends StatelessWidget {
  final Function() onTap;
  final ImageProvider image;
  final String name;

  const DonationDriveCard({
    super.key,
    required this.onTap,
    required this.image,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 180,
      child: Card(
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  image: image,
                  height: 90,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(name, style: CustomTextStyle.body),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
