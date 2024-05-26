import 'package:cmsc23_project/models/donation_drive.dart';

class FirebaseDriveAPI {
  final List<DonationDrive> _drives = [
    DonationDrive(
      id: 1,
      orgUsername: 'redcross',
      name: 'Typhoon Relief Drive',
      description: 'Help us provide relief to the victims of Typhoon Odette.',
      isOngoing: true,
    ),
    DonationDrive(
      id: 2,
      orgUsername: 'redcross',
      name: 'Vaccination Drive',
      description: 'Help us provide vaccines to children in need.',
      isOngoing: true,
    ),
  ];

  List<DonationDrive> get drives => _drives;
  List<DonationDrive> getDrivesByOrgUsername(String orgUsername) {
    return _drives.where((drive) => drive.orgUsername == orgUsername).toList();
  }

  void addDrive(DonationDrive drive) {
    _drives.add(drive);
  }

  void updateDrive(int id, String name, String desc) {
    DonationDrive drive = _drives.firstWhere((drive) => drive.id == id);
    drive.name = name;
    drive.description = desc;
  }
}
