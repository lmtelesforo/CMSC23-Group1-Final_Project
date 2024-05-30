import 'package:cmsc23_project/models/indiv_donation.dart';
import 'package:cmsc23_project/org-view/base_elements/org_view_styles.dart';
import 'package:flutter/material.dart';

class DonationInfo extends StatelessWidget {
  final Donation donation;
  const DonationInfo(this.donation, {super.key});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Card(
          surfaceTintColor: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(2),
              },
              children: [
                name(),
                donation.shipping == 'Pick up' ? address() : blank(),
                donation.shipping == 'Pick up' ? number() : blank(),
                donation.image != null ? images() : blank(),
                categories(),
                weight(),
                forPickup(),
                date(),
              ],
            ),
          ),
        ),
      );

  TableRow images() {
    return TableRow(
      children: [
        const Icon(Icons.image, color: CustomColors.primary),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: ListView.builder(
            itemCount: donation.image!.length,
            itemBuilder: (context, index) {
              return Image.network(donation.image![index],
                  errorBuilder: (context, error, stackTrace) {
                return const Text('Image not found',
                    style: CustomTextStyle.body);
              });
            },
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ),
      ],
    );
  }

  TableRow address() {
    return TableRow(
      children: [
        const Icon(Icons.location_on, color: CustomColors.primary),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: ListView.builder(
            itemCount: donation.addresses!.length,
            itemBuilder: (context, index) {
              return Text(
                donation.addresses![index],
                style: CustomTextStyle.body,
              );
            },
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ),
      ],
    );
  }

  TableRow name() {
    return TableRow(
      children: [
        const Icon(Icons.person, color: CustomColors.primary),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Text(
            donation.name,
            style: CustomTextStyle.body,
          ),
        ),
      ],
    );
  }

  TableRow date() {
    String date = donation.date;

    return TableRow(
      children: [
        const Icon(Icons.calendar_today, color: CustomColors.primary),
        Text(date, style: CustomTextStyle.body),
      ],
    );
  }

  TableRow forPickup() {
    return TableRow(
      children: [
        const Icon(Icons.local_shipping, color: CustomColors.primary),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: donation.shipping == 'Pick up'
              ? const Text('For Pickup', style: CustomTextStyle.body)
              : const Text('For Drop-off', style: CustomTextStyle.body),
        ),
      ],
    );
  }

  TableRow weight() {
    return TableRow(
      children: [
        const Icon(Icons.scale, color: CustomColors.primary),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Text(
            donation.weight,
            style: CustomTextStyle.body,
          ),
        ),
      ],
    );
  }

  TableRow number() {
    return TableRow(
      children: [
        const Icon(Icons.phone, color: CustomColors.primary),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Text(
            donation.contactNumber!,
            style: CustomTextStyle.body,
          ),
        ),
      ],
    );
  }

  TableRow categories() {
    return TableRow(
      children: [
        const Icon(Icons.archive, color: CustomColors.primary),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: ListView.builder(
            itemCount: donation.category.length,
            itemBuilder: (context, index) {
              return Text(
                donation.category[index],
                style: CustomTextStyle.body,
              );
            },
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ),
      ],
    );
  }

  TableRow blank() {
    return const TableRow(
      children: [
        SizedBox(),
        SizedBox(),
      ],
    );
  }
}