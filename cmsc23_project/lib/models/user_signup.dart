import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {
  String name;
  String username;
  String email;
  List addresses;
  String contactNumber;
  String? id;
  ImageProvider? profilePic;
  String userType;

  User ({
    this.id, 
    required this.name, 
    required this.username,
    required this.email, 
    required this.addresses, 
    required this.contactNumber, 
    required this.userType,
    this.profilePic
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      addresses: json['addresses'] != null ? List<dynamic>.from(json['addresses']) : [],
      contactNumber: json['contactNumber'] ?? '',
      userType: json['userType'] ?? '',
    );
  }

  static List<User> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<User>((dynamic d) => User.fromJson(d)).toList();
  }

  static User fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    print('User snapshot data: $data'); // Debug print
    return User.fromJson(data);
  }

  Map<String, dynamic> toJson(User user) {
    return { 
      'name': user.name,
      'username': user.username,
      'email': user.email,
      'addresses': user.addresses,
      'contactNumber': user.contactNumber,
      'userType': user.userType,
    };
  }
}