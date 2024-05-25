import 'package:flutter/material.dart';

import 'donation_providers.dart';

class TextfieldProviders extends ChangeNotifier {
  // initiate all common variables from forms to avoid redundancy
  String name = '';
  String username = '';
  String email = '';
  String password = '';
  String addresses = '';
  List addressesSpliced = [];
  String contactNumber = '';
  String proofs = '';
  List proofsSpliced = [];
  String qrcodeinput = '';
  String shippingOpt = 'Pick up';
  List category = [];
  String weight = '';
  bool datetimepicked = false;
  String date = '';
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  final controller3 = TextEditingController();
  final controller4 = TextEditingController();
  final controller5 = TextEditingController();
  final controller6 = TextEditingController();
  final controller7 = TextEditingController();
  
  late DateTime dateTime;

  void updateName(String value) {
    name = value;
    notifyListeners();
  }

  void updateUsername(String value) {
    username = value;
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

  void updateQRCodeInput(String value) {
    qrcodeinput = value;
    notifyListeners();
  }

  void updateShippingOpt(String value) {
    shippingOpt = value;
    notifyListeners();
  }

  void updateDateTime(DateTime value) {
    dateTime = value;
    notifyListeners();
  }

  void dateandtimepicked(bool value) {
    datetimepicked = value;
    notifyListeners();
  }

  void updateDate(String value) {
    date = value;
    notifyListeners();
  }

  void updateWeight(String value) {
    weight = value;
    notifyListeners();
  }

  void resetDonationInputs() {
    qrcodeinput = '';
    controller7.clear();
  }

  void resetSignUp() {
    name = '';
    username = '';
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
    controller7.clear();
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
