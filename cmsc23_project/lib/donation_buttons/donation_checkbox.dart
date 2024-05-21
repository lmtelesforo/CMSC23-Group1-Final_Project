import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/donation_provider.dart';

class DonationCheckbox extends StatelessWidget {
  final DonationItem item;

  DonationCheckbox({required this.item});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(item.itemName),
      value: item.isChecked,
      onChanged: (isChecked) {
        context.read<DonationProvider>().toggleItemCheck(item, isChecked!);
      },
    );
  }
}
