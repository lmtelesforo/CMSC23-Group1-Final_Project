import 'package:cmsc23_project/models/donation_drive.dart';
import 'package:cmsc23_project/org-view/donation_drive/donation_drive_details.dart';
import 'package:cmsc23_project/org-view/base_elements/org_view_styles.dart';
import 'package:cmsc23_project/providers/current_org_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonationDriveCard extends StatelessWidget {
  // Represents a donation drive card on the homepage and donation drive list
  final DonationDrive drive;

  const DonationDriveCard({
    super.key,
    required this.drive,
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
                    builder: (context) => DonationDriveDetails(
                      drive: drive,
                    ),
                  ),
                );
              },
              child: _cardContent,
            ),
          ),
        ),
        if (context.read<CurrentOrgProvider>().isFavorite(drive.id))
          _favoriteIcon,
      ],
    );
  }

  Widget get _cardContent => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image(
              image: drive.image,
              height: 90,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(drive.name, style: CustomTextStyle.body),
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
