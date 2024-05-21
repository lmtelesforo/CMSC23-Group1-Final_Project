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
}

enum Status { pending, confirmed, scheduledForPickup, complete, cancelled }
