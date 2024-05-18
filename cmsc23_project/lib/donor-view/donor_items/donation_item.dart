List<DonationItem> getDonationItemsForOrganization(String organization) {
  // Replace this with your logic to get donation items for the selected organization
  // For example, you could query a database or use hardcoded values based on the organization
  // For demonstration, I'll return some hardcoded donation items
  if (organization == "Animal Welfare Organizations") {
    return [
      DonationItem(itemName: "Food", isChecked: false),
      DonationItem(itemName: "Clothes", isChecked: false),
      DonationItem(itemName: "Cash", isChecked: false),
      DonationItem(itemName: "Necessities", isChecked: false),
      DonationItem(itemName: "Others", isChecked: false),
    ];
  } else if (organization == "Charitable Organizations") {
    return [
      DonationItem(itemName: "Food", isChecked: false),
      DonationItem(itemName: "Clothes", isChecked: false),
      DonationItem(itemName: "Cash", isChecked: false),
      DonationItem(itemName: "Necessities", isChecked: false),
      DonationItem(itemName: "Others", isChecked: false),
    ];
  } else if (organization == "Disaster Relief Organizations") {
    return [
      DonationItem(itemName: "Food", isChecked: false),
      DonationItem(itemName: "Clothes", isChecked: false),
      DonationItem(itemName: "Cash", isChecked: false),
      DonationItem(itemName: "Necessities", isChecked: false),
      DonationItem(itemName: "Others", isChecked: false),
    ];
  } else if (organization == "Education Foundations") {
    return [
      DonationItem(itemName: "Food", isChecked: false),
      DonationItem(itemName: "Clothes", isChecked: false),
      DonationItem(itemName: "Cash", isChecked: false),
      DonationItem(itemName: "Necessities", isChecked: false),
      DonationItem(itemName: "Others", isChecked: false),
    ];
  } else if (organization == "Environmental Organizations") {
    return [
      DonationItem(itemName: "Food", isChecked: false),
      DonationItem(itemName: "Clothes", isChecked: false),
      DonationItem(itemName: "Cash", isChecked: false),
      DonationItem(itemName: "Necessities", isChecked: false),
      DonationItem(itemName: "Others", isChecked: false),
    ];
  } else if (organization == "Health Organization") {
    return [
      DonationItem(itemName: "Food", isChecked: false),
      DonationItem(itemName: "Clothes", isChecked: false),
      DonationItem(itemName: "Cash", isChecked: false),
      DonationItem(itemName: "Necessities", isChecked: false),
      DonationItem(itemName: "Others", isChecked: false),
    ];
  } else if (organization == "Human Rights Groups") {
    return [
      DonationItem(itemName: "Food", isChecked: false),
      DonationItem(itemName: "Clothes", isChecked: false),
      DonationItem(itemName: "Cash", isChecked: false),
      DonationItem(itemName: "Necessities", isChecked: false),
      DonationItem(itemName: "Others", isChecked: false),
    ];
  } else if (organization == "Religious Organizations") {
    return [
      DonationItem(itemName: "Food", isChecked: false),
      DonationItem(itemName: "Clothes", isChecked: false),
      DonationItem(itemName: "Cash", isChecked: false),
      DonationItem(itemName: "Necessities", isChecked: false),
      DonationItem(itemName: "Others", isChecked: false),
    ];
  } else if (organization == "Research Institutions") {
    return [
      DonationItem(itemName: "Food", isChecked: false),
      DonationItem(itemName: "Clothes", isChecked: false),
      DonationItem(itemName: "Cash", isChecked: false),
      DonationItem(itemName: "Necessities", isChecked: false),
      DonationItem(itemName: "Others", isChecked: false),
    ];
  } else if (organization == "Social Justice and Advocacy Groups") {
    return [
      DonationItem(itemName: "Food", isChecked: false),
      DonationItem(itemName: "Clothes", isChecked: false),
      DonationItem(itemName: "Cash", isChecked: false),
      DonationItem(itemName: "Necessities", isChecked: false),
      DonationItem(itemName: "Others", isChecked: false),
    ];
  } else {
    return []; // Return empty list for unknown organizations
  }
}

class DonationItem {
  final String itemName;
  bool isChecked;

  DonationItem({required this.itemName, required this.isChecked});
}