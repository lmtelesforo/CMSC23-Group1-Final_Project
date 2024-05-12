import 'package:cmsc23_project/models/donation.dart';
import 'package:flutter/material.dart';

class User {
  final String name;
  final List<Donation> donations = [];
  final ImageProvider profilePic;

  User({required this.name, required this.profilePic});
}
