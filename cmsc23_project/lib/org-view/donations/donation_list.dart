import 'package:cmsc23_project/models/donation.dart';
import 'package:cmsc23_project/org-view/donations/donation_details.dart';
import 'package:cmsc23_project/org-view/org_view_styles.dart';
import 'package:cmsc23_project/providers/current_org_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonationList extends StatefulWidget {
  // Lists all donations made to the organization
  const DonationList({super.key});

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
    List<Donation> donations = context.read<CurrentOrgProvider>().donations;

    List<Donation> filteredDonations = donations.where((donation) {
      return (donation.donorUsername + donation.status.name)
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
                  leading: CircleAvatar(
                    backgroundImage: filteredDonations[index].donorImage,
                  ),
                  title: Text(filteredDonations[index].donorUsername),
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
