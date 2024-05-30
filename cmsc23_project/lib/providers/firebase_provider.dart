import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../api/firebase_users_api.dart';

// created provider for storing user details (details page)
class UserInfosProvider with ChangeNotifier {
  FirebaseUserAPI firebaseService = FirebaseUserAPI();
  late Stream<QuerySnapshot> _userStream;
  late Stream<QuerySnapshot> _orgSignUpStream;

  UserInfosProvider() {
    fetchUsers();
    fetchSignUpRequests();
  }

  Stream<QuerySnapshot> get allUsers => _userStream;
  Stream<QuerySnapshot> get allSignUpReqs => _orgSignUpStream;

  void fetchUsers() {
    _userStream = firebaseService.getAllUsers();
    notifyListeners();
  }

  void fetchSignUpRequests() {
    _orgSignUpStream = firebaseService
        .getAllSignUpReqs(); // FirebaseUserAPI get org sign up requests
    notifyListeners();
  }

  Future<Map<String, dynamic>?> fetchCurrentUser(String? email) async {
    // get current user and their first and last name + email
    if (email != null && email.isNotEmpty) {
      final snapshot = await firebaseService.getUsersByEmail(email).first;
      if (snapshot.docs.isNotEmpty) {
        final userData = snapshot.docs.first.data();
        return userData as Map<String, dynamic>;
      } else {
        return null; // user is not found
      }
    } else {
      return null; // in case email  is empty
      // catch
    }
  }

  void addUser(Map<String, dynamic> user) async {
    // add user to firebase
    String? message = await firebaseService.addUser(user);
    print(message);
    notifyListeners();
  }

  void addOrg(Map<String, dynamic> org) async {
    // add user to firebase
    String? message = await firebaseService.addOrg(org);
    print(message);
    notifyListeners();
  }

  void deleteUser(String email) async {
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    if (userDoc.docs.isNotEmpty) {
      final docId = userDoc.docs.first.id;
      await firebaseService.delete(docId);
      notifyListeners();
    }
  }

  void deleteSignUpReq(String id) async {
    // delete data and reflect on firebase
    await firebaseService.deleteSignUpReq(id);
    notifyListeners();
  }

  Map<String, dynamic> donorData(String name, String username, String email,
      List addresses, String contactnumber, String userType) {
    // created a structure for easier storing
    Map<String, dynamic> newData = {
      'name': name,
      'username': username,
      'email': email,
      'addresses': addresses,
      'contactNumber': contactnumber,
      'userType': userType // with required fields
    };
    return newData;
  }

  Map<String, dynamic> orgData(String name, String username, String email,
      List addresses, String contactnumber, List proofs, String userType) {
    // created a structure for easier storing
    Map<String, dynamic> newData = {
      'name': name,
      'username': username,
      'email': email,
      'addresses': addresses,
      'contactNumber': contactnumber,
      'proofs': proofs,
      'userType': userType // with required fields
    };
    return newData;
  }

  void printAllUsers() async {
    try {
      final usersSnapshot = await firebaseService.getAllUsers().first;
      usersSnapshot.docs.forEach((doc) {
        print(doc.data()); // print to console
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  void getUserType() async {
    try {
      final usersSnapshot = await firebaseService.getAllUsers().first;
      final refreshedDocs = await Future.wait(usersSnapshot.docs
          .map((doc) => doc.reference.get(GetOptions(source: Source.server))));

      refreshedDocs.forEach((doc) {
        final userData = doc.data() as Map<String, dynamic>;
        final userType = userData['userType'];
        print('User Type: $userType');
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getDonors() async {
    try {
      final usersSnapshot = await firebaseService.getAllUsers().first;
      final refreshedDocs = await Future.wait(usersSnapshot.docs
          .map((doc) => doc.reference.get(GetOptions(source: Source.server))));
      final donorDataList = <Map<String, dynamic>>[];

      refreshedDocs.forEach((doc) {
        final userData = doc.data() as Map<String, dynamic>;
        final userType = userData['userType'];
        if (userType == 'donor') {
          donorDataList.add(userData);
        }
      });

      print('ALL DONORS: $donorDataList');
      return donorDataList;
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getOrgs() async {
    try {
      final usersSnapshot = await firebaseService.getAllUsers().first;
      final refreshedDocs = await Future.wait(usersSnapshot.docs
          .map((doc) => doc.reference.get(GetOptions(source: Source.server))));
      final orgDataList = <Map<String, dynamic>>[];

      refreshedDocs.forEach((doc) {
        final userData = doc.data() as Map<String, dynamic>;
        final userType = userData['userType'];
        if (userType == 'organization') {
          orgDataList.add(userData);
        }
      });

      print('ALL ORGS: $orgDataList');
      return orgDataList;
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }
}
