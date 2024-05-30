import 'dart:io';
import 'package:cmsc23_project/donor-view/donation_buttons/donation_checkbox.dart';
import 'package:cmsc23_project/donor-view/donation_buttons/donation_dropdown.dart';
import 'package:cmsc23_project/donor-view/donation_buttons/image_url_display.dart';
import 'package:cmsc23_project/providers/donation_storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cmsc23_project/providers/donation_providers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../providers/textfield_providers.dart';
import '../donation_buttons/dateTimePicker.dart';

class DonorPage extends StatefulWidget {
  final String organization;
  final Map<String, dynamic> donorDetails;

  DonorPage({required this.organization, required this.donorDetails});

  @override
  _DonorPageState createState() => _DonorPageState();
}

class _DonorPageState extends State<DonorPage> {
  final _formKey = GlobalKey<FormState>();
  late String organization;
  bool generate = false;
  String qrcodeinput = "";
  bool datetimepicked = false;
  List<String> addressesList = [];
  List<String> imageUrls = []; 
  late Map<String, dynamic> donorDetails;

  bool isNumeric(String str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }

  @override
  void initState() {
    super.initState();
    organization = widget.organization;
    donorDetails = widget.donorDetails;
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    var donationProvider = context.watch<DonationProvider>();
    final provider = context.watch<TextfieldProviders>();

    bool containsWeight(String weight) {
      RegExp regex = RegExp(r'\d+(\.\d+)?\s*(kg|lbs)');
      return regex.hasMatch(weight);
    }

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
        leading: IconButton(
          icon: Icon(Icons.home, color: const Color.fromRGBO(55, 61, 102, 1)),
          onPressed: () {
            provider.controller4.clear();
            Navigator.pop(context);
            Navigator.pushNamed(context, "/donorHomepage",
                arguments: donorDetails);
          },
        ),
        actions: [],
      ),
      extendBodyBehindAppBar: true,
      body: Form(
        key: _formKey,
        child: Stack(
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
              top: screenSize.height * 0.03,
              left: screenSize.width * 0.04,
              right: screenSize.width * 0.04,
              bottom: screenSize.height * 0.04,
              child: Center(
                child: Container(
                  width: screenSize.width * 0.8,
                  child: ListView(
                    shrinkWrap: true,
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
                      SizedBox(height: screenSize.height * 0.015),
                      Column(
                        children: donationProvider.donationItems.map((item) {
                          return DonationCheckbox(
                            itemName: item.itemName,
                            isChecked: item.isChecked,
                            onChanged: (isChecked) {
                              donationProvider.toggleItemCheck(item, isChecked!);
                              provider.category = donationProvider.getCheckedItems();
                              print(provider.category);
                            },
                          );
                        }).toList(),
                      ),
                      SizedBox(height: screenSize.height * 0.01),
                      Text("Select if the items are for pickup or drop-off"),
                      SizedBox(height: screenSize.height * 0.01),
                      DropdownMenuExample(),
                      SizedBox(height: screenSize.height * 0.01),
                      TextFormField(
                        controller: provider.controller4,
                        onChanged: provider.updateWeight,
                        decoration: InputDecoration(
                          labelText: 'Weight of items (indicate if in kg or lbs)',
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please enter the weight";
                          }
                          if (val.trim().isEmpty) {
                            return "Please enter the weight";
                          }
                          if (containsWeight(val) != true) {
                            return "Please enter the weight in kg/lbs";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: screenSize.height * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(Icons.camera_alt),
                            color: Color(0xFF373D66),
                            iconSize: 30,
                            onPressed: () {
                              _openCamera(context);
                            },
                          ),
                          SizedBox(width: screenSize.width * 0.04),
                          IconButton(
                            icon: Icon(Icons.photo_library),
                            color: Color(0xFF373D66),
                            iconSize: 30,
                            onPressed: () {
                              _openGallery(context);
                            },
                          ),
                        ],
                      ),
                      ImageUrlDisplay(imageUrls: imageUrls),
                      SizedBox(height: screenSize.height * 0.005),
                      DateTimePicker(),
                      provider.datetimepicked == true ? showDateTimePicked(provider.dateTime) : const SizedBox.shrink(),
                      provider.shippingOpt == 'Pick up'
                          ? forPickUpInputs(context)
                          : const SizedBox.shrink(),
                      provider.shippingOpt == 'Drop-off'
                          ? ifDropOff(context)
                          : const SizedBox.shrink(),
                      generate ? qrCodeImage(qrcodeinput) : const SizedBox.shrink(),
                      generate ? submitDropOff(context) : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget forPickUpInputs(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final provider = context.watch<TextfieldProviders>();
    generate = false;

    return Column(
      children: [
        Divider(
          thickness: 1,
          color: const Color(0xFFFCBE4F),
        ),
        Text(
          "Separate multiple entries with semi-colons. Leave no space in between (e.g. Address 1;Address 2)",
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Poppins-Reg',
            fontWeight: FontWeight.w600,
            color: Color(0xFF373D66),
          ),
          textAlign: TextAlign.center,
        ),
        Divider(
          thickness: 1,
          color: const Color(0xFFFCBE4F),
        ),
        SizedBox(height: screenSize.height * 0.01),
        TextFormField(
          controller: provider.controller5,
          onChanged: provider.updateAddresses,
          validator: (val) {
            if (val!.isEmpty) {
              return "Please enter a valid address or addresses";
            }
            if (val.trim().isEmpty) {
              return "Please enter a valid address or addresses";
            }
            return null;
          },
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins-Reg',
            color: Color(0xFF373D66),
          ),
          decoration: InputDecoration(
            labelText: 'Please enter the address for pickup',
          ),
        ),
        TextFormField(
          controller: provider.controller6,
          onChanged: provider.updateContactNumber,
          validator: (val) {
            if (val!.isEmpty) {
              return "Please enter your contact number";
            }
            if (val.trim().isEmpty) {
              return "Please enter your contact number";
            }
            if (isNumeric(val) != true) {
              return "Please enter a valid contact number";
            }
            return null;
          },
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins-Reg',
            color: Color(0xFF373D66),
          ),
          decoration: InputDecoration(
            labelText: 'Please enter the contact number for pickup',
          ),
        ),
        SizedBox(height: screenSize.height * 0.015),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final donorName = donorDetails['name'];
              final weight = provider.controller4.text;
              final addressesUnsplit = provider.controller5.text;
              final contactNumber = provider.controller6.text;
              final donorEmail = donorDetails['email'];
              final status = 'Pending';

              bool multipleAddresses = addressesUnsplit.contains(';');

              if (multipleAddresses == true) {
                addressesList =
                    addressesUnsplit.split(';').map((address) => address.trim()).toList();
              } else {
                addressesList = [addressesUnsplit];
              }

              final donationService = Provider.of<DonationStorageProvider>(context, listen: false).firebaseService;

              if (provider.category.length == 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please add at least one donation category.'),
                  ),
                );
              } else {
                final donation = DonationStorageProvider().donationDataPickUp(
                    donorName, donorEmail, provider.date, provider.time, addressesList,
                    provider.contactNumber, status, provider.category, provider.shippingOpt, weight, imageUrls);

                donationService.addDonation(donation, imageUrls); // add to firebase

                Navigator.pop(context);
                Navigator.pushNamed(context, "/donorHomepage", arguments: donorDetails);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Thank you for your donation request! Check back regularly for your donation status updates.'),
                  ),
                );
              }
            };
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(55, 61, 102, 1),
            textStyle: TextStyle(
              fontSize: 16,
            ),
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.2, vertical: screenSize.height * 0.01), // Adjusted padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          child: Text(
            'Send Donation', 
            style: TextStyle(
              color: const Color.fromRGBO(252, 190, 79, 1), 
              fontFamily: "Montserrat",
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ],
    );
  }

  Widget showDateTimePicked(DateTime dateandtime) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        dateandtime.toString(),
      ),
    );
  }

  Widget submitDropOff(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final provider = context.watch<TextfieldProviders>();
    final dateOfDropOff = provider.date;

    return Column(
      children: [
        SizedBox(height: screenSize.height * 0.02),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final weight = provider.controller4.text;
              final donorEmail = donorDetails['email'];
              final donorName = donorDetails['name'];
              final status = 'Pending';

              final donationService =
                  Provider.of<DonationStorageProvider>(context, listen: false).firebaseService;

              if (provider.category.length == 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please add at least one donation category.'),
                  ),
                );
              } else {
                final donation = DonationStorageProvider().donationDataDropOff(
                    donorName, donorEmail, provider.date, provider.time, status,
                    provider.category, provider.shippingOpt, provider.qrcodeinput, weight, imageUrls);

                donationService.addDonation(donation, imageUrls); // add to firebase

                Navigator.pop(context);
                Navigator.pushNamed(context, "/donorHomepage", arguments: donorDetails);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Thank you for your donation request! Check back regularly for your donation status updates.'),
                  ),
                );
              }
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(55, 61, 102, 1),
            textStyle: TextStyle(
              fontSize: 16,
            ),
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.2, vertical: screenSize.height * 0.015), // Adjusted padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          child: Text(
            'Send Donation', 
            style: TextStyle(
              color: const Color.fromRGBO(252, 190, 79, 1), 
              fontFamily: "Montserrat",
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ],
    );
  }

  Widget ifDropOff(BuildContext context) {
    final provider = context.watch<TextfieldProviders>();
    if (provider.datetimepicked != true) {
      return Text('Select date for drop-off first.',
      style: 
      TextStyle(
        color: Color(0xFF373D66),
        ),
      );
    } else {
      final dateOfDropOff = provider.date;

      return Column(
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                qrcodeinput = dateOfDropOff;
                generate = true;
              });
            },
            child: Text('Generate QR Code'),
          ),
        ],
      );
    }
  }

  Widget qrCodeImage(String qrcodeinput) {
    final donorEmail = donorDetails['email'];
    String dateandstatus = 'Pending' + "|" + qrcodeinput + "|" + donorEmail;
    final provider = context.watch<TextfieldProviders>();
    provider.updateQRCodeInput(dateandstatus);

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: QrImageView(
          data: dateandstatus,
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
    );
  }

  void _openCamera(BuildContext context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      File imageFile = File(pickedImage.path);
      uploadImage(imageFile);
    }
  }

  void _openGallery(BuildContext context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      File imageFile = File(pickedImage.path);
      uploadImage(imageFile);
    }
  }

  void uploadImage(File imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('donation_images/$fileName.jpg');
      await firebaseStorageRef.putFile(imageFile);
      String imageUrl = await firebaseStorageRef.getDownloadURL();
      setState(() {
        imageUrls.add(imageUrl);
      });
    } catch (e) {
      print("Error uploading image: $e");
    }
  }
}

