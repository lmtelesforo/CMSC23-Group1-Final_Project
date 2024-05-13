import 'package:flutter/material.dart';

class DonorPage extends StatefulWidget {
  final String organization;

  DonorPage({required this.organization});

  @override
  _DonorPageState createState() => _DonorPageState();
}

class _DonorPageState extends State<DonorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Donor Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Selected Organization:",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              widget.organization,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Navigate back to the previous screen
              },
              child: Text("Go Back"),
            ),
          ],
        ),
      ),
    );
  }
}
