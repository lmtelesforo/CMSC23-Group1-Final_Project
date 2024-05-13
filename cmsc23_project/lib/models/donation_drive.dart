import 'package:flutter/material.dart';

class DonationDrive {
  final String name;
  final DateTime date;
  final ImageProvider image;
  bool isFavorite = false;

  DonationDrive({required this.name, required this.date, required this.image});
}
