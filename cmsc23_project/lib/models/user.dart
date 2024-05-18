import 'package:cmsc23_project/models/donation.dart';
import 'package:cmsc23_project/models/organization.dart';
import 'package:flutter/material.dart';

class User {
  final String name;
  final List<Donation> donations = [];
  final ImageProvider profilePic;

  User({required this.name, required this.profilePic});

  void donate(Organization org) {
    Donation newDonation = Donation(user: this, organization: org);
    donations.add(newDonation);
    org.donations.add(newDonation);
  }
}
