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
  String? address;
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
    this.address,
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

    final imageJson = json['image'];
    final image = imageJson is List<dynamic> ? List<String>.from(imageJson) : [imageJson];
    print(imageJson);
    print(image.toList());

    return Donation(
      id: json['id'] as String?,
      organization: json['organization'] ?? '',
      driveName: json['driveName'] ?? '',
      category: json['category'] ?? [],
      shipping: json['shipping'] ?? '',
      weight: json['weight'] ?? '',
      address: json['address'] ?? '',
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
      'address': donation.address,
      'contactNumber': donation.contactNumber,
      'photo': donation.photo,
      'image': donation.image != null ? donation.image!.join(',') : null,
      'status': donation.status,
      'qrcode': donation.qrcode
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
        address: address,
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

        
  @override
  String toString() {
    return 'Donation(organization: $organization, driveName: $driveName, category: $category, shipping: $shipping, weight: $weight, photo: $photo, image: $image, addresses: $address, contactNumber: $contactNumber, qrcode: $qrcode, status: $status, email: $email, name: $name, date: $date, $time: time)';
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
