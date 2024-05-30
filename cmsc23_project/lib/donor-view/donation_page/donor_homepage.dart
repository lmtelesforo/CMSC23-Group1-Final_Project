import 'package:cmsc23_project/donor-view/donation_page/profile_page.dart';
import 'package:cmsc23_project/providers/donation_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cmsc23_project/donor-view/donation_page/favorite_page.dart';
import 'package:cmsc23_project/donor-view/donation_page/org_details_page.dart';

import '../../admin_view/user_view_own_donations.dart';

class DonorHomepage extends StatefulWidget {
  const DonorHomepage({super.key});

  @override
  _DonorHomepageState createState() => _DonorHomepageState();
}

class _DonorHomepageState extends State<DonorHomepage> {
  List<String> filteredOrganizations = [];
  DonationProvider _donationProvider = DonationProvider();
  late Map<String, dynamic> donorDetails;

  @override
  void initState() {
    super.initState();
    // Initially, set filtered organizations to all organizations
    filteredOrganizations.addAll(_donationProvider.organizations);
  }

  void filterOrganizations(String query) {
    setState(() {
      filteredOrganizations = _donationProvider.organizations
          .where((org) => org.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> donorDetails =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Donor Homepage",
          style: TextStyle(
            fontFamily: "Montserrat",
            color: const Color.fromRGBO(
                55, 61, 102, 1), // Changed title color for consistency
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        iconTheme: IconThemeData(
            color: const Color.fromRGBO(55, 61, 102, 1), size: 30),
        actions: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 3.0,
              ),
            ),
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/profile_pic.jpg"),
              radius: 30.0,
            ),
          ),
          SizedBox(width: 16),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(55, 61, 102, 1),
              ),
              child: Text(
                "Menu",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text(
                "Home",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Poppins',
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(
                "Profile",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Poppins',
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage(),)
                );
              },
            ),
            ListTile(
              title: const Text(
                "Favorite",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Poppins',
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FavoritePage(),
                      settings: RouteSettings(arguments: donorDetails)),
                );
              },
            ),
            ListTile(
              title: Text(
                "View All Donations",
                style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        UserViewAllDonations(donorDetails: donorDetails),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text(
                "Log Out",
                style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/");
              },
            ),
          ],
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/wallpaper.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: AppBar().preferredSize.height + screenHeight * 0.1,
            left: screenWidth * 0.08,
            right: screenWidth * 0.08,
            bottom: screenHeight * 0.04,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  onChanged: filterOrganizations,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Montserrat",
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Search...",
                    hintStyle: const TextStyle(fontSize: 16),
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(screenHeight * 0.03),
                      borderSide: BorderSide(
                        color: Color(0xffd3dde4),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(screenHeight * 0.02),
                      borderSide: BorderSide(
                        color: Color(0xffd3dde4),
                        width: 2,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Container(
                  height: screenHeight * 0.2,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(55, 61, 102, 1),
                    borderRadius: BorderRadius.circular(screenHeight * 0.03),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        child: Padding(
                          padding: EdgeInsets.all(screenHeight * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset(
                                "images/icon.png",
                                fit: BoxFit.scaleDown,
                              ),
                              SizedBox(
                                  width:
                                      screenWidth * 0.02), // Adjusted spacing
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "images/logo.png",
                                      height: screenHeight * 0.05,
                                      width: screenHeight * 0.05,
                                    ),
                                    Text(
                                      "Donate",
                                      style: TextStyle(
                                        fontSize: screenHeight * 0.033,
                                        fontWeight: FontWeight.bold,
                                        color: const Color.fromRGBO(
                                            252, 190, 79, 1),
                                        fontFamily: "Montserrat",
                                      ),
                                    ),
                                    SizedBox(
                                        height: screenHeight *
                                            0.005), // Adjusted spacing
                                    Text(
                                      "Now!",
                                      style: TextStyle(
                                        fontSize: screenHeight * 0.033,
                                        fontWeight: FontWeight.bold,
                                        color: const Color.fromRGBO(
                                            252, 190, 79, 1),
                                        fontFamily: "Montserrat",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Expanded(
                  child: SingleChildScrollView(
                    child: Wrap(
                      spacing: screenWidth * 0.05,
                      runSpacing: screenHeight * 0.02,
                      children: [
                        for (String org in filteredOrganizations)
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<DonationProvider>()
                                  .setOrganization(org);
                              Map<String, List<String>> organizationDetails =
                                  context
                                      .read<DonationProvider>()
                                      .organizationDetails;
                              String details =
                                  organizationDetails[org]?.join('\n') ?? '';
                              Map<String, String> detailsMap = {
                                'Details': details
                              };
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OrgDetailsPage(
                                      organization: org,
                                      organizationDetails: detailsMap,
                                      donorDetails: donorDetails),
                                ),
                              );
                            },
                            child: Stack(
                              children: [
                                Container(
                                  height: screenHeight * 0.2,
                                  width: screenWidth * 0.395,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        screenHeight * 0.03),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 7,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.all(screenHeight * 0.01),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              screenHeight * 0.02),
                                          child: Image.asset(
                                            "images/$org.jpg",
                                            width: screenWidth * 0.5,
                                            height: screenHeight * 0.12,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(height: screenHeight * 0.01),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              org,
                                              style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: screenHeight * 0.016,
                                                color: Colors.black,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: screenHeight * 0.005,
                                  right: screenHeight * 0.005,
                                  child: GestureDetector(
                                    onTap: () {
                                      Provider.of<DonationProvider>(context,
                                              listen: false)
                                          .toggleFavorite(org);
                                    },
                                    child: Container(
                                      width: screenHeight * 0.033,
                                      height: screenHeight * 0.033,
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            55, 61, 102, 1),
                                        borderRadius: BorderRadius.circular(
                                            screenHeight * 0.05),
                                      ),
                                      child: Center(
                                        child: Consumer<DonationProvider>(
                                          builder: (context, provider, _) {
                                            return Icon(
                                              Icons.favorite,
                                              color:
                                                  provider.isOrganizationFavorite(
                                                          org)
                                                      ? const Color.fromRGBO(
                                                          252, 190, 79, 1)
                                                      : Colors.transparent,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
