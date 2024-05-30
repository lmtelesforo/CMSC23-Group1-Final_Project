import 'package:cmsc23_project/api/firebase_donation_api.dart';
import 'package:cmsc23_project/api/firebase_org_api.dart';
import 'package:cmsc23_project/models/donation.dart';
import 'package:cmsc23_project/models/organization.dart';
import 'package:flutter/material.dart';

class CurrentOrgProvider with ChangeNotifier {
  final FirebaseOrgAPI _firebaseOrgAPI = FirebaseOrgAPI();
  final FirebaseDonationAPI _firebaseDonationAPI = FirebaseDonationAPI();
  late Organization _currentOrg;
  late List<Donation> _donations;

  CurrentOrgProvider() {
    _currentOrg = _firebaseOrgAPI.orgs[0];
    _donations = _firebaseDonationAPI.getDonationsByOrgId(_currentOrg.username);
    notifyListeners();
  }

  Organization get currentOrg => _currentOrg;
  List<Donation> get donations => _donations;
}
