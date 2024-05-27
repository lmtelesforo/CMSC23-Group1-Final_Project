import 'package:cmsc23_project/models/donation_drive.dart';
import 'package:cmsc23_project/org-view/base_elements/base_screen/base_screen.dart';
import 'package:cmsc23_project/org-view/donation_drive/donation_drive_card.dart';
import 'package:cmsc23_project/org-view/base_elements/org_view_styles.dart';
import 'package:cmsc23_project/providers/current_org_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageDonationDrives extends StatelessWidget {
  const ManageDonationDrives({super.key});

  @override
  Widget build(BuildContext context) {
    List<DonationDrive> donationDrives =
        context.watch<CurrentOrgProvider>().drives;

    return BaseScreen(
      body: Center(
        child: Column(
          children: [
            _title(),
            _cards(donationDrives),
          ],
        ),
      ),
    );
  }

  Container _title() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: const Text(
        'Donation Drives',
        style: CustomTextStyle.h1,
      ),
    );
  }

  Wrap _cards(List<DonationDrive> donationDrives) {
    return Wrap(
      children: [
        ...donationDrives.map(
          (donationDrive) {
            return DonationDriveCard(drive: donationDrive);
          },
        ),
        const AddDonationDrive(),
      ],
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
          onTap: () {
            Navigator.pushNamed(context, "/org/drives/add");
          },
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                size: 100,
                color: CustomColors.primary,
              ),
              Text("Add a Drive", style: CustomTextStyle.body),
            ],
          ),
        ),
      ),
    );
  }
}
