import 'package:cmsc23_project/models/donation_drive.dart';
import 'package:cmsc23_project/org-view/base_elements/base_screen.dart';
import 'package:cmsc23_project/org-view/donations/donation_list.dart';
import 'package:cmsc23_project/org-view/base_elements/org_view_styles.dart';
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
          ExpandedDriveCard(donationDrive),
          const DonationList(),
        ],
      ),
    );
  }
}

class ExpandedDriveCard extends StatefulWidget {
  // Represents a single donation drive card
  final DonationDrive donationDrive;

  const ExpandedDriveCard(this.donationDrive, {super.key});

  @override
  State<ExpandedDriveCard> createState() => _ExpandedDriveCardState();
}

class _ExpandedDriveCardState extends State<ExpandedDriveCard> {
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
                      image: widget.donationDrive.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(widget.donationDrive.name, style: CustomTextStyle.h1),
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
        _favoriteIcon,
      ],
    );
  }

  Widget get _status => Row(
        children: [
          const Icon(Icons.schedule, color: CustomColors.secondary),
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              widget.donationDrive.isOngoing ? 'Ongoing' : 'Ended',
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
          child: InkWell(
            onTap: () {
              setState(() {});
            },
            child: const Icon(Icons.favorite_border,
                color: CustomColors.secondary),
          ),
        ),
      );
}
