import 'package:cmsc23_project/models/donation_drive.dart';
import 'package:cmsc23_project/org-view/base_elements/base_screen/base_screen.dart';
import 'package:cmsc23_project/org-view/donations/donation_list.dart';
import 'package:cmsc23_project/org-view/base_elements/org_view_styles.dart';
import 'package:cmsc23_project/providers/current_org_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonationDriveDetails extends StatelessWidget {
  const DonationDriveDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final DonationDrive drive =
        ModalRoute.of(context)!.settings.arguments as DonationDrive;

    return BaseScreen(
      body: Column(
        children: [
          ExpandedDriveCard(drive: drive),
          DonationList(driveId: drive.id),
        ],
      ),
    );
  }
}

class ExpandedDriveCard extends StatefulWidget {
  final DonationDrive drive;

  const ExpandedDriveCard({required this.drive, super.key});

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
          child: _DriveCard(drive: widget.drive),
        ),
        _driveActions(context),
      ],
    );
  }

  Widget _driveActions(BuildContext context) {
    return Positioned(
      top: 13,
      right: 20,
      child: Row(
        children: [
          _buildActionIcon(
            icon:
                context.watch<CurrentOrgProvider>().isFavorite(widget.drive.id)
                    ? Icons.favorite
                    : Icons.favorite_border,
            onTap: () => _toggleFavorite(),
          ),
          const SizedBox(width: 5),
          _buildActionIcon(
            icon: widget.drive.isOngoing ? Icons.close : Icons.more_horiz,
            onTap: () => _toggleDriveStatus(),
          ),
          const SizedBox(width: 5),
          _buildActionIcon(
            icon: Icons.edit,
            onTap: () => _editDrive(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionIcon(
      {required IconData icon, required VoidCallback onTap}) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: CustomColors.primary,
        shape: BoxShape.circle,
      ),
      child: InkWell(
        onTap: onTap,
        child: Icon(icon, color: CustomColors.secondary),
      ),
    );
  }

  void _toggleFavorite() {
    setState(() {
      context.read<CurrentOrgProvider>().toggleFavorite(widget.drive.id);
    });
  }

  void _toggleDriveStatus() {
    setState(() {
      context.read<CurrentOrgProvider>().toggleDriveStatus(widget.drive.id);
    });
  }

  void _editDrive() {
    Navigator.of(context).pushNamed('/org/drives/add', arguments: widget.drive);
  }
}

class _DriveCard extends StatelessWidget {
  final DonationDrive drive;

  const _DriveCard({required this.drive});

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
    final noOfDonations = context
        .watch<CurrentOrgProvider>()
        .donations()
        .where((donation) => donation.driveId == drive.id)
        .length;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _status(),
        _donationCount(noOfDonations),
      ],
    );
  }

  Widget _status() {
    return Row(
      children: [
        Icon(
          drive.isOngoing ? Icons.more_horiz : Icons.close,
          color: CustomColors.secondary,
        ),
        const SizedBox(width: 10),
        Text(
          drive.isOngoing ? 'Ongoing' : 'Ended',
          style: CustomTextStyle.body,
        ),
      ],
    );
  }

  Widget _donationCount(int count) {
    return Row(
      children: [
        const Icon(Icons.tag, color: CustomColors.secondary),
        const SizedBox(width: 10),
        Text(
          '$count donation${count != 1 ? 's' : ''}',
          style: CustomTextStyle.body,
        ),
      ],
    );
  }

  Widget _description() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        drive.description,
        style: CustomTextStyle.body,
      ),
    );
  }
}
