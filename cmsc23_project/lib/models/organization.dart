import 'package:cmsc23_project/models/donation_drive.dart';
import 'package:cmsc23_project/models/user.dart';

class Organization extends User {
  List<DonationDrive> donationDrives;
  List<DonationDrive> favorites = [];

  Organization({required super.profilePic, this.donationDrives = const []});

  void favorite(DonationDrive drive) {
    favorites.add(drive);
  }
}
