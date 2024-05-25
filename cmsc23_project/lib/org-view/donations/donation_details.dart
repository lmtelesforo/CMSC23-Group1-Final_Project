import 'package:cmsc23_project/models/donation.dart';
import 'package:cmsc23_project/models/donation_drive.dart';
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
              _EditDonation(widget.donation),
              const SizedBox(height: 30),
              _DonationInfo(widget.donation),
            ],
          ),
        ),
      ),
    );
  }
}

class _DonationInfo extends StatelessWidget {
  final Donation donation;
  const _DonationInfo(this.donation);

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
    DateTime date = donation.scheduledDate;

    return TableRow(
      children: [
        const Icon(Icons.calendar_today, color: CustomColors.primary),
        Text(
          '${date.month}/${date.day}/${date.year}',
          style: CustomTextStyle.body,
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
            donation.address,
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
          child: donation.forPickup
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
            '${donation.weight} kg',
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
            donation.categories.join(', '),
            style: CustomTextStyle.body,
          ),
        ),
      ],
    );
  }
}

class _EditDonation extends StatefulWidget {
  final Donation donation;
  const _EditDonation(this.donation);

  @override
  State<_EditDonation> createState() => _EditDonationState();
}

class _EditDonationState extends State<_EditDonation> {
  @override
  Widget build(BuildContext context) => Center(
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

  String? qrCodeValue;
  Widget get _setStatus {
    List<Status> statuses = widget.donation.validStatuses;

    return Column(
      children: [
        DropdownMenu(
          menuHeight: 200,
          initialSelection: statuses.indexOf(widget.donation.status),
          dropdownMenuEntries: statuses
              .map((status) => DropdownMenuEntry(
                    value: statuses.indexOf(status),
                    label: status.toString().split('.').last,
                    style: ButtonStyle(
                        textStyle:
                            MaterialStateProperty.all(CustomTextStyle.body)),
                  ))
              .toList(),
          onSelected: (status) {
            setState(() {
              widget.donation.status = statuses[status!];
              context
                  .read<CurrentOrgProvider>()
                  .updateDonation(widget.donation);
            });
          },
          inputDecorationTheme: InputDecorationTheme(
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          textStyle: CustomTextStyle.body,
        ),
        Visibility(
          visible: widget.donation.forPickup &&
              widget.donation.status == Status.complete &&
              qrCodeValue == null,
          child: SizedBox(
            height: 150,
            width: 180,
            child: Card(
              child: InkWell(
                onTap: () async {
                  qrCodeValue =
                      await Navigator.pushNamed(context, '/org/scan-qr')
                          as String;

                  if (qrCodeValue != null) {
                    setState(() {});
                  }
                },
                child: const Icon(Icons.qr_code),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget get _setDrive {
    List<DonationDrive> drives = context.read<CurrentOrgProvider>().drives;

    return DropdownMenu(
      menuHeight: 400,
      initialSelection:
          drives.indexWhere((drive) => drive.id == widget.donation.driveId),
      dropdownMenuEntries: drives
          .map((drive) => DropdownMenuEntry(
                value: drives.indexOf(drive),
                label: drive.name,
                style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(CustomTextStyle.body)),
              ))
          .toList(),
      onSelected: (drive) {
        setState(() {
          widget.donation.driveId = drives[drive!].id;
          context.read<CurrentOrgProvider>().updateDonation(widget.donation);
        });
      },
      width: MediaQuery.of(context).size.width * 0.51,
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      textStyle: CustomTextStyle.body,
    );
  }
}
