import 'dart:convert';
import 'package:cmsc23_project/org-view/base_elements/org_view_styles.dart';
import 'package:flutter/material.dart';

class Donation {
  String? id;
  String organization;
  String driveName;

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
  String driveId;
  String time;

  Donation({
    this.id,
    required this.organization,
    required this.driveName,
    required this.category,
    required this.shipping,
    required this.weight,
    this.addresses,
    required this.driveId,
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
    json.forEach((key, value) {
      if (value == null) {
        print('Missing field: $key');
      }
    });

    return Donation(
      id: json['id'] as String?,
      organization: json['organization'] ?? '',
      driveName: json['driveName'] ?? '',
      category: json['category'] ?? [],
      shipping: json['shipping'] ?? '',
      weight: json['weight'] ?? '',
      addresses: json['addresses'] ?? [],
      contactNumber: json['contactNumber'] ?? '',
      image: json['image'] is List<dynamic> ? json['image'] : [json['image']],
      driveId: json['driveId'],
      status: json['status'] ?? '',
      qrcode: json['qrcode'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
    );
  }

  static List<Donation> fromJsonArray(String jsonData) {
    final Iterable<dynamic> data = jsonDecode(jsonData);
    return data.map<Donation>((dynamic d) => Donation.fromJson(d)).toList();
  }

  Map<String, dynamic> toJson(Donation donation) {
    return {
      'id': donation.id,
      'organization': donation.organization,
      'driveName': donation.driveName,
      'category': donation.category,
      'name': donation.name,
      'weight': donation.weight,
      'shipping': donation.shipping,
      'addresses': donation.addresses,
      'contactNumber': donation.contactNumber,
      'photo': donation.photo,
      'image': donation.image,
      'status': donation.status,
      'qrcode': donation.qrcode,
      'driveId': donation.driveId,
    };
  }

  Donation copy() {
    return Donation(
        id: id,
        organization: organization,
        driveName: driveName,
        name: name,
        email: email,
        category: category,
        shipping: shipping,
        weight: weight,
        date: date,
        driveId: driveId,
        time: time,
        addresses: addresses,
        contactNumber: contactNumber,
        photo: photo,
        image: image,
        qrcode: qrcode,
        status: status);
  }

  List<String> get validStatuses {
    List<String> allStatuses = [
      'Pending',
      'Confirmed',
      'Scheduled for Pickup',
      'Completed',
      'Cancelled',
    ];

    if (shipping != 'Pick up') {
      // Remove 'Scheduled for Pickup' if shipping is not 'Pick up'
      allStatuses.remove('Scheduled for Pickup');
    }

    if (status == 'Completed' || status == 'Cancelled') {
      // If status is 'Completed' or 'Cancelled', return only that status
      return [status];
    }

    // Else, return all statuses starting from the current status
    int index = allStatuses.indexOf(status);
    return index != -1 ? allStatuses.sublist(index) : allStatuses;
  }

  @override
  String toString() {
    return 'Donation(organization: $organization, driveName: $driveName, category: $category, shipping: $shipping, weight: $weight, photo: $photo, image: $image, addresses: $addresses, contactNumber: $contactNumber, qrcode: $qrcode, status: $status, email: $email, name: $name, date: $date, $time: time)';
  }
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
