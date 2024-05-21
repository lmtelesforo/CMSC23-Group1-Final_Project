import 'package:cmsc23_project/models/donation_drive.dart';
import 'package:cmsc23_project/org-view/base_elements/base_screen.dart';
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
        context.read<CurrentOrgProvider>().drives;

    return BaseScreen(
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
                    return DonationDriveCard(donationDrive: donationDrive);
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
          onTap: () {
            Navigator.pushNamed(context, "/org/add-a-drive");
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 90,
                width: 150,
                decoration: BoxDecoration(
                  color: CustomColors.prompt,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.add,
                  size: 100,
                  color: CustomColors.primary,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text("Add a Drive", style: CustomTextStyle.body),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
