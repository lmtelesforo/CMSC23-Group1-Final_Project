import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23_project/api/firebase_donation_storage_api.dart';
import 'package:cmsc23_project/api/firebase_drive_api.dart';
import 'package:cmsc23_project/api/firebase_org_api.dart';
import 'package:flutter/material.dart';

class CurrentOrgProvider with ChangeNotifier {
  final FirebaseOrgAPI _firebaseOrgAPI = FirebaseOrgAPI();
  final FirebaseDriveAPI _firebaseDriveAPI = FirebaseDriveAPI();
  final FirebaseDonationStorageAPI _firebaseDonationStorageAPI =
      FirebaseDonationStorageAPI();

  late String orgUsername;
  late String name;

  void setOrg(String username, String name) {
    orgUsername = username;
    this.name = name;
  }

  // Getters
  Stream<QuerySnapshot> get currentOrg =>
      _firebaseOrgAPI.getOrgs(username: orgUsername);
  Stream<QuerySnapshot> get drives =>
      _firebaseDriveAPI.getDrivesByOrg(orgUsername);
  Stream<QuerySnapshot> get donations =>
      _firebaseDonationStorageAPI.getDonationsByOrg(name);
  Stream<QuerySnapshot> get favoriteDrives =>
      _firebaseDriveAPI.getFavoriteDrives(orgUsername);

  // Drive-related methods
  Stream<DocumentSnapshot> drive(String id) => _firebaseDriveAPI.getDrive(id);
  void addDrive(String name, String desc) {
    _firebaseDriveAPI.addDrive({
      'orgUsername': orgUsername,
      'name': name,
      'description': desc,
      'isOngoing': true,
      'isFavorite': false,
    });
    notifyListeners();
  }

  void editDrive(String id, {String? newName, String? description}) {
    _firebaseDriveAPI.editDrive(id, newName: newName, description: description);
    notifyListeners();
  }

  void deleteDrive(String id) {
    _firebaseDriveAPI.deleteDrive(id);
    notifyListeners();
  }

  void toggleFavorite(String id) {
    _firebaseDriveAPI.toggleFavorite(id);
    notifyListeners();
  }

  void toggleStatus(String driveId) {
    _firebaseDriveAPI.toggleStatus(driveId);
    notifyListeners();
  }

  // Donation-related methods
  Stream<QuerySnapshot> donationsByDrive(String driveId) =>
      _firebaseDonationStorageAPI.getDonationsByDrive(driveId);
  void changeDonationStatus(String donationId, String newStatus) {
    _firebaseDonationStorageAPI.updateDonationStatus(donationId, newStatus);
    notifyListeners();
  }

  void changeDonationDrive(String donationId, String newId, String newName) {
    _firebaseDonationStorageAPI.updateDonationDrive(donationId, newId, newName);
    notifyListeners();
  }

  // Org-related methods
  void updateName(String name) async {
    await _firebaseOrgAPI.updateName(orgUsername, name);
    notifyListeners();
  }

  void updateAbout(String about) async {
    await _firebaseOrgAPI.updateAbout(orgUsername, about);
    notifyListeners();
  }

  void toggleOpenForDonations() async {
    await _firebaseOrgAPI.toggleStatus(orgUsername);
    notifyListeners();
  }
}
