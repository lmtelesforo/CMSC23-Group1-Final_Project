import 'dart:convert';
import 'package:cmsc23_project/org-view/base_elements/org_view_styles.dart';
import 'package:flutter/material.dart';

class Donation {
  String? id;
  String orgUsername;
  String driveId;

  List category;
  String shipping;
  String weight;
  List? photo;
  List? image;
  List? addresses;
  String? contactNumber;
  String? qrcode;
  String status;
  String email;
  String name;
  String date;
  String time;

  Donation({
    this.id,
    required this.orgUsername,
    required this.driveId,
    required this.category,
    required this.shipping,
    required this.weight,
    this.addresses,
    this.contactNumber,
    required this.status,
    required this.name,
    required this.email,
    required this.date,
    required this.time,
    this.qrcode,
    this.photo,
    this.image,
  });

  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
      id: json['id'],
      orgUsername: json['orgUsername'],
      driveId: json['driveId'],
      category: json['category'],
      shipping: json['shipping'],
      weight: json['weight'],
      addresses: json['addresses'],
      contactNumber: json['contactNumber'],
      photo: json['photo'],
      image: json['image'],
      status: json['status'],
      qrcode: json['qrcode'],
      name: json['name'],
      email: json['email'],
      date: json['date'],
      time: json['time'],
    );
  }

  static List<Donation> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Donation>((dynamic d) => Donation.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Donation donation) {
    return {
      'id': donation.id,
      'orgUsername': donation.orgUsername,
      'driveId': donation.driveId,
      'category': donation.category,
      'name': donation.name,
      'weight': donation.weight,
      'shipping': donation.shipping,
      'addresses': donation.addresses,
      'contactNumber': donation.contactNumber,
      'photo': donation.photo,
      'image': donation.image,
      'status': donation.status,
      'qrcode': donation.qrcode
    };
  }

  Donation copy() {
    return Donation(
        id: id,
        orgUsername: orgUsername,
        driveId: driveId,
        name: name,
        email: email,
        category: category,
        shipping: shipping,
        weight: weight,
        date: date,
        time: time,
        addresses: addresses,
        contactNumber: contactNumber,
        photo: photo,
        image: image,
        qrcode: qrcode,
        status: status);
  }

  List<String> get validStatuses => shipping == 'Pick up'
      ? [
          'Pending',
          'Confirmed',
          'Scheduled for Pickup',
          'Completed',
          'Cancelled',
        ]
      : [
          'Pending',
          'Confirmed',
          'Completed',
          'Cancelled',
        ];
}

Widget statusIcon(String status) {
  IconData icon;

  switch (status) {
    case 'Pending':
      icon = Icons.schedule;
    case 'Confirmed':
      icon = Icons.arrow_forward;
    case 'Scheduled for Pickup':
      icon = Icons.schedule_send;
    case 'Completed':
      icon = Icons.done;
    case 'Cancelled':
      icon = Icons.cancel_outlined;
    default:
      icon = Icons.error;
  }

  return Icon(icon, color: CustomColors.primary);
}
