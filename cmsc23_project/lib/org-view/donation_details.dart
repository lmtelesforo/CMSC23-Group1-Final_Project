import 'package:cmsc23_project/models/donation.dart';
import 'package:cmsc23_project/org-view/base_screen.dart';
import 'package:flutter/material.dart';

class DonationDetails extends StatelessWidget {
  final Donation donation;
  const DonationDetails({required this.donation, super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: _donationCard,
    );
  }

  Widget get _donationCard => Card(
        child: Column(
          children: [
            Text(donation.user.name),
          ],
        ),
      );
}
