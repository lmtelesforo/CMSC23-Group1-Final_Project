import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/donation_providers.dart'; 

class DonationCheckbox extends StatefulWidget {
  final bool isChecked;
  final String itemName;
  final ValueChanged<bool?> onChanged;

  const DonationCheckbox({
    required this.isChecked,
    required this.itemName,
    required this.onChanged,
    Key? key, 
  }) : super(key: key);

  @override
  _DonationCheckboxState createState() => _DonationCheckboxState();
}

class _DonationCheckboxState extends State<DonationCheckbox> {
  @override
  Widget build(BuildContext context) {
    final donationProvider = context.watch<DonationProvider>(); // Update provider

    return CheckboxListTile(
      title: Text(
        widget.itemName,
        style: const TextStyle(
          fontSize: 16,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.bold,
          color: Color.fromRGBO(55, 61, 102, 1),
        ),
      ),
      value: widget.isChecked,
      onChanged: (newValue) {
        setState(() {
          widget.onChanged(newValue); // Trigger the onChanged callback
        });
      },
      activeColor: const Color.fromRGBO(55, 61, 102, 1),
      checkColor: Colors.white,
      controlAffinity: ListTileControlAffinity.trailing,
    );
  }
}
