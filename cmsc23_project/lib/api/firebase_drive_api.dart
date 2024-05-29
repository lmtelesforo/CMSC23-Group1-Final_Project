import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDriveAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> get drives => db.collection('drives').snapshots();

  Stream<DocumentSnapshot> getDrive(String id) =>
      db.collection('drives').doc(id).snapshots();

  Stream<QuerySnapshot> getDrivesByOrg(String orgUsername) {
    return db
        .collection('drives')
        .where('orgUsername', isEqualTo: orgUsername)
        .snapshots();
  }

  Stream<QuerySnapshot> getFavoriteDrives(String orgUsername) {
    return db
        .collection('drives')
        .where('orgUsername', isEqualTo: orgUsername)
        .where('isFavorite', isEqualTo: true)
        .snapshots();
  }

  Future<String> addDrive(Map<String, dynamic> drive) async {
    try {
      await db.collection('drives').add(drive);

      return 'Successfully added';
    } on FirebaseException catch (e) {
      return e.message ?? 'An error occurred';
    }
  }

  Future<String> editDrive(String id,
      {String? newName, String? description}) async {
    try {
      DocumentSnapshot drive = await db.collection('drives').doc(id).get();

      if (!drive.exists) {
        return 'Drive not found';
      }
      await db.collection('drives').doc(drive.id).update({
        'name': newName ?? drive['name'],
        'description': description ?? drive['description'],
      });

      return 'Successfully edited';
    } on FirebaseException catch (e) {
      return e.message ?? 'An error occurred';
    }
  }

  Future<String> toggleFavorite(String id) async {
    try {
      DocumentSnapshot drive = await db.collection('drives').doc(id).get();

      if (!drive.exists) {
        return 'Drive not found';
      }

      await db.collection('drives').doc(drive.id).update({
        'isFavorite': !drive['isFavorite'],
      });

      return 'Successfully toggled favorite';
    } on FirebaseException catch (e) {
      return e.message ?? 'An error occurred';
    }
  }

  Future<String> toggleStatus(String id) async {
    try {
      DocumentSnapshot drive = await db.collection('drives').doc(id).get();

      if (!drive.exists) {
        return 'Drive not found';
      }

      await db.collection('drives').doc(drive.id).update({
        'isOngoing': !drive['isOngoing'],
      });

      return 'Successfully toggled status';
    } on FirebaseException catch (e) {
      return e.message ?? 'An error occurred';
    }
  }

  Future<String> deleteDrive(String id) async {
    try {
      DocumentSnapshot drive = await db.collection('drives').doc(id).get();

      if (!drive.exists) {
        return 'Drive not found';
      }

      await db.collection('drives').doc(drive.id).delete();

      return 'Successfully deleted';
    } on FirebaseException catch (e) {
      return e.message ?? 'An error occurred';
    }
  }
}
