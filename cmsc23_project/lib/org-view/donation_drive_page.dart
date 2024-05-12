import 'package:cmsc23_project/models/donation_drive.dart';
import 'package:cmsc23_project/org-view/base_screen.dart';
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
    return Container(
      padding: const EdgeInsets.all(20),
      child: Card(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                image: donationDrive.image,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: Text(donationDrive.name, style: CustomTextStyle.body),
            ),
          ],
        ),
      ),
    );
  }
}
