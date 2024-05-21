import 'package:cmsc23_project/models/donation_drive.dart';
import 'package:flutter/material.dart';

class FirebaseDriveAPI {
  final List<DonationDrive> _drives = [
    DonationDrive(
      id: '1',
      orgUsername: 'redcross',
      name: 'Typhoon Relief Drive',
      description: 'Help us provide relief to the victims of Typhoon Odette.',
      image: const AssetImage('assets/images/donation_drive.jpg'),
      isOngoing: true,
    ),
    DonationDrive(
      id: '2',
      orgUsername: 'redcross',
      name: 'Vaccination Drive',
      description: 'Help us provide vaccines to children in need.',
      image: const AssetImage('assets/images/donation_drive.jpg'),
      isOngoing: true,
    ),
  ];

  List<DonationDrive> get drives => _drives;
  List<DonationDrive> getDrivesByOrgUsername(String orgUsername) {
    return _drives.where((drive) => drive.orgUsername == orgUsername).toList();
  }
}
