import 'package:cmsc23_project/models/donation_drive.dart';
import 'package:cmsc23_project/models/organization.dart';
import 'package:cmsc23_project/models/user.dart';
import 'package:flutter/material.dart';

class Donation {
  final User user;
  final Organization organization;
  DonationDrive? associatedDrive;
  Status status;

  Donation({
    this.status = Status.pending,
    required this.user,
    required this.organization,
  });

  Widget get statusIcon {
    switch (status) {
      case Status.pending:
        return const Icon(Icons.sms);
      case Status.confirmed:
        return const Icon(Icons.arrow_right_alt);
      case Status.scheduledForPickup:
        return const Icon(Icons.location_on);
      case Status.complete:
        return const Icon(Icons.done);
      case Status.cancelled:
        return const Icon(Icons.cancel);
    }
  }

  void associateWith(DonationDrive drive) {
    associatedDrive = drive;
    drive.donations.add(this);
  }
}

enum Status { pending, confirmed, scheduledForPickup, complete, cancelled }
