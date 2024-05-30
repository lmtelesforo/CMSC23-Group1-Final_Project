import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDonationStorageAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getAllDonations() {
    return db.collection("donations").snapshots();
  }

  Stream<QuerySnapshot> getDonationsByOrg(String username) {
    return db
        .collection("donations")
        .where("orgUsername", isEqualTo: username)
        .snapshots();
  }

  Stream<QuerySnapshot> getDonationsByDrive(String id) {
    return db
        .collection("donations")
        .where("driveId", isEqualTo: id)
        .snapshots();
  }

  Future<String> addDonation(
      Map<String, dynamic> donation, List<String> imageUrls) async {
    try {
      await db.collection("donations").add(donation);

      return "Successfully added donation!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  Future<String> updateDonationStatus(
      String donationId, String newStatus) async {
    try {
      DocumentSnapshot doc =
          await db.collection('donations').doc(donationId).get();

      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      String date = data['date'];
      String email = data['email'];

      String newQrCode = '$newStatus|$date|$email';

      await db.collection('donations').doc(donationId).update({
        'status': newStatus,
        'qrcode': newQrCode,
      });

      return 'Donation status updated successfully';
    } catch (e) {
      return 'Error updating donation status: $e';
    }
  }

  Future<String> updateDonationDrive(String donationId, String newDrive) async {
    try {
      await db.collection('donations').doc(donationId).update({
        'driveId': newDrive,
      });
      return ('Donation drive updated successfully');
    } catch (e) {
      return ('Error updating donation drive: $e');
    }
  }

  Future<String> updateQRDetails(String donationId, String newQRCode) async {
    try {
      await db.collection('donations').doc(donationId).update({
        'qrcode': newQRCode,
      });
      return ('Donation status updated successfully');
    } catch (e) {
      return ('Error updating donation status: $e');
    }
  }
}
