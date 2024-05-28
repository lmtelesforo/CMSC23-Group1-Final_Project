import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23_project/models/donation_drive.dart';
import 'package:cmsc23_project/org-view/base_elements/base_screen/base_screen.dart';
import 'package:cmsc23_project/org-view/base_elements/org_view_styles.dart';
import 'package:cmsc23_project/org-view/donations/donation_list.dart';
import 'package:cmsc23_project/providers/current_org_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonationDriveDetails extends StatelessWidget {
  const DonationDriveDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final String name = ModalRoute.of(context)!.settings.arguments as String;

    return BaseScreen(
      body: StreamBuilder(
        stream: context.read<CurrentOrgProvider>().drive(name),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('An error occurred');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          DonationDrive drive = DonationDrive.fromJson(
              snapshot.data!.docs.first.data() as Map<String, dynamic>);

          return Column(
            children: [
              ExpandedDriveCard(drive),
              DonationList(
                  orgUsername: drive.orgUsername, driveName: drive.name),
            ],
          );
        },
      ),
    );
  }
}

class ExpandedDriveCard extends StatelessWidget {
  final DonationDrive drive;

  const ExpandedDriveCard(this.drive, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: _DriveCard(drive),
        ),
        _driveActions(drive, context),
      ],
    );
  }

  Widget _driveActions(DonationDrive drive, BuildContext context) {
    return Positioned(
      top: 13,
      right: 20,
      child: Row(
        children: [
          _buildActionIcon(
            icon: drive.isFavorite ? Icons.favorite : Icons.favorite_border,
            onTap: () {
              _toggleFavorite(context);
            },
          ),
          const SizedBox(width: 5),
          _buildActionIcon(
            icon: drive.isOngoing ? Icons.close : Icons.more_horiz,
            onTap: () {
              _toggleStatus(context);
            },
          ),
          const SizedBox(width: 5),
          _buildActionIcon(
            icon: Icons.edit,
            onTap: () => {
              Navigator.pushNamed(context, '/org/drives/edit', arguments: drive)
            },
          ),
          const SizedBox(width: 5),
          _buildActionIcon(
            icon: Icons.delete,
            onTap: () {
              Navigator.pop(context);
              _deleteDrive(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionIcon(
      {required IconData icon, required Function()? onTap}) {
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

  void _toggleFavorite(BuildContext context) {
    context.read<CurrentOrgProvider>().toggleFavorite(drive.name);
  }

  void _toggleStatus(BuildContext context) {
    context.read<CurrentOrgProvider>().toggleStatus(drive.name);
  }

  void _deleteDrive(BuildContext context) {
    context.read<CurrentOrgProvider>().deleteDrive(drive.name);
  }
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
            _name(drive.name),
            const SizedBox(height: 5),
            _statusInfo(drive, context),
            const SizedBox(height: 20),
            _description(drive.description),
          ],
        ),
      ),
    );
  }

  Widget _name(String name) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          name,
          style: CustomTextStyle.h1,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _statusInfo(DonationDrive drive, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _status(drive.isOngoing),
        _donationCount(drive.orgUsername, drive.name, context),
      ],
    );
  }

  Widget _status(bool isOngoing) {
    return Row(
      children: [
        Icon(
          isOngoing ? Icons.more_horiz : Icons.close,
          color: CustomColors.secondary,
        ),
        const SizedBox(width: 10),
        Text(
          isOngoing ? 'Ongoing' : 'Ended',
          style: CustomTextStyle.body,
        ),
      ],
    );
  }

  Widget _donationCount(String orgUsername, String name, BuildContext context) {
    Stream<QuerySnapshot> donations =
        context.read<CurrentOrgProvider>().donationsByDrive(name);

    return StreamBuilder(
        stream: donations,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error loading donations');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          int count = snapshot.data!.docs.length;

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
        });
  }

  Widget _description(String description) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        description,
        style: CustomTextStyle.body,
      ),
    );
  }
}
