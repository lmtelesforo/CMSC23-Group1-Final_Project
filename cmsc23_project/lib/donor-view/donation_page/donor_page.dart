import 'package:cmsc23_project/donor-view/donation_buttons/donation_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cmsc23_project/providers/donation_providers.dart';
import 'package:cmsc23_project/donor-view/donation_buttons/donation_dropdown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../providers/textfield_providers.dart';

class DonorPage extends StatefulWidget {
  final String organization;

  DonorPage({required this.organization});

  @override
  _DonorPageState createState() => _DonorPageState();
}

class _DonorPageState extends State<DonorPage> {
  final _formKey = GlobalKey<FormState>();
  late String organization; 
  bool generate = false;
  String qrcodeinput = "";

  @override
  void initState() {
    super.initState();
    organization = widget.organization;
  }
  
  @override
  Widget build(BuildContext context) {
    var donationProvider = context.watch<DonationProvider>();
    final provider = context.watch<TextfieldProviders>();

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
              top: AppBar().preferredSize.height + 50,
              left: 30,
              right: 30,
              bottom: 20,
              child: SingleChildScrollView(
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
                    provider.shippingOpt == 'Drop-off' ? ifDropOff(context) : const SizedBox.shrink(),
                    generate ? qrCodeImage(qrcodeinput) : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ifDropOff(BuildContext context) {
    final provider = context.watch<TextfieldProviders>();

    return Column (
      children: [
        TextFormField(
          controller: provider.controller7,
          onChanged: provider.updateQRCodeInput,
          validator: (val) {
            if (val!.isEmpty) {
              return "Please enter date of drop-off";
            }
            if (val.trim().isEmpty) {
              return "Please enter date of drop-off";
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
            labelText: 'Please enter date of drop-off',
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              setState(() {
                qrcodeinput = provider.controller7.text;
                generate = true;
              });
            }
          },
          child: Text('Generate QR Code'),
        ),
      ],
    );
  }

  Widget qrCodeImage(String qrcodeinput) {
    String dateandstatus = qrcodeinput + ',Pending';
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
      child: QrImageView(
        data: dateandstatus,
        version: QrVersions.auto,
        size: 200.0,
      ),
    );
  }

  void _openCamera(BuildContext context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      // Handle the picked image
    }
  }

  void _openGallery(BuildContext context) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      // Handle the picked image
    }
  }
}
