import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseDonationStorageAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getAllDonations() {
    return db.collection("donations").snapshots();
  }

  Future<String> addDonation(Map<String, dynamic> donation) async {
    try {
      await db.collection("donations").add(donation);

      return "Successfully added donation!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  Future<String> updateDonationStatus(String donationId, String newStatus) async {
    try {
      await db.collection('donations').doc(donationId).update({
        'status': newStatus,
      });
      return('Donation status updated successfully');
    } catch (e) {
      return('Error updating donation status: $e');
    }
  }

}
