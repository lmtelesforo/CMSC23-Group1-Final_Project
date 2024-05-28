import 'package:cmsc23_project/models/indiv_donation.dart';
import 'package:cmsc23_project/org-view/base_elements/org_view_styles.dart';
import 'package:cmsc23_project/providers/current_org_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonationList extends StatefulWidget {
  // Lists all donations made to the organization (or optionally, drive)
  final String? orgUsername;
  final String? driveName;

  const DonationList({this.orgUsername, this.driveName, super.key});

  @override
  State<DonationList> createState() => _DonationListState();
}

class _DonationListState extends State<DonationList> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 300,
        child: Card(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                _searchBar,
                const SizedBox(height: 8),
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
    bool isDrive = widget.driveName != null;

    // Used to sort donations by status/progress
    List<String> statusSort = [
      'Pending',
      'Confirmed',
      'Scheduled for Pickup',
      'Completed',
      'Cancelled',
    ];

    bool matchesQuery(Donation donation) {
      return (donation.name + donation.status)
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());
    }

    return Expanded(
      child: StreamBuilder(
        // Check if the list of donations is for a specific drive or all donations
        stream: isDrive
            ? context
                .read<CurrentOrgProvider>()
                .donationsByDrive(widget.driveName)
            : context.read<CurrentOrgProvider>().donations,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('An error occurred');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Filter donations based on search query

          Map<Donation, String> donations = Map.fromEntries(snapshot.data!.docs
              .map((doc) => MapEntry(
                  Donation.fromJson(doc.data() as Map<String, dynamic>),
                  doc.id))
              .where((entry) => matchesQuery(entry.key)));

          // Sort donations by status
          List<Donation> filteredDonations = donations.keys.toList()
            ..sort((a, b) => statusSort
                .indexOf(a.status)
                .compareTo(statusSort.indexOf(b.status)));

          return ListView.builder(
            itemCount: filteredDonations.length,
            itemBuilder: (context, index) {
              return _tile(filteredDonations[index],
                  donations[filteredDonations[index]]!);
            },
          );
        },
      ),
    );
  }

  Card _tile(Donation donation, String id) {
    return Card(
      color: _getTileColor(donation.status),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/org/donation',
              arguments: [donation, id]);
        },
        child: ListTile(
          leading: statusIcon(donation.status),
          title: Text(donation.name),
          trailing: Text(donation.status),
        ),
      ),
    );
  }

  Color _getTileColor(String status) {
    return status == 'Cancelled' || status == 'Complete'
        ? Colors.grey
        : CustomColors.secondary;
  }
}
