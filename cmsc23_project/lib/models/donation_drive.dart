import 'package:flutter/material.dart';

class DonationDrive {
  String orgId;
  String name;
  String description;
  ImageProvider image;
  bool isOngoing;

  DonationDrive({
    required this.orgId,
    required this.name,
    required this.description,
    required this.image,
    required this.isOngoing,
  });
}
