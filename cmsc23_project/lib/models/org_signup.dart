import 'dart:convert';

import 'package:flutter/material.dart';

class Org {
  String name;
  String username;
  String email;
  List addresses;
  String contactNo;
  List proofs;
  String? id;
  String userType;
  bool isApproved;
  String about;
  bool openForDonations;
  ImageProvider? profilePic;

  Org ({
    this.id, 
    required this.name, 
    required this.username,
    required this.email, 
    required this.addresses, 
    required this.contactNo, 
    required this.userType,
    required this.proofs, 
    required this.isApproved,
    required this.about,
    required this.openForDonations,
  });

  factory Org.fromJson(Map<String, dynamic> json) {
    return Org(
      name: json['name'],
      username: json['username'],
      email: json['email'],
      addresses: json['addresses'],
      contactNo: json['contactNo'],
      userType: json['userType'],
      proofs: json['proofs'],
      isApproved: json['isApproved'],
      about: json['about'],
      openForDonations: json['openForDonations']
    );
  }

  static List<Org> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Org>((dynamic d) => Org.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Org org) {
    return {
      'name': org.name,
      'username': org.username,
      'email': org.email,
      'addresses': org.addresses,
      'contactNo': org.contactNo,
      'userType': org.userType,
      'proofs': org.proofs,
      'isApproved': org.isApproved,
      'about': org.about,
      'openForDonations': org.openForDonations,
    };
  }
}




