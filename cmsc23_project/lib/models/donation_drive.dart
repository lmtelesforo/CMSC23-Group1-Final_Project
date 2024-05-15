import 'package:cmsc23_project/models/donation.dart';
import 'package:flutter/material.dart';

class DonationDrive {
  final String name;
  final ImageProvider image;
  List<Donation> donations = [];
  _Status _status = _Status.ongoing;
  bool isFavorite = false;

  DonationDrive({required this.name, required this.image});

  String get status {
    switch (_status) {
      case _Status.ongoing:
        return 'Ongoing';
      case _Status.completed:
        return 'Completed';
    }
  }

  void end() {
    _status = _Status.completed;
  }
}

enum _Status { ongoing, completed }
