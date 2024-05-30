import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/textfield_providers.dart';

class DropdownMenuExample extends StatefulWidget {
  DropdownMenuExample({super.key});

  @override
  _DropdownMenuExampleState createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String dropdownValue = 'Pick up'; // Default value
  

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TextfieldProviders>();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5), // Color of the dropdown menu box
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 22,
        elevation: 16,
        style: TextStyle(
          color: const Color.fromRGBO(55, 61, 102, 1), // Color of the selected item text
          fontSize: 16,
        ),
        underline: const SizedBox(), // Remove the underline
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
            provider.updateShippingOpt(dropdownValue);
          });
        },
        items: <String>['Pick up', 'Drop-off']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(
                color: Color.fromRGBO(55, 61, 102, 1),
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold, 
                ), // Color of the dropdown item text
            ),
          );
        }).toList(),
      ),
    );
  }
}
