import 'package:cmsc23_project/models/donation_drive.dart';
import 'package:cmsc23_project/org-view/base_elements/base_screen/base_screen.dart';
import 'package:cmsc23_project/org-view/donations/donation_list.dart';
import 'package:cmsc23_project/org-view/base_elements/org_view_styles.dart';
import 'package:cmsc23_project/providers/current_org_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonationDriveDetails extends StatelessWidget {
  // The screen for a single donation drive

  const DonationDriveDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final DonationDrive drive =
        ModalRoute.of(context)!.settings.arguments as DonationDrive;

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
        _driveActions,
      ],
    );
  }

  Widget get _driveActions => Positioned(
        top: 13,
        right: 20,
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
                  Navigator.of(context)
                      .pushNamed('/org/add-a-drive', arguments: widget.drive);
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
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: [
            _name(),
            const SizedBox(height: 5),
            _statusInfo(context),
            const SizedBox(height: 20),
            _description(),
          ],
        ),
      ),
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

  Widget _statusInfo(BuildContext context) {
    int noOfDonations = context
        .watch<CurrentOrgProvider>()
        .donations()
        .where((donation) => donation.driveId == drive.id)
        .length;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _status,
        Row(
          children: [
            const Icon(Icons.tag, color: CustomColors.secondary),
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                '$noOfDonations donation${noOfDonations != 1 ? 's' : ''}',
                style: CustomTextStyle.body,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _description() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(drive.description, style: CustomTextStyle.body),
    );
  }

  Widget get _status => Row(
        children: [
          drive.isOngoing
              ? const Icon(Icons.more_horiz, color: CustomColors.secondary)
              : const Icon(Icons.close, color: CustomColors.secondary),
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
