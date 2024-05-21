import 'package:flutter/material.dart';

class DonationDrive {
  String id;
  String orgUsername;
  String name;
  String description;
  ImageProvider image;
  bool isOngoing;

  DonationDrive({
    required this.id,
    required this.orgUsername,
    required this.name,
    required this.description,
    required this.image,
    required this.isOngoing,
  });
}
