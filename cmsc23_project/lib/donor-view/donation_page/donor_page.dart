import 'package:cmsc23_project/donor-view/donation_buttons/donation_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cmsc23_project/providers/donation_providers.dart';
import 'package:cmsc23_project/donor-view/donation_buttons/donation_dropdown.dart';
import 'package:image_picker/image_picker.dart';

class DonorPage extends StatelessWidget {
  final String organization;

  DonorPage({required this.organization});

  @override
  Widget build(BuildContext context) {
    var donationProvider = context.watch<DonationProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white, size: 30),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Text(
                "Donation Details",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Montserrat",
                  color: const Color.fromRGBO(55, 61, 102, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(width: 8),
            SizedBox(
              width: 40,
              height: 40,
              child: Image.asset('images/logo.png'),
            ),
          ],
        ),
        actions: [],
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
            top: AppBar().preferredSize.height + 50,
            left: 30,
            right: 30,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          organization,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat",
                            color: const Color.fromRGBO(55, 61, 102, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Column(
                  children: donationProvider.donationItems.map((item) {
                    return DonationCheckbox( 
                      itemName: item.itemName,
                      isChecked: item.isChecked,
                      onChanged: (isChecked) {
                        donationProvider.toggleItemCheck(item, isChecked!);
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),
                Text("Select if the items are for pickup or drop-off"),
                SizedBox(height: 10),
                DropdownMenuExample(),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Weight of items (kg/lbs)',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {},
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _openCamera(context);
                  },
                  child: Text('Take Photo'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _openGallery(context);
                  },
                  child: Text('Upload Photo'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openCamera(BuildContext context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      // put condition
    }
  }

  void _openGallery(BuildContext context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      // put condition
    }
  }
}
