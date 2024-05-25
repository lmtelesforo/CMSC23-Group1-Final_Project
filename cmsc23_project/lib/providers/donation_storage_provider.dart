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

  void addDonation(Map<String, dynamic> donation) async { // add user to firebase
    String? message = await firebaseService.addDonation(donation);
    print(message); 
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

  Map<String, dynamic> donationDataPickUp(String name, String email, String date, String time, List addresses, String contactnumber, String status, List category, String shipping, String weight){ // created a structure for easier storing
    Map<String, dynamic> newData = {
      'name': name,
      'email': email,
      // 'dateTime': dateTime,
      'date': date,
      'time': time,
      'addresses': addresses,
      'contactNumber': contactnumber,
      'status': status,
      'category': category,
      'shipping': shipping,
      'weight': weight,
    };
    return newData;
  }
  Map<String, dynamic> donationDataDropOff(String name, String email, String date, String time, String status, List category, String shipping, String weight, String qrCode){ // created a structure for easier storing
    Map<String, dynamic> newData = {
      'name': name,
      'email': email,
      'date': date,
      'time': time,
      'status': status,
      'shipping': shipping,
      'qrcode': qrCode,
      'category': category,
      'weight': weight
    };
    return newData;
  }
}
