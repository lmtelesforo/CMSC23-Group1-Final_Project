import 'package:cmsc23_project/models/organization.dart';
import 'package:flutter/material.dart';

class FirebaseOrgAPI {
  final List<Organization> _orgs = [
    Organization(
      name: 'Red Cross',
      username: 'redcross',
      addresses: ['123 Main St., Makati City', '456 2nd St., Quezon City'],
      contactNo: '09123456789',
      profilePic: const AssetImage('assets/images/profile_pic.jpg'),
      isApproved: true,
      about:
          'The Philippine Red Cross is a humanitarian organization that provides services to uplift the lives of the underprivileged in the country.',
      openForDonations: true,
      favorites: ['1', '2'],
    ),
    Organization(
      name: 'UNICEF',
      username: 'unicef',
      addresses: ['789 3rd St., Pasig City', '101 4th St., Taguig City'],
      contactNo: '09876543210',
      profilePic: const AssetImage('assets/images/profile_pic.jpg'),
      isApproved: true,
      about:
          'UNICEF is the United Nations Children\'s Fund that provides humanitarian and developmental assistance to children and mothers in developing countries.',
      openForDonations: true,
      favorites: [],
    ),
  ];

  List<Organization> get orgs => _orgs;
}
