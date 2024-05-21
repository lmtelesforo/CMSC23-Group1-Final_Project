import 'package:flutter/material.dart';

class Donation {
  String donorId;
  String orgId;
  String? driveId;

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
    required this.donorId,
    required this.orgId,
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
