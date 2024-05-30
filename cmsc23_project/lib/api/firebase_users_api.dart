import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUserAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> addUser(Map<String, dynamic> user) async {
    try {
      await db.collection("users").add(user);

      return "Successfully added user!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  Future<String> addOrg(Map<String, dynamic> org) async {
    try {
      await db.collection("users").add(org);

      return "Successfully added user!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  Future<String> delete(String? email) async {
    try {
      await db.collection("users").doc(email).delete();
      return ("Document with email $email deleted successfully!");
    } on FirebaseException catch (e) {
      return ("Error deleting document: $e");
    }
  }

  Future<String> deleteSignUpReq(String? id) async {
    try {
      await db.collection("orgsignupreq").doc(id).delete();

      return "Successfully deleted!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  Future<String> addOrgSignUpReq(Map<String, dynamic> org) async {
    try {
      await db.collection("orgsignupreq").add(org);

      return "Successfully added organization to sign up request!";
    } on FirebaseException catch (e) {
      return "Error in ${e.code}: ${e.message}";
    }
  }

  Stream<QuerySnapshot> getAllUsers() {
    return db.collection("users").snapshots();
  }

  Stream<QuerySnapshot> getAllSignUpReqs() {
    return db.collection("orgsignupreq").snapshots();
  }

  Stream<QuerySnapshot> getUsersByEmail(String email) {
    return db
    .collection("users")
    .where("email", isEqualTo: email)
    .snapshots();
  }
}
