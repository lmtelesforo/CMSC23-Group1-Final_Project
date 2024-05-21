import 'package:cmsc23_project/models/donation_drive.dart';
import 'package:cmsc23_project/models/donor.dart';

class Organization extends Donor {
  List<DonationDrive> donationDrives;
  List<DonationDrive>? favorites;
  String about =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam vitae ultrices enim. Nunc elementum nisl metus, quis iaculis tortor posuere ac.";
  bool openForDonations = true;

  Organization({
    required super.name,
    required super.username,
    required super.addresses,
    required super.contactNo,
    required super.profilePic,
    this.donationDrives = const [],
    this.favorites = const [],
  });
}
