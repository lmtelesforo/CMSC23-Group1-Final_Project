import 'package:cmsc23_project/models/donation.dart';
import 'package:cmsc23_project/org-view/base_elements/base_screen.dart';
import 'package:cmsc23_project/org-view/base_elements/org_view_styles.dart';
import 'package:cmsc23_project/providers/current_org_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonationDetails extends StatefulWidget {
  final Donation donation;

  const DonationDetails({required this.donation, super.key});

  @override
  State<DonationDetails> createState() => _DonationDetailsState();
}

class _DonationDetailsState extends State<DonationDetails> {
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: Container(
        padding: const EdgeInsets.only(top: 20),
        child: Center(
          child: Column(
            children: [
              Text(widget.donation.donorUsername, style: CustomTextStyle.h1),
              const SizedBox(height: 30),
              _donationForm,
              const SizedBox(height: 30),
              _donationInfo,
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: CustomColors.primary,
        foregroundColor: CustomColors.secondary,
        child: const Icon(Icons.camera),
      ),
    );
  }

  Widget get _donationForm => Center(
        child: SizedBox(
          width: 400,
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(2),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Icon(Icons.sms, color: CustomColors.primary),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: _setStatus,
                  ),
                ],
              ),
              TableRow(
                children: [
                  const Icon(Icons.route, color: CustomColors.primary),
                  _setDrive,
                ],
              ),
            ],
          ),
        ),
      );

  Widget get _setStatus {
    List<Status> validStatuses = widget.donation.forPickup
        ? Status.values
        : Status.values
            .where((status) => status != Status.scheduledForPickup)
            .toList();

    return Row(
      children: [
        ...validStatuses.map((status) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: status == widget.donation.status
                  ? CustomColors.secondary
                  : Colors.transparent,
            ),
            child: IconButton(
              icon: statusIcon(status),
              onPressed: () {
                setState(() {
                  widget.donation.status = status;
                  context
                      .read<CurrentOrgProvider>()
                      .updateDonation(widget.donation);
                });
              },
            ),
          );
        }),
      ],
    );
  }

  Widget get _setDrive => DropdownMenu(
        inputDecorationTheme: const InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
        ),
        onSelected: (drive) {},
        dropdownMenuEntries:
            context.read<CurrentOrgProvider>().drives.map((drive) {
          return DropdownMenuEntry(value: drive, label: drive.name);
        }).toList(),
        /*widget.donationDrives.map((drive) {
          return DropdownMenuEntry<DonationDrive>(
            value: drive,
            label: drive.name,
          );
        }).toList(),*/
      );

  Widget get _donationInfo => Container(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Card(
          child: Container(
            padding: const EdgeInsets.only(top: 20),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1.5),
              },
              children: [
                categories(),
                weight(),
                forPickup(),
                address(),
                date(),
              ],
            ),
          ),
        ),
      );

  TableRow date() {
    DateTime date = widget.donation.scheduledDate;

    return TableRow(
      children: [
        const Icon(Icons.calendar_today, color: CustomColors.primary),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Text(
            '${date.month}/${date.day}/${date.year}',
            style: CustomTextStyle.body,
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
          child: Text(
            widget.donation.address,
            style: CustomTextStyle.body,
          ),
        ),
      ],
    );
  }

  TableRow forPickup() {
    return TableRow(
      children: [
        const Icon(Icons.local_shipping, color: CustomColors.primary),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: widget.donation.forPickup
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
            '${widget.donation.weight} kg',
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
          child: Text(
            widget.donation.categories.join(', '),
            style: CustomTextStyle.body,
          ),
        ),
      ],
    );
  }
}
