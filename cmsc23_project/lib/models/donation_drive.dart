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
}
