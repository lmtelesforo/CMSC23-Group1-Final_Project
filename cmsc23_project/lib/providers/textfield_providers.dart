import 'package:flutter/material.dart';

class TextfieldProviders extends ChangeNotifier {
  // initiate all common variables from forms to avoid redundancy
  String name = '';
  String email = '';
  String password = '';
  String addresses = '';
  List addressesSpliced = [];
  String contactNumber = '';
  String proofs = '';
  List proofsSpliced = [];
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();
  final controller4 = TextEditingController();
  final controller5 = TextEditingController();
  final controller6 = TextEditingController();

  void updateName(String value) {
    name = value;
    notifyListeners();
  }

  void updateEmail(String value) {
    email = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    password = value;
    notifyListeners();
  }

  void updateAddresses(String value) {
    addresses = value;
    notifyListeners();
  }

  void updateContactNumber(String value) {
    contactNumber = value;
    notifyListeners();
  }

  void updateProofs(String value) {
    proofs = value;
    notifyListeners();
  }

  void resetSignUp() {
    name = '';
    email = '';
    password = '';
    addresses = '';
    addressesSpliced = [];
    contactNumber = '';
    proofs = '';
    proofsSpliced = [];
    controller1.clear(); // clears form field
    controller2.clear();
    controller3.clear();
    controller4.clear();
    controller5.clear();
    controller6.clear();
    notifyListeners();
  }

  void resetLogIn() {
    email = '';
    password = '';
    controller1.clear(); // clears form field
    controller2.clear();
    notifyListeners();
  }
}
