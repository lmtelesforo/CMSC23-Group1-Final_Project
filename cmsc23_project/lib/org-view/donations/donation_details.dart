import 'package:cmsc23_project/models/donation_drive.dart';
import 'package:cmsc23_project/models/indiv_donation.dart';
import 'package:cmsc23_project/org-view/base_elements/base_screen/base_screen.dart';
import 'package:cmsc23_project/org-view/base_elements/org_view_styles.dart';
import 'package:cmsc23_project/org-view/donations/donation_info.dart';
import 'package:cmsc23_project/providers/current_org_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonationDetails extends StatelessWidget {
  const DonationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final List args = ModalRoute.of(context)!.settings.arguments as List;
    final Donation donation = args[0] as Donation;
    final String id = args[1] as String;

    return BaseScreen(
      body: Container(
        padding: const EdgeInsets.only(top: 20),
        child: Center(
          child: Column(
            children: [
              Text(donation.name, style: CustomTextStyle.h1),
              const SizedBox(height: 30),
              _EditDonation(donation, id),
              const SizedBox(height: 30),
              DonationInfo(donation),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class _EditDonation extends StatefulWidget {
  final Donation donation;
  final String id;

  const _EditDonation(this.donation, this.id);

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
    if (widget.donation.shipping == 'Drop-off' &&
        qrCodeValue == null &&
        tempDonation!.status != widget.donation.status) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please scan the QR code first'),
        ),
      );
      return;
    }

    context
        .read<CurrentOrgProvider>()
        .changeDonationStatus(widget.id, tempDonation!.status);
    context
        .read<CurrentOrgProvider>()
        .changeDonationDrive(widget.id, tempDonation!.driveName);

    Navigator.pop(context);
  }

  bool shouldShowQRCode() {
    return widget.donation.shipping == 'Drop-off' &&
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
              surfaceTintColor: WidgetStatePropertyAll(Colors.white),
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
                        if (value == widget.donation.qrcode) {
                          qrCodeValue = value as String?;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('QR code scanned successfully'),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Invalid QR code'),
                            ),
                          );
                        }
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
    List<String> statuses = widget.donation.validStatuses;

    return DropdownMenu(
      menuHeight: 200,
      width: MediaQuery.of(context).size.width * 0.51,
      initialSelection: statuses.indexOf(widget.donation.status),
      dropdownMenuEntries: statuses
          .map((status) => DropdownMenuEntry(
                value: statuses.indexOf(status),
                label: status.toString().split('.').last,
                style: ButtonStyle(
                    textStyle: WidgetStateProperty.all(CustomTextStyle.body)),
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
    return StreamBuilder(
        stream: context.read<CurrentOrgProvider>().drives,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('An error occurred');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          List<DonationDrive> drives = snapshot.data!.docs
              .map((drive) =>
                  DonationDrive.fromJson(drive.data() as Map<String, dynamic>))
              .toList();

          return DropdownMenu(
            menuHeight: 400,
            width: MediaQuery.of(context).size.width * 0.51,
            initialSelection: drives
                .indexWhere((drive) => drive.name == widget.donation.driveName),
            dropdownMenuEntries: drives
                .map((drive) => DropdownMenuEntry(
                      value: drives.indexOf(drive),
                      label: drive.name,
                      style: ButtonStyle(
                          textStyle:
                              WidgetStateProperty.all(CustomTextStyle.body)),
                    ))
                .toList(),
            onSelected: (drive) {
              tempDonation!.driveName = drives[drive!].name;
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
        });
  }
}
