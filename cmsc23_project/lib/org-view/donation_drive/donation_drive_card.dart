import 'package:cmsc23_project/models/donation_drive.dart';
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
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          height: 150,
          width: 180,
          child: Card(
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/org/drives/details',
                    arguments: drive);
              },
              child: _CardContent(drive),
            ),
          ),
        ),
        Visibility(
          visible: context.read<CurrentOrgProvider>().isFavorite(drive.id),
          child: _FavoriteIcon(),
        ),
      ],
    );
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
    final donationCount = context
        .watch<CurrentOrgProvider>()
        .donations()
        .where((donation) => donation.driveId == drive.id)
        .length;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _driveName(),
        _driveInfo(donationCount),
      ],
    );
  }

  Table _driveInfo(int donationCount) {
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
