import 'package:cmsc23_project/models/donation.dart';

class FirebaseDonationAPI {
  final List<Donation> _donations = [
    Donation(
      donorUsername: 'johndoe',
      orgUsername: 'redcross',
      driveId: '123456',
      address: '123 Main St., Makati City',
      contactNo: '09123456789',
      categories: ['Clothes', 'Food'],
      forPickup: true,
      weight: 10.0,
      scheduledDate: DateTime.now(),
      status: Status.pending,
    ),
  ];

  List<Donation> get donations => _donations;
  List<Donation> getDonationsByOrgId(String orgId) {
    return _donations
        .where((donation) => donation.orgUsername == orgId)
        .toList();
  }
}
