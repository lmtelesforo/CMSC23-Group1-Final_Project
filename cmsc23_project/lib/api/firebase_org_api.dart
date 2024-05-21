import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseOrgAPI {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getOrgs() {
    return _db.collection('organizations').snapshots();
  }
}
