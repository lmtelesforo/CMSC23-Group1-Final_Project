import 'package:cmsc23_project/donor-view/donation_buttons/donation_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:cmsc23_project/donor-view/donor_items/donation_item.dart';
import 'package:cmsc23_project/donor-view/donation_buttons/donation_checkbox.dart'; // Import the new widget

class DonorPage extends StatefulWidget {
  final String organization;

  const DonorPage({super.key, required this.organization});

  @override
  _DonorPageState createState() => _DonorPageState();
}

class _DonorPageState extends State<DonorPage> {
  List<DonationItem> donationItems =
      []; // Updated to include donation items for the selected organization

  @override
  void initState() {
    super.initState();
    // Initialize donation items based on the selected organization
    donationItems = getDonationItemsForOrganization(widget.organization);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Expanded(
              child: Text(
                "Donation Details",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Montserrat",
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 40,
              height: 40,
              child: Image.asset('images/logo.png'),
            ),
          ],
        ),
        actions: const [],
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
            top: AppBar().preferredSize.height + 70,
            left: 30,
            right: 30,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          widget.organization,
                          style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Montserrat",
                              color: Color.fromRGBO(55, 61, 102, 1)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Donation Items",
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat",
                          color: Color.fromRGBO(55, 61, 102, 1),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: donationItems.map((item) {
                          return DonationCheckbox(
                            itemName: item.itemName,
                            isChecked: item.isChecked,
                            onChanged: (value) {
                              setState(() {
                                item.isChecked = value!;
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: const DropdownMenuExample(),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Go Back"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
