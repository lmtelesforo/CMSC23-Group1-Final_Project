import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23_project/models/indiv_donation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../providers/donation_storage_provider.dart';
import '../../providers/textfield_providers.dart';
import 'user_view_own_donations.dart';

class UserIndivViewDonation extends StatefulWidget {
  final DocumentSnapshot donationDetails;
  final Map<String, dynamic> donorDetails;

  const UserIndivViewDonation(
      {Key? key, required this.donationDetails, required this.donorDetails})
      : super(key: key);

  @override
  State<UserIndivViewDonation> createState() => _IndivViewAllDonationsState();
}

class _IndivViewAllDonationsState extends State<UserIndivViewDonation> {
  late Donation donation;
  late Map<String, dynamic> donorDetails;

  @override
  void initState() {
    super.initState();
    donation = Donation.fromJson(
        widget.donationDetails.data() as Map<String, dynamic>);
    donation.id = widget.donationDetails.id;
    donorDetails = widget.donorDetails;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TextfieldProviders>();
    final int index;
    print("Donation Status: ${donation.status}");

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image:
                      AssetImage('lib/user_view/assets/cmsc23_background.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.045,
            left: 0,
            right: 0,
            child: Container(
              child: Image.asset(
                'lib/user_view/assets/cmsc23_logo1.png',
                width: 60,
                height: 60,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.045,
            left: 0,
            child: TextButton.icon(
              onPressed: () {
                provider.controller4.clear();
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        UserViewAllDonations(donorDetails: donorDetails),
                  ),
                );
              },
              icon: Image.asset(
                'lib/user_view/assets/back.png',
                width: 34,
                height: 34,
              ),
              label: const Text(
                'Back',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins-Reg',
                ),
              ),
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF373D66),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.14,
            left: 0,
            right: 0,
            child: const Padding(
              padding: EdgeInsets.all(17),
              child: Text(
                "Donation Details",
                style: TextStyle(
                  fontSize: 26,
                  fontFamily: 'Poppins-Bold',
                  color: Color(0xFF373D66),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.24,
            left: MediaQuery.of(context).size.width * 0.07,
            right: MediaQuery.of(context).size.width * 0.07,
            bottom: MediaQuery.of(context).size.height * 0.04,
            child: Container(
              width: 320,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Colors.white,
              ),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Category:',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins-Bold',
                            color: Color(0xFF373D66),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            donation.category.first,
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins-Reg',
                              color: Color(0xFF373D66),
                            ),
                          ),
                        ),
                      ],
                    ),
                    (donation.category.length > 1)
                        ? newCategoryLine() // if true
                        : const SizedBox.shrink(), // if false
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        const Text(
                          'Status:',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins-Bold',
                            color: Color(0xFF373D66),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            donation.status,
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins-Reg',
                              color: Color(0xFF373D66),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        const Text(
                          'Donation Drive:',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins-Bold',
                            color: Color(0xFF373D66),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            donation.driveName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins-Reg',
                              color: Color(0xFF373D66),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        const Text(
                          'Donated by:',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins-Bold',
                            color: Color(0xFF373D66),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            donation.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins-Reg',
                              color: Color(0xFF373D66),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        const Text(
                          'Donated to:',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins-Bold',
                            color: Color(0xFF373D66),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            donation.organization,
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins-Reg',
                              color: Color(0xFF373D66),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        const Text(
                          'Donor Email:',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins-Bold',
                            color: Color(0xFF373D66),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            donation.email,
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins-Reg',
                              color: Color(0xFF373D66),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        const Text(
                          'Shipping Option:',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins-Bold',
                            color: Color(0xFF373D66),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            donation.shipping,
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins-Reg',
                              color: Color(0xFF373D66),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        const Text(
                          'Address:',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins-Bold',
                            color: Color(0xFF373D66),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            donation.address!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins-Reg',
                              color: Color(0xFF373D66),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        const Text(
                          'Contact Number:',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins-Bold',
                            color: Color(0xFF373D66),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            donation.contactNumber!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins-Reg',
                              color: Color(0xFF373D66),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        const Text(
                          'Weight:',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins-Bold',
                            color: Color(0xFF373D66),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            donation.weight,
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins-Reg',
                              color: Color(0xFF373D66),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        const Text(
                          'Date:',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins-Bold',
                            color: Color(0xFF373D66),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            donation.date,
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins-Reg',
                              color: Color(0xFF373D66),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        const Text(
                          'Time:',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins-Bold',
                            color: Color(0xFF373D66),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            donation.time,
                            style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Poppins-Reg',
                              color: Color(0xFF373D66),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      'Photos (if any):',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins-Bold',
                        color: Color(0xFF373D66),
                      ),
                    ),
                    SizedBox(height: 15),
                    donation.image?.isEmpty == false
                        ? showPhotos(donation)
                        : showNothing(),
                    const SizedBox(height: 20),
                    donation.shipping == 'Pick up'
                        ? showAddressandContact()
                        : const SizedBox.shrink(),
                    donation.shipping == 'Drop-off'
                        ? showGeneratedQR()
                        : const SizedBox.shrink(),
                    donation.image?.isEmpty == 0
                        ? showPhotos(donation)
                        : const SizedBox.shrink(),
                    donation.status.contains("Pending")
                        ? showCancelButton(donation)
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget showCancelButton(donation) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () {
          final donationService =
              Provider.of<DonationStorageProvider>(context, listen: false)
                  .firebaseService;
          donationService.updateDonationStatus(
              donation.id!, 'Cancelled'); // only delete request
          if (donation.shipping == 'Drop-off') {
            String newQRCode =
                'Cancelled' + "|" + donation.date + "|" + donation.id!;
            donationService.updateQRDetails(donation.id!, newQRCode);
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Donation cancelled.'),
            ),
          );
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  UserViewAllDonations(donorDetails: donorDetails),
            ),
          );
        },
        icon: const Icon(
          Icons.clear,
          color: Color.fromARGB(255, 181, 19, 19),
        ),
        label: const Text(
          'Cancel Donation',
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Poppins-Bold',
            color: Color(0xFF373D66),
          ),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(300, 35),
          textStyle: const TextStyle(
            fontSize: 14,
            fontFamily: 'Poppins-Bold',
          ),
          backgroundColor: const Color(0xFFFCBE4F),
        ),
      ),
    );
  }

  Widget showAddressandContact() {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Address:',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Poppins-Bold',
                    color: Color(0xFF373D66),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    donation.address!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins-Reg',
                      color: Color(0xFF373D66),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 7),
        Row(
          children: [
            const Text(
              'Contact Number:',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins-Bold',
                color: Color(0xFF373D66),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                donation.contactNumber!,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Poppins-Reg',
                  color: Color(0xFF373D66),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget newCategoryLine() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        donation.category.length - 1,
        (index) {
          return Padding(
            padding: const EdgeInsets.only(left: 88),
            child: Text(
              donation.category[index + 1],
              style: const TextStyle(
                fontSize: 16,
                fontFamily: 'Poppins-Reg',
                color: Color(0xFF373D66),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget showPhotos(donation) {
    return Flexible(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: donation.image?.length,
        itemBuilder: (context, index) {
          String imageUrl = donation.image?[index];
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Image.network(
              imageUrl,
            ),
          );
        },
      ),
    );
  }

  Widget showNothing() {
    return Container(
      child: const Text(
        'None',
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'Poppins-Reg',
          color: Color(0xFF373D66),
        ),
      ),
    );
  }

  Widget showGeneratedQR() {
    final donorEmail = donation.email;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Column(children: [
        SizedBox(height: 10),
        const Text(
          'QR Code (contains Status and Date Time of Order):',
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Poppins-Bold',
            color: Color(0xFF373D66),
          ),
          textAlign: TextAlign.center,
        ),
        QrImageView(
          data: donation.qrcode!,
          version: QrVersions.auto,
          size: 200.0,
        ),
      ]),
    );
  }

//   Widget showCancelButton() {
//     return Center(
//       child: ElevatedButton.icon(
//         onPressed: () {
//           final donationService =
//               Provider.of<DonationStorageProvider>(context, listen: false)
//                   .firebaseService;
//           donationService.updateDonationStatus(
//               donation.id!, 'Cancelled'); // only delete request
//           String newQRCode =
//               'Cancelled' + "|" + donation.date + "|" + donation.id!;
//           donationService.updateQRDetails(donation.id!, newQRCode);
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Donation cancelled.'),
//             ),
//           );
//           Navigator.pop(context);
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) =>
//                   UserViewAllDonations(donorDetails: donorDetails),
//             ),
//           );
//         },
//         icon: const Icon(
//           Icons.clear,
//           color: Color.fromARGB(255, 181, 19, 19),
//         ),
//         label: const Text(
//           'Cancel Donation',
//           style: TextStyle(
//             fontSize: 14,
//             fontFamily: 'Poppins-Bold',
//             color: Color(0xFF373D66),
//           ),
//         ),
//         style: ElevatedButton.styleFrom(
//           minimumSize: const Size(300, 35),
//           textStyle: const TextStyle(
//             fontSize: 14,
//             fontFamily: 'Poppins-Bold',
//           ),
//           backgroundColor: const Color(0xFFFCBE4F),
//         ),
//       ),
//     );
//   }
}
