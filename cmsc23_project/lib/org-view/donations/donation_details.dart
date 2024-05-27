import 'package:cmsc23_project/models/donation.dart';
import 'package:cmsc23_project/models/donation_drive.dart';
import 'package:cmsc23_project/org-view/base_elements/base_screen/base_screen.dart';
import 'package:cmsc23_project/org-view/base_elements/org_view_styles.dart';
import 'package:cmsc23_project/providers/current_org_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonationDetails extends StatelessWidget {
  const DonationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Donation donation = ModalRoute.of(context)!.settings.arguments as Donation;

    return BaseScreen(
      body: Container(
        padding: const EdgeInsets.only(top: 20),
        child: Center(
          child: Column(
            children: [
              Text(donation.donorUsername, style: CustomTextStyle.h1),
              const SizedBox(height: 30),
              _EditDonation(donation),
              const SizedBox(height: 30),
              _DonationInfo(donation),
            ],
          ),
        ),
      ),
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
  String? qrCodeValue;
  Donation? tempDonation;

  @override
  void initState() {
    super.initState();
    tempDonation = widget.donation.copy();
  }

  void saveChanges() {
    if (!widget.donation.forPickup && qrCodeValue == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please scan the QR code first'),
        ),
      );
      return;
    }

    setState(() {
      widget.donation.status = tempDonation!.status;
      widget.donation.driveId = tempDonation!.driveId;
      context.read<CurrentOrgProvider>().updateDonation(widget.donation);

      Navigator.pop(context);
    });
  }

  bool shouldShowQRCode() {
    return !widget.donation.forPickup &&
        widget.donation.status != tempDonation!.status &&
        qrCodeValue == null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          _form(context),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: saveChanges,
            style: const ButtonStyle(
              surfaceTintColor: MaterialStatePropertyAll(Colors.white),
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Table _form(BuildContext context) {
    return Table(
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
            const SizedBox(),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: shouldShowQRCode() ? 200 : 0,
              width: shouldShowQRCode() ? 200 : 0,
              child: Visibility(
                visible: shouldShowQRCode(),
                child: Card(
                  child: InkWell(
                    onTap: () async {
                      var value =
                          await Navigator.pushNamed(context, '/org/scan-qr');
                      setState(() {
                        qrCodeValue = value as String?;
                      });
                    },
                    child: const Icon(Icons.qr_code),
                  ),
                ),
              ),
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
    );
  }

  Widget get _setStatus {
    List<Status> statuses = widget.donation.validStatuses;

    return DropdownMenu(
      menuHeight: 200,
      width: MediaQuery.of(context).size.width * 0.51,
      initialSelection: statuses.indexOf(widget.donation.status),
      dropdownMenuEntries: statuses
          .map((status) => DropdownMenuEntry(
                value: statuses.indexOf(status),
                label: status.toString().split('.').last,
                style: ButtonStyle(
                    textStyle: MaterialStateProperty.all(CustomTextStyle.body)),
              ))
          .toList(),
      onSelected: (status) {
        setState(() {
          tempDonation!.status = statuses[status!];
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
    );
  }

  Widget get _setDrive {
    List<DonationDrive> drives = context.read<CurrentOrgProvider>().drives;

    return DropdownMenu(
      menuHeight: 400,
      width: MediaQuery.of(context).size.width * 0.51,
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
          tempDonation!.driveId = drives[drive!].id;
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
