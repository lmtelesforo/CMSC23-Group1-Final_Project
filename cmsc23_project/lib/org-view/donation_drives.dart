import 'package:cmsc23_project/models/donation_drive.dart';
import 'package:cmsc23_project/org-view/base_view.dart';
import 'package:cmsc23_project/org-view/org_view.dart';
import 'package:cmsc23_project/org-view/org_view_styles.dart';
import 'package:flutter/material.dart';

class DonationDrives extends StatelessWidget {
  final List<DonationDrive> donationDrives;
  const DonationDrives({super.key, required this.donationDrives});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: const Text(
                'Donation Drives',
                style: CustomTextStyle.h1,
              ),
            ),
            Wrap(
              children: [
                const AddDonationDrive(),
                ...donationDrives.map(
                  (donationDrive) {
                    return DonationDriveCard(
                      onTap: () {},
                      image: donationDrive.image,
                      name: donationDrive.name,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AddDonationDrive extends StatelessWidget {
  const AddDonationDrive({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 180,
      child: Card(
        child: InkWell(
          onTap: () {},
          child: const Column(
            children: [
              Icon(Icons.add, size: 100, color: Color(0xFF373D66)),
              Text("Add a Drive", style: CustomTextStyle.body),
            ],
          ),
        ),
      ),
    );
  }
}
