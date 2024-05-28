import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23_project/api/firebase_donation_storage_api.dart';
import 'package:cmsc23_project/api/firebase_drive_api.dart';
import 'package:cmsc23_project/api/firebase_org_api.dart';
import 'package:flutter/material.dart';

class CurrentOrgProvider with ChangeNotifier {
  // Manages the state of the logged-in org
  final FirebaseOrgAPI _firebaseOrgAPI = FirebaseOrgAPI();
  final FirebaseDriveAPI _firebaseDriveAPI = FirebaseDriveAPI();
  final FirebaseDonationStorageAPI _firebaseDonationStorageAPI =
      FirebaseDonationStorageAPI();

  final String orgUsername = 'secant';

  Stream<QuerySnapshot> get currentOrg =>
      _firebaseOrgAPI.getOrgs(username: orgUsername);

  Stream<QuerySnapshot> get drives =>
      _firebaseDriveAPI.getDrives(orgUsername: orgUsername);

  Stream<QuerySnapshot> get donations =>
      _firebaseDonationStorageAPI.getDonationsByOrg(orgUsername);

  Stream<QuerySnapshot> drive(String driveName) =>
      _firebaseDriveAPI.getDrive(orgUsername, driveName);

  Stream<QuerySnapshot> donationsByDrive(driveName) =>
      _firebaseDonationStorageAPI.getDonationsByDrive(orgUsername, driveName);

  Stream<QuerySnapshot> get favoriteDrives =>
      _firebaseDriveAPI.getFavoriteDrives(orgUsername);

  void toggleFavorite(String driveName) {
    _firebaseDriveAPI.toggleFavorite(orgUsername, driveName);
    notifyListeners();
  }

  void toggleStatus(String driveName) {
    _firebaseDriveAPI.toggleStatus(orgUsername, driveName);
    notifyListeners();
  }

  void changeDonationStatus(String donationId, String newStatus) {
    _firebaseDonationStorageAPI.updateDonationStatus(donationId, newStatus);
    notifyListeners();
  }

  void changeDonationDrive(String donationId, String newDrive) {
    _firebaseDonationStorageAPI.updateDonationDrive(donationId, newDrive);
    notifyListeners();
  }

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

  void editDrive(String name, {String? newName, String? description}) {
    _firebaseDriveAPI.editDrive(name,
        newName: newName, description: description);
    notifyListeners();
  }

  void deleteDrive(String driveName) {
    _firebaseDriveAPI.deleteDrive(orgUsername, driveName);
    notifyListeners();
  }
}
