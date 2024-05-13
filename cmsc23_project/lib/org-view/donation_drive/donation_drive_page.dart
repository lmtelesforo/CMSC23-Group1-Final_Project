import 'package:cmsc23_project/models/donation_drive.dart';
import 'package:cmsc23_project/org-view/base_screen.dart';
import 'package:cmsc23_project/org-view/donation_drive_card.dart';
import 'package:cmsc23_project/org-view/org_view_styles.dart';
import 'package:flutter/material.dart';

class DonationDriveScreen extends StatelessWidget {
  // The screen for a single donation drive
  final DonationDrive donationDrive;

  const DonationDriveScreen({super.key, required this.donationDrive});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: Column(
        children: [
          ExpandedDriveCard(donationDrive: donationDrive),
          DonationList(donationDrive.donations),
        ],
      ),
    );
  }
}

class ExpandedDriveCard extends StatelessWidget {
  // Represents a single donation drive card
  final DonationDrive donationDrive;

  const ExpandedDriveCard({super.key, required this.donationDrive});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: Card(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: donationDrive.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(donationDrive.name, style: CustomTextStyle.h1),
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _status,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (donationDrive.isFavorite) _favoriteIcon,
      ],
    );
  }

  Widget get _status => Row(
        children: [
          const Icon(Icons.schedule, color: CustomColors.secondary),
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              donationDrive.status,
              style: CustomTextStyle.body,
            ),
          ),
        ],
      );

  Widget get _favoriteIcon => Positioned(
        top: 25,
        right: 25,
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
            color: CustomColors.primary,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.favorite, color: CustomColors.secondary),
        ),
      );
}
