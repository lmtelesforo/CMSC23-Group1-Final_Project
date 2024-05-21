import 'package:cmsc23_project/models/donation.dart';
import 'package:cmsc23_project/models/donation_drive.dart';
import 'package:cmsc23_project/org-view/donations/donation_details.dart';
import 'package:cmsc23_project/org-view/donation_drive/donation_drive_page.dart';
import 'package:cmsc23_project/org-view/org_view_styles.dart';
import 'package:flutter/material.dart';

class DonationDriveCard extends StatelessWidget {
  // Represents a donation drive card on the homepage and donation drive list
  final DonationDrive donationDrive;

  const DonationDriveCard({
    super.key,
    required this.donationDrive,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 150,
          width: 180,
          child: Card(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DonationDriveScreen(
                      donationDrive: donationDrive,
                    ),
                  ),
                );
              },
              child: _cardContent,
            ),
          ),
        ),
        if (true) _favoriteIcon,
      ],
    );
  }

  Widget get _cardContent => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image(
              image: donationDrive.image,
              height: 90,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(donationDrive.name, style: CustomTextStyle.body),
          ),
        ],
      );

  Widget get _favoriteIcon => Positioned(
        top: 5,
        right: 5,
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
            color: CustomColors.primary,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.favorite,
            color: CustomColors.secondary,
          ),
        ),
      );
}

class DonationList extends StatefulWidget {
  // Lists all donations made to the organization
  final List<Donation> donations;

  const DonationList(this.donations, {super.key});

  @override
  State<DonationList> createState() => _DonationListState();
}

class _DonationListState extends State<DonationList> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 300,
        child: Card(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                _searchBar,
                _donationTiles,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _searchBar => Container(
        padding: const EdgeInsets.all(8),
        child: SearchBar(
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
          hintText: 'Search for a donation',
          trailing: const [Icon(Icons.search)],
        ),
      );

  Widget get _donationTiles {
    List<Donation> filteredDonations = widget.donations.where((donation) {
      return donation.user.name
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());
    }).toList();

    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(top: 8),
        child: ListView.builder(
          itemCount: filteredDonations.length,
          itemBuilder: (context, index) {
            return Card(
              color: CustomColors.secondary,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DonationDetails(
                        donation: filteredDonations[index],
                      ),
                    ),
                  );
                },
                child: ListTile(
                  leading: filteredDonations[index].statusIcon,
                  title: Text(filteredDonations[index].user.name),
                  trailing: Text(filteredDonations[index].status.name),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
