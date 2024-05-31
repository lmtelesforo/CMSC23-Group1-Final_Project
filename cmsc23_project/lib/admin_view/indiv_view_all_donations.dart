import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cmsc23_project/models/indiv_donation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../providers/textfield_providers.dart';

class IndivViewAllDonations extends StatefulWidget {
  final DocumentSnapshot donationDetails;

  const IndivViewAllDonations({Key? key, required this.donationDetails})
      : super(key: key);

  @override
  State<IndivViewAllDonations> createState() => _IndivViewAllDonationsState();
}

class _IndivViewAllDonationsState extends State<IndivViewAllDonations> {
  late Donation donation;

  @override
  void initState() {
    super.initState();
    donation = Donation.fromJson(
        widget.donationDetails.data() as Map<String, dynamic>);
    donation.id = widget.donationDetails.id;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TextfieldProviders>();
    final int index;

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
                Navigator.pop(context);
                Navigator.pushNamed(context, "/viewAllDonations");
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
            top: MediaQuery.of(context).size.height * 0.27,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Category/ies:',
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
                        donation.shipping == 'Pick up'
                            ? showAddressandContact()
                            : const SizedBox.shrink(),
                        donation.shipping == 'Drop-off'
                            ? showGeneratedQR()
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
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
                  'Address/es:',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Poppins-Bold',
                    color: Color(0xFF373D66),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    donation.addresses?.first,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins-Reg',
                      color: Color(0xFF373D66),
                    ),
                  ),
                ),
              ],
            ),
            (donation.addresses!.length > 1)
                ? newAddressLine() // if true
                : const SizedBox.shrink(), // if false
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
            padding: const EdgeInsets.only(left: 120),
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

  Widget newAddressLine() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        donation.addresses!.length - 1,
        (index) {
          return Padding(
            padding: const EdgeInsets.only(left: 106),
            child: Text(
              donation.addresses![index + 1],
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

  Widget showGeneratedQR() {
    final donorEmail = donation.email;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Column(children: [
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
}
