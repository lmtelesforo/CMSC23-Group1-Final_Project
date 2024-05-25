import 'package:cmsc23_project/models/donation_drive.dart';
import 'package:cmsc23_project/org-view/base_elements/base_screen/base_screen.dart';
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
          child: _DriveCard(widget.drive),
        ),
        _favoriteIcon,
      ],
    );
  }

  Widget get _favoriteIcon => Positioned(
        top: 25,
        right: 25,
        child: Row(
          children: [
            Container(
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
                child: context
                        .read<CurrentOrgProvider>()
                        .isFavorite(widget.drive.id)
                    ? const Icon(Icons.favorite, color: CustomColors.secondary)
                    : const Icon(Icons.favorite_border,
                        color: CustomColors.secondary),
              ),
            ),
            const SizedBox(width: 5),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: CustomColors.primary,
                shape: BoxShape.circle,
              ),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('/org/add-a-drive',
                      arguments: widget.drive.id);
                },
                child: const Icon(Icons.edit, color: CustomColors.secondary),
              ),
            ),
          ],
        ),
      );
}

class _DriveCard extends StatelessWidget {
  final DonationDrive drive;

  const _DriveCard(this.drive);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            _image(),
            _name(),
            _statusInfo(),
            _description(),
          ],
        ),
      ),
    );
  }

  Widget _description() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(drive.description, style: CustomTextStyle.body),
    );
  }

  Widget _name() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          drive.name,
          style: CustomTextStyle.h1,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _statusInfo() {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _status,
        ],
      ),
    );
  }

  Widget _image() {
    return Container(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 10,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image(
          image: drive.image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget get _status => Row(
        children: [
          const Icon(Icons.schedule, color: CustomColors.secondary),
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              drive.isOngoing ? 'Ongoing' : 'Ended',
              style: CustomTextStyle.body,
            ),
          ),
        ],
      );
}
