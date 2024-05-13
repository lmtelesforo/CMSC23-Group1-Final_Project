import 'package:cmsc23_project/models/donation_drive.dart';
import 'package:cmsc23_project/org-view/donation_drive_page.dart';
import 'package:cmsc23_project/org-view/org_view_styles.dart';
import 'package:flutter/material.dart';

class DonationDriveCard extends StatelessWidget {
  // Represents a donation drive card on the homepage and donation drive list
  final DonationDrive donationDrive;

  const DonationDriveCard({
    super.key,
    required this.donationDrive,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
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
              child: _cardContent,
            ),
          ),
        ),
        if (donationDrive.isFavorite) _favoriteIcon,
      ],
    );
  }

  Widget get _cardContent => Column(
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
      );

  Widget get _favoriteIcon => Positioned(
        top: 5,
        right: 5,
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
            color: CustomColors.primary,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.favorite,
            color: CustomColors.secondary,
          ),
        ),
      );
}
