import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/donation_provider.dart';

class DonorPage extends StatelessWidget {
  final String organization;

  DonorPage({required this.organization});

  @override
  Widget build(BuildContext context) {
    var donationProvider = context.watch<DonationProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(organization),
      ),
      body: ListView(
        children: donationProvider.donationItems.map((item) {
          return CheckboxListTile(
            title: Text(item.itemName),
            value: item.isChecked,
            onChanged: (isChecked) {
              donationProvider.toggleItemCheck(item, isChecked!);
            },
          );
        }).toList(),
      ),
    );
  }
}
