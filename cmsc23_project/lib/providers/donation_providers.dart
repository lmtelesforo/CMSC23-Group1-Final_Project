import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DonationProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> _organizations = [];
  List<DonationItem> _donationItems = [];
  String _selectedOrganization = '';
  final Map<String, bool> _favoriteOrganizations = {};
  final Map<String, List<String>> organizationDonations = {};
  List<String> get organizations => _organizations;
  List<DonationItem> get donationItems => _donationItems;
  String get selectedOrganization => _selectedOrganization;
  Map<String, bool> get favoriteOrganizations => _favoriteOrganizations;

  Future<void> fetchOrganizations() async {
    List<String> organizations = [];

    try {
      // Ensure user is authenticated
      User? user = _auth.currentUser;
      if (user != null) {
        // Assuming your organizations collection has a field 'name'
        QuerySnapshot querySnapshot = await _firestore
            .collection('users')
            .get();

        // Extract organization names
        querySnapshot.docs.forEach((doc) {
          organizations.add(doc['name']); // Assuming field name is 'name'
        });

        // Clear existing organization donations
        organizationDonations.clear();

        // Populate organization donations
        organizations.forEach((org) {
          organizationDonations[org] = [
            "Food",
            "Clothes",
            "Cash",
            "Necessities",
            "Others"
          ];
        });

        // Update donation items with items for the first organization
        if (organizations.isNotEmpty) {
          _selectedOrganization = organizations.first;
          _donationItems = getDonationItemsForOrganization(_selectedOrganization);
        }
      }
    } catch (e) {
      print("Error fetching organizations: $e");
    }

    notifyListeners();
  }

  void setOrganization(String organization) {
    _selectedOrganization = organization;
    _donationItems = getDonationItemsForOrganization(organization);
    notifyListeners();
  }

  List<DonationItem> getDonationItemsForOrganization(String organization) {
    return organizationDonations[organization]!
        .map((itemName) => DonationItem(itemName: itemName, isChecked: false))
        .toList();
  }

  void toggleItemCheck(DonationItem item, bool isChecked) {
    item.isChecked = isChecked;
    notifyListeners();
  }

  List<dynamic> getCheckedItems() {
    return _donationItems
        .where((item) => item.isChecked)
        .map((item) => item.itemName.toString())
        .toList();
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
