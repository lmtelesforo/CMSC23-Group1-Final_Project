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

  Map<String, bool> _favoriteOrganizations = {};

  final Map<String, List<String>> _organizationDetails = {
    "Animal Welfare Organizations": ["Details for Animal Welfare Organizations"],
    "Charitable Organizations": ["Details for Charitable Organizations"],
    "Disaster Relief Organizations": ["Details for Disaster Relief Organizations"],
    "Education Foundations": ["Details for Education Foundations"],
    "Environmental Organizations": ["Details for Environmental Organizations"],
    "Health Organization": ["Details for Health Organization"],
    "Human Rights Groups": ["Details for Human Rights Groups"],
    "Religious Organizations": ["Details for Religious Organizations"],
    "Research Institutions": ["Details for Research Institutions"],
    "Social Justice and Advocacy Groups": ["Details for Social Justice and Advocacy Groups"],
  };

  List<DonationItem> get donationItems => _donationItems;
  String get selectedOrganization => _selectedOrganization;

  Map<String, bool> get favoriteOrganizations => _favoriteOrganizations;

  Map<String, List<String>> get organizationDetails => _organizationDetails;

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
    _donationItems = getDonationItemsForOrganization(organization);
    notifyListeners();
  }

  void toggleItemCheck(DonationItem item, bool isChecked) {
    item.isChecked = isChecked;
    notifyListeners();
  }

  List<DonationItem> getDonationItemsForOrganization(String organization) {
    return organizationDonations[organization]!
        .map((itemName) => DonationItem(itemName: itemName, isChecked: false))
        .toList();
  }

  List<String> _getOrganizationDetails(String organization) {
    return organizationDetails[organization] ?? [];
  }

  void toggleFavorite(String organization) {
    if (_favoriteOrganizations.containsKey(organization)) {
      _favoriteOrganizations[organization] = !_favoriteOrganizations[organization]!;
    } else {
      _favoriteOrganizations[organization] = true;
    }
    notifyListeners();
  }

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
