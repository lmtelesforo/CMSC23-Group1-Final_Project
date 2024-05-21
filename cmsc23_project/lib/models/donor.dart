import 'package:cmsc23_project/models/donation.dart';
import 'package:flutter/material.dart';

class Donor {
  final String name;
  final List<Donation> donations = [];
  final ImageProvider profilePic;

  Donor({required this.name, required this.profilePic});
}
