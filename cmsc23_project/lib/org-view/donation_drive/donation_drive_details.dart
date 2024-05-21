import 'package:cmsc23_project/models/donation_drive.dart';
import 'package:cmsc23_project/org-view/base_elements/base_screen.dart';
import 'package:cmsc23_project/org-view/donations/donation_list.dart';
import 'package:cmsc23_project/org-view/base_elements/org_view_styles.dart';
import 'package:cmsc23_project/providers/current_org_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonationDriveDetails extends StatelessWidget {
  // The screen for a single donation drive
  final DonationDrive drive;

  const DonationDriveDetails({super.key, required this.drive});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: Column(
        children: [
          ExpandedDriveCard(drive),
          DonationList(driveId: drive.id),
        ],
      ),
    );
  }
}

class ExpandedDriveCard extends StatefulWidget {
  // Represents a single donation drive card
  final DonationDrive drive;

  const ExpandedDriveCard(this.drive, {super.key});

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
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 10,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        image: widget.drive.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(widget.drive.name, style: CustomTextStyle.h1),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _status,
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      widget.drive.description,
                      style: CustomTextStyle.body,
                    ),
                  ),
                ],
              ),
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
              widget.drive.isOngoing ? 'Ongoing' : 'Ended',
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
              setState(() {
                context
                    .read<CurrentOrgProvider>()
                    .toggleFavorite(widget.drive.id);
              });
            },
            child:
                context.read<CurrentOrgProvider>().isFavorite(widget.drive.id)
                    ? const Icon(Icons.favorite, color: CustomColors.secondary)
                    : const Icon(Icons.favorite_border,
                        color: CustomColors.secondary),
          ),
        ),
      );
}
