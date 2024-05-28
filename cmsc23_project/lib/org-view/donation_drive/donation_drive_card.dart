import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23_project/models/donation_drive.dart';
import 'package:cmsc23_project/org-view/base_elements/org_view_styles.dart';
import 'package:cmsc23_project/providers/current_org_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonationDriveCard extends StatelessWidget {
  // Represents a donation drive card on the homepage and donation drive list
  final String name;

  const DonationDriveCard(this.name, {super.key});

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> drive =
        context.read<CurrentOrgProvider>().drive(name);

    return StreamBuilder(
        stream: drive,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('An error occurred');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          DonationDrive drive = DonationDrive.fromJson(
              snapshot.data!.docs.first.data() as Map<String, dynamic>);

          return Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                height: 150,
                width: 180,
                child: Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/org/drives/details',
                          arguments: name);
                    },
                    child: _CardContent(drive),
                  ),
                ),
              ),
              Visibility(
                visible: drive.isFavorite,
                child: _FavoriteIcon(),
              ),
            ],
          );
        });
  }
}

class _FavoriteIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Positioned(
        top: -3,
        right: -3,
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

class _CardContent extends StatelessWidget {
  const _CardContent(this.drive);

  final DonationDrive drive;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: context.read<CurrentOrgProvider>().donationsByDrive(drive.name),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('An error occurred');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          int donationCount = snapshot.data!.docs.length;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _driveName(),
              _driveInfo(donationCount),
            ],
          );
        });
  }

  Widget _driveInfo(int donationCount) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1.5),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(
          children: [
            drive.isOngoing
                ? const Icon(
                    Icons.more_horiz,
                    color: CustomColors.secondary,
                  )
                : const Icon(
                    Icons.close,
                    color: CustomColors.secondary,
                  ),
            drive.isOngoing
                ? Text("Ongoing",
                    style: CustomTextStyle.body.apply(fontSizeDelta: -2))
                : Text("Ended",
                    style: CustomTextStyle.body.apply(fontSizeDelta: -2)),
          ],
        ),
        TableRow(
          children: [
            const Icon(Icons.tag, color: CustomColors.secondary),
            Text(
              "$donationCount donation${donationCount != 1 ? 's' : ''}",
              style: CustomTextStyle.body.apply(fontSizeDelta: -2),
            )
          ],
        ),
      ],
    );
  }

  Padding _driveName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        drive.name,
        style: CustomTextStyle.h2,
        textAlign: TextAlign.center,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
