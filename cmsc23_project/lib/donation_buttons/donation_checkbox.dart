import 'package:flutter/material.dart';

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.itemName,
          style: TextStyle(
            fontSize: 19,
            fontFamily: "Montserrat",
            color: const Color.fromRGBO(55, 61, 102, 1),
          ),
        ),
        SizedBox(height: 50),
        Transform.scale(
          scale: 1.1,
          child: Checkbox(
            value: widget.isChecked,
            onChanged: widget.onChanged,
            activeColor: const Color.fromRGBO(55, 61, 102, 1),
            checkColor: Colors.white,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ],
    );
  }
}