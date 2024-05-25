import 'package:cmsc23_project/providers/donation_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cmsc23_project/donor-view/donation_page/favorite_page.dart';
import 'package:cmsc23_project/donor-view/donation_page/org_details_page.dart';

class DonorHomepage extends StatefulWidget {
  const DonorHomepage({super.key});

  @override
  _DonorHomepageState createState() => _DonorHomepageState();
}

class _DonorHomepageState extends State<DonorHomepage> {
  List<String> filteredOrganizations = [];
  DonationProvider _donationProvider = DonationProvider();

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
    final Map<String, dynamic> donorDetails = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Donor Homepage",
          style: TextStyle(
            fontFamily: "Montserrat",
            color: const Color.fromRGBO(55, 61, 102, 1),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        actions: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 3.0,
              ),
            ),
            child: const CircleAvatar(
              backgroundImage: AssetImage("images/profile.jpg"),
              radius: 30.0,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                "Menu",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                ),
              ),
            ),
            ListTile(
              title: const Text(
                "Home",
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(
                "Profile",
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(
                "Favorite",
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoritePage(),
                  settings: RouteSettings(arguments: donorDetails)),
                );
              },
            ),
            ListTile(
              title: Text(
                "Log Out",
                style: TextStyle(fontSize: 20),
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
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/wallpaper.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: AppBar().preferredSize.height + 80,
            left: 30,
            right: 30,
            bottom: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  onChanged: filterOrganizations,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: "Montserrat",
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Search...",
                    hintStyle: TextStyle(fontSize: 16),
                    prefixIcon: Icon(Icons.search),
                    contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        color: Color(0xffd3dde4),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Color(0xffd3dde4),
                        width: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(55, 61, 102, 1),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset(
                                "images/icon.png",
                                fit: BoxFit.scaleDown,
                              ),
                              const SizedBox(width: 0),
                              const Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Donate",
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: const Color.fromRGBO(252, 190, 79, 1),
                                        fontFamily: "Montserrat",
                                      ),
                                    ),
                                    SizedBox(height: 0),
                                    Text(
                                      "Now!",
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: const Color.fromRGBO(252, 190, 79, 1),
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
                const SizedBox(height: 20.0),
                Expanded(
                  child: SingleChildScrollView(
                    child: Wrap(
                      spacing: 25,
                      runSpacing: 20,
                      children: [
                        for (String org in filteredOrganizations)
                          GestureDetector(
                            onTap: () {
                              context.read<DonationProvider>().setOrganization(org);
                              Map<String, List<String>> organizationDetails = context.read<DonationProvider>().organizationDetails;
                              String details = organizationDetails[org]?.join('\n') ?? '';
                              Map<String, String> detailsMap = {'Details': details};
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
                                  height: 190,
                                  width: 163,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          child: Image.asset(
                                            "images/$org.jpg",
                                            width: 148,
                                            height: 120,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
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
                                                fontSize: 14,
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
                                  top: 5,
                                  right: 5,
                                  child: GestureDetector(
                                    onTap: () {
                                      Provider.of<DonationProvider>(context, listen: false).toggleFavorite(org);
                                    },
                                    child: Container(
                                      width: 29,
                                      height: 29,
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(55, 61, 102, 1),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Center(
                                        child: Consumer<DonationProvider>(
                                          builder: (context, provider, _) {
                                            return Icon(
                                              Icons.favorite,
                                              color: provider.isOrganizationFavorite(org) ? 
                                              const Color.fromRGBO(252, 190, 79, 1) :
                                              Colors.transparent,
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
