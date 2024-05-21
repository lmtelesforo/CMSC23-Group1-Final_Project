import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDonorAPI {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getDonors() {
    return _db.collection('donors').snapshots();
  }
}
