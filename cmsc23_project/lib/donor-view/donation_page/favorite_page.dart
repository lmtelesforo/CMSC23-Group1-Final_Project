import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cmsc23_project/providers/donation_providers.dart';
import 'donor_page.dart';

class FavoritePage extends StatelessWidget {
   
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> donorDetails = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorite Organizations",
          style: TextStyle(
            fontFamily: "Montserrat",
            color: const Color.fromRGBO(55, 61, 102, 1),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        iconTheme: IconThemeData(color: const Color.fromRGBO(55, 61, 102, 1)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
          Navigator.pop(context);
          },
        ),
      ),
      body: Consumer<DonationProvider>(
        builder: (context, donationProvider, child) {
          final favoriteOrganizations = donationProvider.getFavoriteOrganizations();

          if (favoriteOrganizations.isEmpty) {
            return Center(
              child: Text(
                "No favorite organizations selected",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontFamily: "Montserrat",
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: favoriteOrganizations.length,
            itemBuilder: (context, index) {
              final org = favoriteOrganizations[index];
              return ListTile(
                title: Text(org),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DonorPage(organization: org, donorDetails: donorDetails),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}