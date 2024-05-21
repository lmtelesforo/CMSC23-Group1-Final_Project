// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'donation_page/donor_homepage.dart';
import 'provider/donation_provider.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => DonationProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DonorHomepage(),
    );
  }
}
