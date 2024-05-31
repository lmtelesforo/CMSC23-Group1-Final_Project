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

  Future<String> updateName(String username, String name) async {
    try {
      await db
          .collection('users')
          .where('username', isEqualTo: username)
          .get()
          .then((value) {
        for (var element in value.docs) {
          db.collection('users').doc(element.id).update({'name': name});
        }
      });
      return 'Success';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> updateAbout(String username, String about) async {
    try {
      await db
          .collection('users')
          .where('username', isEqualTo: username)
          .get()
          .then((value) {
        for (var element in value.docs) {
          db.collection('users').doc(element.id).update({'about': about});
        }
      });
      return 'Success';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> toggleStatus(String username) async {
    try {
      await db
          .collection('users')
          .where('username', isEqualTo: username)
          .get()
          .then((value) {
        for (var element in value.docs) {
          db
              .collection('users')
              .doc(element.id)
              .update({'status': !element.data()['status']});
        }
      });
      return 'Success';
    } catch (e) {
      return e.toString();
    }
  }
}
