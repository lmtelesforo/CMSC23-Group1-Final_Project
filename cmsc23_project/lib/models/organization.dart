import 'package:cmsc23_project/models/donation_drive.dart';
import 'package:cmsc23_project/models/user.dart';

class Organization extends User {
  List<DonationDrive> donationDrives;
  List<DonationDrive> favorites = [];
  String about =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam vitae ultrices enim. Nunc elementum nisl metus, quis iaculis tortor posuere ac.";
  bool openForDonations = true;

  Organization({
    required super.profilePic,
    required super.name,
    this.donationDrives = const [],
  });

  void favorite(DonationDrive drive) {
    drive.isFavorite = true;
    favorites.add(drive);
  }
}
