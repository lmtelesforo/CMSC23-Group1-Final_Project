import 'package:cmsc23_project/models/donor.dart';
import 'package:flutter/material.dart';

class Organization extends Donor {
  ImageProvider? proof;
  bool isApproved;
  String about;
  bool openForDonations;
  List<String>? favorites;

  Organization({
    required super.name,
    required super.username,
    required super.addresses,
    required super.contactNo,
    required super.profilePic,
    this.proof,
    required this.isApproved,
    required this.about,
    required this.openForDonations,
    this.favorites,
  });
}
