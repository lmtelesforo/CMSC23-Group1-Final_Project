import 'package:cmsc23_project/donor-view/donation_page/donor_page.dart';
import 'package:cmsc23_project/donor-view/donor_items/organization_list.dart';
import 'package:flutter/material.dart';

class DonorHomepage extends StatefulWidget {
  const DonorHomepage({super.key});

  @override
  _DonorHomepageState createState() => _DonorHomepageState();
}

class _DonorHomepageState extends State<DonorHomepage> {
  List<String> filteredOrganizations = [];

  @override
  void initState() {
    super.initState();
    // Initially, set filtered organizations to all organizations
    filteredOrganizations.addAll(organizations);
  }

  void filterOrganizations(String query) {
    setState(() {
      filteredOrganizations = organizations
          .where((org) => org.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Donor Homepage",
          style: TextStyle(
            fontFamily: "Montserrat",
            color: Colors.white,
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
              title: const Text(
                "Log Out",
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, "/", (route) => false);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('User logged out!'),
                  ),
                );
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
            left: 16,
            right: 16,
            bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  onChanged: filterOrganizations,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: "Montserrat",
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Search...",
                    prefixIcon: const Icon(Icons.search),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Color(0xffd3dde4),
                        width: 3,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Color(0xffd3dde4),
                        width: 3,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                                "images/icon.jpg",
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
                                        fontSize: 38,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(
                                            74, 66, 155, 1),
                                        fontFamily: "Montserrat",
                                      ),
                                    ),
                                    SizedBox(height: 0),
                                    Text(
                                      "Now!",
                                      style: TextStyle(
                                        fontSize: 38,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(
                                            74, 66, 155, 1),
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DonorPage(organization: org),
                                ),
                              );
                            },
                            child: Stack(
                              children: [
                                Container(
                                  height: 200,
                                  width: 177,
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
                                            width: 161,
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
                                              org.split(" ")[0],
                                              style: const TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              org.split(" ")[1],
                                              style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 16,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: const BoxDecoration(
                                      color:
                                          Color.fromRGBO(31, 39, 78, 1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.favorite,
                                      color: Colors.white,
                                      size: 25,
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
