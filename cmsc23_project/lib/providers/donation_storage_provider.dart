import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23_project/api/firebase_donation_storage_api.dart';
import 'package:flutter/material.dart';

// created provider for storing donation details (details page)
class DonationStorageProvider with ChangeNotifier {
  FirebaseDonationStorageAPI firebaseService = FirebaseDonationStorageAPI();
  late Stream<QuerySnapshot> _donationStream;

  DonationStorageProvider() {
    fetchDonations();
  }

  Stream<QuerySnapshot> get allDonations => _donationStream;
  
  void fetchDonations() {
    _donationStream = firebaseService.getAllDonations();
    notifyListeners();
  }

  void printAllDonations() async {
    try {
      final donationsSnapshot = await firebaseService.getAllDonations().first;
      donationsSnapshot.docs.forEach((doc) {
        print(doc.data()); // print to console
      });
    } catch (e) {
      print("Error: $e");
    }
  }
}
