import 'package:cmsc23_project/models/donation.dart';
import 'package:cmsc23_project/models/donation_drive.dart';
import 'package:cmsc23_project/models/organization.dart';
import 'package:cmsc23_project/models/user.dart';
import 'package:cmsc23_project/org-view/base_screen.dart';
import 'package:cmsc23_project/org-view/donation_drive_card.dart';
import 'package:cmsc23_project/org-view/manage_donation_drives.dart';
import 'package:cmsc23_project/org-view/org_view_styles.dart';
import 'package:flutter/material.dart';

class OrgHomePage extends StatelessWidget {
  // Main homepage for the organization
  const OrgHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Test data
    final Organization org = Organization(
      name: 'Organization 1',
      profilePic: const AssetImage('assets/images/org_profile.png'),
      donationDrives: [
        DonationDrive(
          name: 'Donation Drive 1',
          date: DateTime.now(),
          image: const AssetImage('assets/images/donation_drive.jpg'),
        ),
        DonationDrive(
          name: 'Donation Drive 2',
          date: DateTime.now(),
          image: const AssetImage('assets/images/donation_drive.jpg'),
        ),
        DonationDrive(
          name: 'Donation Drive 3',
          date: DateTime.now(),
          image: const AssetImage('assets/images/donation_drive.jpg'),
        ),
      ],
    );
    org.favorite(org.donationDrives[0]);

    User abra = User(
        name: 'Abra Abra',
        profilePic: const AssetImage(
          'assets/images/profile_pic.jpg',
        ));
    org.donations.add(Donation(
      user: abra,
      organization: org,
      status: Status.confirmed,
    ));
    org.donations.add(Donation(user: abra, organization: org));
    org.donations.add(Donation(user: abra, organization: org));
    org.donations.add(Donation(user: abra, organization: org));
    org.donations.add(Donation(user: abra, organization: org));
    org.donations.add(Donation(user: abra, organization: org));

    User cadabra = User(
      name: 'Cababra Cadabra',
      profilePic: const AssetImage('assets/images/profile_pic.jpg'),
    );

    org.donations.add(
      Donation(
        user: cadabra,
        organization: org,
        status: Status.scheduledForPickup,
      ),
    );
    org.donations.add(
      Donation(user: cadabra, organization: org),
    );

    return BaseScreen(
      body: Column(
        children: [
          MainAction(org.donationDrives),
          Favorites(org.favorites),
          DonationList(org.donations),
        ],
      ),
    );
  }
}

class MainAction extends StatelessWidget {
  // The main/leading card on the org homepage
  final List<DonationDrive> donationDrives;
  const MainAction(this.donationDrives, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Card(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ManageDonationDrives(
                    donationDrives: donationDrives,
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      'Organize your donation drives',
                      style: CustomTextStyle.mainAction,
                    ),
                  ),
                  Image(
                    image: AssetImage('assets/images/xmas_box.png'),
                    height: 80,
                    width: 80,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Favorites extends StatelessWidget {
  // List of favorited donation drives
  final List<DonationDrive> favorites;
  const Favorites(this.favorites, {super.key});

  @override
  Widget build(BuildContext context) {
    // Favorites are centered using row if they can fit in the parent container
    // Otherwise, they are built with a horizontal, scrollable listview
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final totalWidth = favorites.length * (200);

        return Container(
          height: 200,
          padding: const EdgeInsets.only(bottom: 10),
          child: totalWidth < constraints.maxWidth
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: favorites.map((favorite) {
                    return DonationDriveCard(donationDrive: favorite);
                  }).toList(),
                )
              : ListView.builder(
                  itemCount: favorites.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: DonationDriveCard(donationDrive: favorites[index]),
                    );
                  },
                ),
        );
      },
    );
  }
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
                searchBar,
                donationTiles,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get searchBar => Container(
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

  Widget get donationTiles => Expanded(
        child: Container(
          padding: const EdgeInsets.only(top: 8),
          child: ListView.builder(
            itemCount: widget.donations.length,
            itemBuilder: (context, index) {
              if (widget.donations[index].user.name
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase())) {
                return Card(
                  color: const Color(0xFFFCBE4F),
                  child: ListTile(
                    leading: widget.donations[index].statusIcon,
                    title: Text(widget.donations[index].user.name),
                    trailing: Text(widget.donations[index].status.name),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      );
}
