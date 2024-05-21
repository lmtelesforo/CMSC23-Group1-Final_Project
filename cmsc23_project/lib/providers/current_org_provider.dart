import 'package:cmsc23_project/api/firebase_donation_api.dart';
import 'package:cmsc23_project/api/firebase_drive_api.dart';
import 'package:cmsc23_project/api/firebase_org_api.dart';
import 'package:cmsc23_project/models/donation.dart';
import 'package:cmsc23_project/models/donation_drive.dart';
import 'package:cmsc23_project/models/organization.dart';
import 'package:flutter/material.dart';

class CurrentOrgProvider with ChangeNotifier {
  final FirebaseOrgAPI _firebaseOrgAPI = FirebaseOrgAPI();
  final FirebaseDonationAPI _firebaseDonationAPI = FirebaseDonationAPI();
  final FirebaseDriveAPI _firebaseDriveAPI = FirebaseDriveAPI();

  late Organization _currentOrg;
  late List<Donation> _donations;
  late List<DonationDrive> _drives;

  CurrentOrgProvider() {
    _currentOrg = _firebaseOrgAPI.orgs[0];
    _donations =
        _firebaseDonationAPI.getDonationsByOrgUsername(_currentOrg.username);
    _drives = _firebaseDriveAPI.getDrivesByOrgUsername(_currentOrg.username);
    notifyListeners();
  }

  Organization get currentOrg => _currentOrg;
  List<Donation> get donations => _donations;
  List<DonationDrive> get drives => _drives;
  List<DonationDrive> get favorites => _drives
      .where((drive) => _currentOrg.favorites!.contains(drive.id))
      .toList();
}
