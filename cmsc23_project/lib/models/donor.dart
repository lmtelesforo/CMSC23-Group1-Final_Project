import 'package:flutter/material.dart';

class Donor {
  String name;
  String username;
  List<String> addresses;
  String contactNo;
  ImageProvider profilePic;
  List<String>? favoriteOrgs;

  Donor({
    required this.name,
    required this.username,
    required this.addresses,
    required this.contactNo,
    required this.profilePic,
    this.favoriteOrgs,
  });
}
