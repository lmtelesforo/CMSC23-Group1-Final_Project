import 'package:cmsc23_project/models/donation.dart';

class FirebaseDonationAPI {
  final List<Donation> _donations = [
    Donation(
      donorUsername: 'johndoe',
      orgUsername: 'redcross',
      driveId: 1,
      address: '123 Main St., Makati City',
      contactNo: '09123456789',
      categories: ['Clothes', 'Food'],
      forPickup: true,
      weight: 10.0,
      scheduledDate: DateTime.now(),
      status: Status.pending,
    ),
    Donation(
      donorUsername: 'janedoe',
      orgUsername: 'redcross',
      driveId: 1,
      address: '789 3rd St., Pasig City',
      contactNo: '09876543210',
      categories: ['Toys', 'Books'],
      forPickup: false,
      weight: 5.0,
      scheduledDate: DateTime.now(),
      status: Status.pending,
    ),
  ];

  List<Donation> get donations => _donations;
  List<Donation> getDonationsByOrgUsername(String orgUsername) {
    return _donations
        .where((donation) => donation.orgUsername == orgUsername)
        .toList();
  }

  void update(Donation donation) {
    int index = _donations.indexWhere((d) => d == donation);
    _donations[index] = donation;
  }
}
