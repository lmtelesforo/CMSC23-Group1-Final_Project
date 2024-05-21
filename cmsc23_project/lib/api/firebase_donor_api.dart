import 'package:cmsc23_project/models/donor.dart';
import 'package:flutter/material.dart';

class FirebaseDonorAPI {
  final List<Donor> _donors = [
    Donor(
      name: 'John Doe',
      username: 'johndoe',
      addresses: ['123 Main St., Makati City', '456 2nd St., Quezon City'],
      contactNo: '09123456789',
      profilePic: const AssetImage('assets/images/profile_pic.jpg'),
      favoriteOrgs: ['Red Cross', 'UNICEF'],
    ),
    Donor(
      name: 'Jane Doe',
      username: 'janedoe',
      addresses: ['789 3rd St., Pasig City', '101 4th St., Taguig City'],
      contactNo: '09876543210',
      profilePic: const AssetImage('assets/images/profile_pic.jpg'),
      favoriteOrgs: ['World Vision', 'UNICEF'],
    ),
  ];

  List<Donor> get donors => _donors;
}
