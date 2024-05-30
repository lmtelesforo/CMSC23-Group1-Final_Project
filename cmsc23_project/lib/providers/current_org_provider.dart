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

  late String orgUsername;

  void setOrg(String username) {
    orgUsername = username;
  }

  Stream<QuerySnapshot> get currentOrg =>
      _firebaseOrgAPI.getOrgs(username: orgUsername);

  Stream<QuerySnapshot> get drives =>
      _firebaseDriveAPI.getDrivesByOrg(orgUsername);

  Stream<QuerySnapshot> get donations =>
      _firebaseDonationStorageAPI.getDonationsByOrg(orgUsername);

  Stream<DocumentSnapshot> drive(String id) => _firebaseDriveAPI.getDrive(id);

  Stream<QuerySnapshot> donationsByDrive(String driveId) =>
      _firebaseDonationStorageAPI.getDonationsByDrive(driveId);

  Stream<QuerySnapshot> get favoriteDrives =>
      _firebaseDriveAPI.getFavoriteDrives(orgUsername);

  void toggleFavorite(String id) {
    _firebaseDriveAPI.toggleFavorite(id);
    notifyListeners();
  }

  void toggleStatus(String id) {
    _firebaseDriveAPI.toggleStatus(id);
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

  void editDrive(String id, {String? newName, String? description}) {
    _firebaseDriveAPI.editDrive(id, newName: newName, description: description);
    notifyListeners();
  }

  void deleteDrive(String id) {
    _firebaseDriveAPI.deleteDrive(id);
    notifyListeners();
  }
}
