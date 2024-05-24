import 'package:cmsc23_project/org-view/base_elements/org_view_styles.dart';
import 'package:flutter/material.dart';

class Donation {
  String donorUsername;
  String orgUsername;
  int? driveId;

  String address;
  String contactNo;
  List<String> categories;
  bool forPickup;
  double weight;
  ImageProvider? donorImage;
  List<ImageProvider>? orgImages;
  DateTime scheduledDate;
  Status status;

  Donation({
    required this.donorUsername,
    required this.orgUsername,
    required this.driveId,
    required this.address,
    required this.contactNo,
    required this.categories,
    required this.forPickup,
    required this.weight,
    this.donorImage,
    this.orgImages,
    required this.scheduledDate,
    required this.status,
  });

  List<Status> get validStatuses => forPickup
      ? [
          Status.pending,
          Status.confirmed,
          Status.scheduledForPickup,
          Status.complete,
          Status.cancelled,
        ]
      : [
          Status.pending,
          Status.confirmed,
          Status.complete,
          Status.cancelled,
        ];
}

Widget statusIcon(status) {
  IconData icon;

  switch (status) {
    case Status.pending:
      icon = Icons.schedule;
    case Status.confirmed:
      icon = Icons.arrow_forward;
    case Status.scheduledForPickup:
      icon = Icons.schedule_send;
    case Status.complete:
      icon = Icons.done;
    case Status.cancelled:
      icon = Icons.cancel_outlined;
    default:
      icon = Icons.error;
  }

  return Icon(icon, color: CustomColors.primary);
}

enum Status { pending, confirmed, scheduledForPickup, complete, cancelled }
