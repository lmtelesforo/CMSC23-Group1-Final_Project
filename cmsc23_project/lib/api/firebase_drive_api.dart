import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDriveAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getDrives({String? orgUsername}) {
    Query query = db.collection('drives');

    if (orgUsername != null) {
      query = query.where('orgUsername', isEqualTo: orgUsername);
    }

    return query.snapshots();
  }

  // TODO: Get/update drives by id. error+conflict pag ganito implementation
  Stream<QuerySnapshot> getDrive(String orgUsername, String driveName) {
    return db
        .collection('drives')
        .where('orgUsername', isEqualTo: orgUsername)
        .where('name', isEqualTo: driveName)
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

  Future<String> editDrive(String name,
      {String? newName, String? description}) async {
    try {
      QuerySnapshot drives =
          await db.collection('drives').where('name', isEqualTo: name).get();

      if (drives.docs.isEmpty) {
        return 'Drive not found';
      }

      DocumentSnapshot drive = drives.docs.first;
      await db.collection('drives').doc(drive.id).update({
        'name': newName ?? drive['name'],
        'description': description ?? drive['description'],
      });

      return 'Successfully edited';
    } on FirebaseException catch (e) {
      return e.message ?? 'An error occurred';
    }
  }

  Future<String> toggleFavorite(String orgUsername, String driveName) async {
    try {
      QuerySnapshot drives = await db
          .collection('drives')
          .where('orgUsername', isEqualTo: orgUsername)
          .where('name', isEqualTo: driveName)
          .get();

      if (drives.docs.isEmpty) {
        return 'Drive not found';
      }

      DocumentSnapshot drive = drives.docs.first;

      await db.collection('drives').doc(drive.id).update({
        'isFavorite': !drive['isFavorite'],
      });

      return 'Successfully toggled favorite';
    } on FirebaseException catch (e) {
      return e.message ?? 'An error occurred';
    }
  }

  Future<String> toggleStatus(String orgUsername, String driveName) async {
    try {
      QuerySnapshot drives = await db
          .collection('drives')
          .where('orgUsername', isEqualTo: orgUsername)
          .where('name', isEqualTo: driveName)
          .get();

      if (drives.docs.isEmpty) {
        return 'Drive not found';
      }

      DocumentSnapshot drive = drives.docs.first;

      await db.collection('drives').doc(drive.id).update({
        'isOngoing': !drive['isOngoing'],
      });

      return 'Successfully toggled status';
    } on FirebaseException catch (e) {
      return e.message ?? 'An error occurred';
    }
  }

  Future<String> deleteDrive(String orgUsername, String driveName) async {
    try {
      QuerySnapshot drives = await db
          .collection('drives')
          .where('orgUsername', isEqualTo: orgUsername)
          .where('name', isEqualTo: driveName)
          .get();

      if (drives.docs.isEmpty) {
        return 'Drive not found';
      }

      DocumentSnapshot drive = drives.docs.first;
      await db.collection('drives').doc(drive.id).delete();

      return 'Successfully deleted';
    } on FirebaseException catch (e) {
      return e.message ?? 'An error occurred';
    }
  }
}
