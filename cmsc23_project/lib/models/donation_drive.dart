import 'package:cloud_firestore/cloud_firestore.dart';

class DonationDrive {
  String orgUsername;
  String name;
  String description;
  bool isOngoing;
  bool isFavorite;

  DonationDrive({
    required this.orgUsername,
    required this.name,
    required this.description,
    required this.isOngoing,
    required this.isFavorite,
  });

  factory DonationDrive.fromJson(Map<String, dynamic> json) {
    return DonationDrive(
      orgUsername: json['orgUsername'],
      name: json['name'],
      description: json['description'],
      isOngoing: json['isOngoing'],
      isFavorite: json['isFavorite'],
    );
  }

  factory DonationDrive.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DonationDrive(
      orgUsername: data['orgUsername'],
      name: data['name'],
      description: data['description'],
      isOngoing: data['isOngoing'],
      isFavorite: data['isFavorite'],
    );
  }
}
