import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseOrgAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getOrgs({String? username}) {
    Query query =
        db.collection('users').where('userType', isEqualTo: 'organization');

    if (username != null) {
      query = query.where('username', isEqualTo: username);
    }

    return query.snapshots();
  }

  Future<String> editOrg(String id,
      {String? name, String? about, bool? openForDonations}) async {
    try {
      await db.collection('users').doc(id).update(
          {'name': name, 'about': about, 'openForDonations': openForDonations});
      return 'success';
    } catch (e) {
      return e.toString();
    }
  }
}
