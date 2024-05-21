import 'package:flutter/material.dart';

class DonationProvider with ChangeNotifier {
  List<String> organizations = [
    "Animal Welfare Organizations",
    "Charitable Organizations",
    "Disaster Relief Organizations",
    "Education Foundations",
    "Environmental Organizations",
    "Health Organization",
    "Human Rights Groups",
    "Religious Organizations",
    "Research Institutions",
    "Social Justice and Advocacy Groups"
  ];

  List<DonationItem> _donationItems = [];
  String _selectedOrganization = '';

  // New map to track favorite organizations
  Map<String, bool> _favoriteOrganizations = {};

  List<DonationItem> get donationItems => _donationItems;
  String get selectedOrganization => _selectedOrganization;

  // Getter for favorite organizations
  Map<String, bool> get favoriteOrganizations => _favoriteOrganizations;

  final Map<String, List<String>> organizationDonations = {
    "Animal Welfare Organizations": ["Food", "Clothes", "Cash", "Necessities", "Others"],
    "Charitable Organizations": ["Food", "Clothes", "Cash", "Necessities", "Others"],
    "Disaster Relief Organizations": ["Food", "Clothes", "Cash", "Necessities", "Others"],
    "Education Foundations": ["Food", "Clothes", "Cash", "Necessities", "Others"],
    "Environmental Organizations": ["Food", "Clothes", "Cash", "Necessities", "Others"],
    "Health Organization": ["Food", "Clothes", "Cash", "Necessities", "Others"],
    "Human Rights Groups": ["Food", "Clothes", "Cash", "Necessities", "Others"],
    "Religious Organizations": ["Food", "Clothes", "Cash", "Necessities", "Others"],
    "Research Institutions": ["Food", "Clothes", "Cash", "Necessities", "Others"],
    "Social Justice and Advocacy Groups": ["Food", "Clothes", "Cash", "Necessities", "Others"],
  };

  void setOrganization(String organization) {
    _selectedOrganization = organization;
    _donationItems = _getDonationItemsForOrganization(organization);
    notifyListeners();
  }

  void toggleItemCheck(DonationItem item, bool isChecked) {
    item.isChecked = isChecked;
    notifyListeners();
  }

  List<DonationItem> _getDonationItemsForOrganization(String organization) {
    return organizationDonations[organization]!
        .map((itemName) => DonationItem(itemName: itemName, isChecked: false))
        .toList();
  }

  // Method to toggle favorite status of an organization
  void toggleFavorite(String organization) {
    if (_favoriteOrganizations.containsKey(organization)) {
      _favoriteOrganizations[organization] = !_favoriteOrganizations[organization]!;
    } else {
      _favoriteOrganizations[organization] = true;
    }
    notifyListeners();
  }

  // Method to check if an organization is a favorite
  bool isOrganizationFavorite(String organization) {
    return _favoriteOrganizations[organization] ?? false;
  }

  List<String> getFavoriteOrganizations() {
    return _favoriteOrganizations.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
  }
}

class DonationItem {
  final String itemName;
  bool isChecked;

  DonationItem({required this.itemName, required this.isChecked});
}
